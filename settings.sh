#/bin/sh

#-----------------------------------------------------------------
install_depend()
{
	sudo apt install python-dev npm cmake git
}

#-----------------------------------------------------------------
install_vundle()
{
	local plug_path="$1/vundle"

	if [ ! -d $plug_path ]; then
		git clone https://github.com/gmarik/vundle.git $plug_path
	fi
}

#-----------------------------------------------------------------
install_tfv()
{
	local plug_path="$1/tern_for_vim"

	if [ ! -d $plug_path ]; then
		git clone http://github.com/ternjs/tern_for_vim.git $plug_path && \
			cd $plug_path && \
			npm install
	fi
}

#-----------------------------------------------------------------
install_ycm()
{
	local plug_path="$1/YouCompleteMe"

	if [ ! -d $plug_path ]; then
		git clone --recursive https://github.com/Valloric/YouCompleteMe.git $plug_path
		cd $plug_path && git submodule update --init --recursive
	else
		cd $plug_path
	fi

	[ -d $plug_path ] && ./install.sh --clang-completer
}

#-----------------------------------------------------------------
set_vim_link()
{
	[ -L ~/.vim-using ]  && rm -f ~/.vim-using
	[ -L ~/.vim ]        && rm -f ~/.vim
	[ -f ~/.viminfo ]    && rm -f ~/.viminfo
	[ -L ~/.viminfo ]    && rm -f ~/.viminfo
	[ -L ~/.vimrc ]      && rm -f ~/.vimrc

	ln -s ~/.vim-config ~/.vim-using

	ln -s ~/.vim-using/vimfiles  ~/.vim
	ln -s ~/.vim-using/_viminfo  ~/.viminfo
	ln -s ~/.vim-using/_vimrc    ~/.vimrc
}

#-----------------------------------------------------------------
help_usage()
{
	echo 'please do:'
	echo '  1. do vim command in vim: BundleInstall'
}

#-----------------------------------------------------------------
main()
{
	local start_path="$PWD"
	local bundle_path="$HOME/.vim/bundle"

	set_vim_link

	install_depend
	install_vundle $bundle_path
	install_ycm $bundle_path
	install_tfv $bundle_path

	cd $start_path

	echo 'done'
}

main

help_usage

