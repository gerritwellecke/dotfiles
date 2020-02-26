#!/bin/bash

# copy vimrc to home if executed from downloaded directory
if [ -f "setup.sh" ] && [ -f ".vimrc" ]; then
    echo "Copying vimrc and snippet files"
    cp .vimrc ~
fi

# download Vundle plugin manager
if [ ! -d "~/.vim/bundle" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# install plugins
vim +PluginInstall +qall

# install YouCompleteMe
python3 ~/.vim/bundle/YouCompleteMe/install.py --clang-completer

# copy snippet files to UltiSnips directory
cp *.snippets ~/.vim/bundle/UltiSnips

# done
echo "VIM setup done"
