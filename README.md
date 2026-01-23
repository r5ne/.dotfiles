# dotfiles
jobless dotfiles for a jobless CS major
## Usage
### Setup
- Clone the repo into your `$HOME` directory using `git clone https://github.com/r5ne/dotfiles ~`.
- Symlink `.stowrc` into your `$HOME` directory using `ln -s ~/.dotfiles/.stowrc ~/` on unix and \[todo] on windows.
- Run `stow [package name]` if the package has no specific subpackages and `stow --dir=$HOME/.dotfiles/[package name] [os specific subpackage]` if there are.
### Changing packages
- Delete any old symlinks using `stow -D [package name]` if the package has no specific subpackages and `stow -D --dir=$HOME/.dotfiles/[package name] [subpackage]` if there are.
## Format
- A new directory for each modular dotfiles I will want to use (usually translates to one program)
- A subdirectory if the dots require multiple versions based on factors such as OS or screen resolution.
## Credits
- [monoglow.nvim](github.com/wnkz/monoglow.nvim) - for the colorscheme used by most of my dots
- [gnu stow](https://www.gnu.org/software/stow/) - for the best modular dotfile manager
