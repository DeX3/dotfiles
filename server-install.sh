#!/bin/sh

mkdir -p ~/.vim/backup
mkdir -p ~/.vim/tmp

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
