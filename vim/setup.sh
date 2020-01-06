#!/bin/bash

# copy vimrc to home if executed from downloaded directory
if [ -f "setup.sh" ] && [ -f ".vimrc" ]; then
    cp .vimrc ~
    mkdir ~/snippets_temp
    cp *.snippets ~/snippets_temp/
fi

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

# move snippets into Ultisnips directory
mv ~/snippets_temp/* ~/.vim/bundle/UltiSnips/
rmdir ~/snippets_temp/

# done
echo "VIM setup successful"
