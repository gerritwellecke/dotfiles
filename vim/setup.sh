#!/bin/bash

SUCCESS=1

# copy vimrc to home if executed from downloaded directory
if [ -f "setup.sh" ] && [ -f ".vimrc" ]; then
    echo "Copying vimrc and snippet files"
    cp .vimrc ~
fi

# install plugins
vim +PlugInstall +qall
if [[ "$?" != "0" ]]; then
    SUCCESS=0
fi

# copy snippet files to UltiSnips directory
cp *.snippets ~/.vim/bundle/UltiSnips
if [[ "$?" != "0" ]]; then
    SUCCESS=0
fi

# done
if [[ "$SUCCESS" == "1" ]]; then
    echo "VIM setup done"
    exit 0
else
    echo "Error while setting up Vim"
    exit 1
fi
