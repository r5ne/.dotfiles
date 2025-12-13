" map leader key
let g:mapleader=" "
let g:maplocalleader=" "

" relative line numbers except on the current line
set number
set relativenumber

" disable wrapping when line is too long
set nowrap

" disable unsaved file recovery
set noswapfile

" set default tabstop
set tabstop=4
" set default shift width (when indenting and unindenting whole lines)
set shiftwidth=4
" convert tabs to spaces
set expandtab

" enable highlighting searched for words
set hlsearch

" keybind for sourcing the vimrc
" :update only writes the file if the contents have actually changed
" :source when ran without any commands automatically sources .vimrc
nnoremap <leader>o :update<CR>:source ~/.vimrc<CR>
" keybind for writing files
nnoremap <leader>w :write<CR>
" keybind for quitting files
nnoremap <leader>q :quit<CR>
" keybinds for creating a new line above and below the caret without entering insert mode
nnoremap <CR> o<Esc>
nnoremap <S-CR> O<Esc>

" allows monoglow-lack to work with the foot terminal emulator
set termguicolors
set t_Co=256
" set a custom colorscheme
colorscheme monoglow-lack
" enable syntax highlighting
syntax enable

