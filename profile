export TERM="xterm-color"
export EDITOR=vim
# MacPorts Installer addition on 2011-06-26_at_19:07:32: adding an appropriate PATH variable for use with MacPorts.
export PATH=$HOME/bin:$HOME/.rbenv/bin:/usr/local/share/npm/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"

export CC=clang
export CFLAGS="-O2 -arch x86_64"
export LDFLAGS="-L/opt/local/lib"
export CPPFLAGS="-I/opt/local/include"

# LDFLAGS:  -L/usr/local/opt/gettext/lib
# CPPFLAGS: -I/usr/local/opt/gettext/include

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# History controls
shopt -s histappend
export HISTIGNORE='&:ls:cd ~:cd ..:[bf]g:exit:h:history'
export HISTCONTROL=erasedups

#rbenv
eval "$(rbenv init -)"


# ALIAS'
alias t='script/test'
alias tt='bundle exec rake test'
alias b='bundle exec'
alias z='zeus'
alias cdlast='cd $OLDPWD'

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Prompt
export PS1="\n\[\e[0;36m\]\u@\h\[\e[m\] \[\e[0;34m\]\w\[\e[m\]\[\e[0;33m\]\$(__git_ps1)\[\e[m\]\n\$ "


#functions
function binstubs_on {
    export PATH=./bin:$PATH
}

# Add the following to your ~/.bashrc or ~/.zshrc
#
# Alternatively, copy/symlink this file and source in your shell.  See `hitch --setup-path`.

hitch() {
  command hitch "$@"
  if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
}
alias unhitch='hitch -u'

# bash
# No ttyctl, so we need to save and then restore terminal settings
vim() {
    local STTYOPTS="$(stty -g)"
    stty stop '' -ixoff
    command vim "$@"
    stty "$STTYOPTS"
}
source $HOME/.bash_personal
