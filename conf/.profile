# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

if [[ $(uname) == "Linux" ]]; then
    if [ -d "/usr/local/texlive/2016" ]; then
        export PATH=/usr/local/texlive/2016/bin/x86_64-linux:$PATH
        export INFOPATH=/usr/local/texlive/2016/texmf-dist/doc/info:$INFOPATH
        export MANPATH=/usr/local/texlive/2016/texmf-dist/doc/man:$MANPATH
    fi
elif [[ $(uname) == "Darwin" ]]; then
    export PATH=$PATH:/Library/TeX/texbin
    export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/Cellar/opencv3/3.2/lib/pkgconfig
fi

venv () {
    source ~/venvs/$1/bin/activate
}

newvenv() {
    python3 -m venv ~/venvs/$1
}

cdc() {
    PORT=$(printf "2%03d" $1)
    ssh -p $PORT kchen@cdcgw.ie.cuhk.edu.hk
}

ws() {
    ssh kchen@192.168.72.$1
}

alias vim="nvim"
alias ll="ls -alFh"
alias l="ls -alFh"
alias sshsz="ssh kchen@120.77.49.217"
alias sshqd="ssh kchen@gzhplus.com"

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
