# dotfiles
jobless dotfiles for a jobless CS major
## Usage
### Setup
- Clone the repo into your `$HOME` directory using `git clone git@github/r5ne/dotfiles.git ~`.
- Symlink `.stowrc` into your `$HOME` directory using `ln -s ~/.dotfiles/.stowrc ~/` on unix and \[todo] on windows.
### Adding packages
- Use `stow [package name]` to add the config files of [package name]. Make sure to read the README.md to make sure you have acquired all the dependencies.
### Changing packages
- Delete any old symlinks using `stow -D [package name]`. Make sure to delete any dependencies as well.
## Format
- A new directory for each modular dotfiles I will want to use (usually translates to one program)
- Packages with -deps in the name shouldn't be stowed unless another package explicitly requires it - read the README.md for info on package dependencies.
## Credits
- [monoglow.nvim](https://github.com/wnkz/monoglow.nvim) - for the colorscheme used by most of my dots
- [gnu stow](https://www.gnu.org/software/stow/) - for the best modular dotfile manager
