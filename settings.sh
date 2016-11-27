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
	cd $HOME

	mv $1 $HOME/.vim-config

	[ -L $HOME/.vim-using ]  && rm -f $HOME/.vim-using
	[ -L $HOME/.vim ]        && rm -f $HOME/.vim
	[ -f $HOME/.viminfo ]    && rm -f $HOME/.viminfo
	[ -L $HOME/.viminfo ]    && rm -f $HOME/.viminfo
	[ -L $HOME/.vimrc ]      && rm -f $HOME/.vimrc

	ln -s $HOME/.vim-config $HOME/.vim-using

	ln -s $HOME/.vim-using/vimfiles  $HOME/.vim
	ln -s $HOME/.vim-using/_viminfo  $HOME/.viminfo
	ln -s $HOME/.vim-using/_vimrc    $HOME/.vimrc
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

	set_vim_link $start_path

	install_depend
	install_vundle $bundle_path
	#install_ycm $bundle_path
	install_tfv $bundle_path

	cd $HOME

	echo 'done'
}

main

help_usage

