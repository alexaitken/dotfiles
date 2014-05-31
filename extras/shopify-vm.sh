if ! vim --version | grep -q "+ruby"; then
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

vim +BundleInstall +qall

echo "Compiling commandt..."
(
  cd $HOME/.vim/bundle/Command-T/ruby/command-t
  source /usr/local/share/chruby/chruby.sh
  ruby extconf.rb
  make clean
  make
)

if ! tmux --version | grep -q "1.9a"; then
  cd /tmp
  wget http://downloads.sourceforge.net/tmux/tmux-1.9a.tar.gz

  tar xzf tmux-1.9a.tar.gz
  cd tmux-1.9a
  ./configure
  make
  sudo make install
fi
