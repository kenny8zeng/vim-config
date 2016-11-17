#/bin/sh

git clone https://github.com/gmarik/vundle.git vimfiles/bundle/vundle

[ -L ~/.vim-using ]  && rm -f ~/.vim-using
[ -L ~/.vim ]        && rm -f ~/.vim
[ -f ~/.viminfo ]    && rm -f ~/.viminfo
[ -L ~/.viminfo ]    && rm -f ~/.viminfo
[ -L ~/.vimrc ]      && rm -f ~/.vimrc

ln -s ~/.vim-config ~/.vim-using

ln -s ~/.vim-using/vimfiles  ~/.vim
ln -s ~/.vim-using/_viminfo  ~/.viminfo
ln -s ~/.vim-using/_vimrc    ~/.vimrc

