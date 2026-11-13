#define _POSIX_C_SOURCE 200809L
#include <ctype.h>
#include <fcntl.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

#define MAX_IPC_BUF (4 * 1024 * 1024)

static bool write_all(int fd, const char *buf, size_t len) {
    size_t sent = 0;
    while (sent < len) {
        ssize_t n = write(fd, buf + sent, len - sent);
        if (n <= 0) return false;
        sent += (size_t)n;
    }
    return true;
}

/* Scans Niri's single-line JSON reply for an object matching "app_id" and returns its "id". */
static long find_window_id(const char *json, const char *target_app_id) {
    size_t target_len = strlen(target_app_id);
    long current_id = -1;

    for (const char *p = json; *p; p++) {
        if (*p != '"') continue;

        const char *key_start = p + 1;
        const char *key_end = key_start;
        while (*key_end && *key_end != '"') {
            if (*key_end == '\\' && *(key_end + 1)) key_end++;
            key_end++;
        }
        if (!*key_end) break;

        size_t klen = (size_t)(key_end - key_start);
        const char *after_key = key_end + 1;
        while (*after_key == ' ' || *after_key == '\t') after_key++;

        if (*after_key == ':') {
            const char *val = after_key + 1;
            while (*val == ' ' || *val == '\t') val++;

            if (klen == 2 && memcmp(key_start, "id", 2) == 0 && isdigit((unsigned char)*val)) {
                current_id = strtol(val, NULL, 10);
            } else if (klen == 6 && memcmp(key_start, "app_id", 6) == 0) {
                if (*val == '"') {
                    const char *vstart = val + 1;
                    const char *vend = vstart;
                    while (*vend && *vend != '"') {
                        if (*vend == '\\' && *(vend + 1)) vend++;
                        vend++;
                    }
                    if ((size_t)(vend - vstart) == target_len &&
                        memcmp(vstart, target_app_id, target_len) == 0 &&
                        current_id >= 0) {
                        return current_id;
                    }
                }
                current_id = -1;
            }
        }
        p = key_end;
    }
    return -1;
}

static bool try_focus_niri(const char *app_id) {
    const char *sock_path = getenv("NIRI_SOCKET");
    if (!sock_path || !*sock_path) return false;

    struct sockaddr_un addr = {0};
    if (strlen(sock_path) >= sizeof(addr.sun_path)) return false;

    int fd = socket(AF_UNIX, SOCK_STREAM, 0);
    if (fd < 0) return false;
    fcntl(fd, F_SETFD, FD_CLOEXEC);

    addr.sun_family = AF_UNIX;
    memcpy(addr.sun_path, sock_path, strlen(sock_path) + 1);

    if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
        close(fd);
        return false;
    }

    if (!write_all(fd, "\"Windows\"\n", 10)) {
        close(fd);
        return false;
    }

    size_t cap = 8192;
    size_t len = 0;
    char *buf = malloc(cap);
    if (!buf) {
        close(fd);
        return false;
    }

    bool got_line = false;
    while (!got_line) {
        if (len + 4096 + 1 > cap) {
            if (cap >= MAX_IPC_BUF) break;
            cap *= 2;
            char *tmp = realloc(buf, cap);
            if (!tmp) break;
            buf = tmp;
        }
        ssize_t n = read(fd, buf + len, cap - len - 1);
        if (n <= 0) break;
        if (memchr(buf + len, '\n', (size_t)n)) got_line = true;
        len += (size_t)n;
    }
    buf[len] = '\0';

    bool focused = false;
    if (got_line) {
        long wid = find_window_id(buf, app_id);
        if (wid >= 0) {
            char cmd[128];
            int cmd_len = snprintf(cmd, sizeof(cmd), "{\"Action\":{\"FocusWindow\":{\"id\":%ld}}}\n", wid);
            if (cmd_len > 0 && (size_t)cmd_len < sizeof(cmd) && write_all(fd, cmd, (size_t)cmd_len)) {
                char ack[256];
                if (read(fd, ack, sizeof(ack)) > 0) focused = true;
            }
        }
    }

    free(buf);
    close(fd);
    return focused;
}

int main(int argc, char **argv) {
    const char *app_id = NULL;
    const char *size = "120x40";
    int i = 1;

    while (i < argc) {
        if (strcmp(argv[i], "-a") == 0) {
            if (++i >= argc) {
                fprintf(stderr, "Usage: %s [-a app_id] [-s WxH] command [args...]\n", argv[0]);
                return 1;
            }
            app_id = argv[i++];
        } else if (strcmp(argv[i], "-s") == 0) {
            if (++i >= argc) {
                fprintf(stderr, "Usage: %s [-a app_id] [-s WxH] command [args...]\n", argv[0]);
                return 1;
            }
            size = argv[i++];
        } else {
            break;
        }
    }

    int cmd_argc = argc - i;
    if (cmd_argc <= 0) {
        fprintf(stderr, "Usage: %s [-a app_id] [-s WxH] command [args...]\n", argv[0]);
        return 1;
    }

    if (app_id && try_focus_niri(app_id)) {
        return 0;
    }

    char size_flag[64];
    char app_flag[256];
    snprintf(size_flag, sizeof(size_flag), "--window-size-chars=%s", size);

    char **exec_argv = malloc(((size_t)cmd_argc + 4) * sizeof(char *));
    if (!exec_argv) return 1;

    int idx = 0;
    exec_argv[idx++] = "footclient";
    exec_argv[idx++] = size_flag;
    if (app_id) {
        snprintf(app_flag, sizeof(app_flag), "--app-id=%s", app_id);
        exec_argv[idx++] = app_flag;
    }
    for (int j = 0; j < cmd_argc; j++) {
        exec_argv[idx++] = argv[i + j];
    }
    exec_argv[idx] = NULL;

    execvp("footclient", exec_argv);
    perror("execvp footclient");
    free(exec_argv);
    return 1;
}
