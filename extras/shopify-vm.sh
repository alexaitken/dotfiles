if ! vim --version | grep -q "+ruby"; then
  VIM_VERSION='7.4'
  echo "Installing Vim 7.4 with Ruby support..."
  (
    cd /tmp
    source /usr/local/share/chruby/chruby.sh
    ruby --version

    wget "ftp://ftp.vim.org/pub/vim/unix/vim-$VIM_VERSION.tar.bz2"
    tar xjf "vim-$VIM_VERSION.tar.bz2"
    cd vim74
    ./configure --enable-rubyinterp
    make --jobs "$(cores)"
    sudo make install
  )

  # Refresh links
  hash -r
fi
# Clone vundle into the directory if it's not already
if [[ ! -e ~/.vim/bundle/vundle/.git ]]
then
  mkdir -p ~/.vim/bundle
  rm -rf ~/.vim/bundle/vundle
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi

vim +BundleInstall +qall

if [[ ! ~/.vim/bundle/Command-T/ruby/command-t/ext.so ]]
then
  echo "Compiling commandt..."
  (
    cd $HOME/.vim/bundle/Command-T/ruby/command-t
    source /usr/local/share/chruby/chruby.sh
    ruby extconf.rb
    make clean
    make
  )
fi

if ! tmux -V | grep -q "1.9a"; then
  cd /tmp
  wget http://downloads.sourceforge.net/tmux/tmux-1.9a.tar.gz

  tar xzf tmux-1.9a.tar.gz
  cd tmux-1.9a
  ./configure
  make
  sudo make install
fi
