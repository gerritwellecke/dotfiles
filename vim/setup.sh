#!/bin/bash -x

# change into HOME directory
cd ~

# download Vundle plugin manager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install plugins
vim +PluginInstall +qall

# install YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer

# return to HOME directory
cd ~

# done
echo "VIM setup successful"
