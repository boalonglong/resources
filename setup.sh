#!/bin/sh
if [[ -d ~/.vim/bundle ]]
then
	echo "directory has exist"
else
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
ln -sf `pwd`/.vimrc /home/yulong.wyl/.vimrc
