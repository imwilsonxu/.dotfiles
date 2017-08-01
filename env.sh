# -------
# General
# -------

# Commands history
# http://www.thegeekstuff.com/2008/08/15-examples-to-master-linux-command-line-history/
# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
# Eliminate the repeated commands.
export HiSTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups
# Make some commands not show up in history
export HISTIGNORE="ls:ls *"

# Use vim
export EDITOR='vim'
set -o vi

# -------
# Aliases
# -------

alias v='vim -p'
alias c='clear'
alias e='exit'
alias ..="cd .."
alias ...="cd ../.."
alias py='python'
alias py3='python3'

alias zshconfig="vim ~/.zshrc"
alias vimconfig="vim ~/.vimrc"
alias gitconfig="vim ~/.gitconfig"

# grep
export GREP_OPTIONS='--color=always'
alias pygrep='grep --include=*.py -Ir '
alias htmlgrep='grep --include=*.html -Ir '
alias jsgrep='grep --include=*.js -Ir '

# ---------
# Functions
# ---------

function f() { find . -iname "*$1*" ${@:2} }

function r() { grep "$1" ${@:2} -R . }

function mkcd() { mkdir -p "$@" && cd "$_"; }

psgrep() {
    if [ ! -z $1 ] ; then
        echo "Grepping for processes matching $1..."
        ps aux | grep $1 | grep -v grep
    else
        echo "!! Need name to grep for"
    fi
}

grab() {
    sudo chown -R ${USER} ${1:-.}
}

#netinfo - shows network information for your system
netinfo() {
    echo "--------------- Network Information ---------------"
    /sbin/ifconfig | awk /'inet addr/ {print $2}'
    /sbin/ifconfig | awk /'Bcast/ {print $3}'
    /sbin/ifconfig | awk /'inet addr/ {print $4}'
    /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
    myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
    echo "${myip}"
    echo "---------------------------------------------------"
}

dirsize() {
    du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
    egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
    egrep '^ *[0-9.]*M' /tmp/list
    egrep '^ *[0-9.]*G' /tmp/list
    rm -rf /tmp/list
}

function rp() {
    if [[ $# == 3 ]]; then
        pattern=$1
        replacement=$2
        filename=$3
        echo "$pattern -> $replacement in $filename"
        mv "$filename" "$filename.old"
        sed "s/$pattern/$replacement/g" < "$filename.old" > "$filename"
    fi
}

function lla(){
 	ls -l  "$@" | awk '
    {
      k=0;
      for (i=0;i<=8;i++)
        k+=((substr($1,i+2,1)~/[rwx]/) *2^(8-i));
      if (k)
        printf("%0o ",k);
      printf(" %9s  %3s %2s %5s  %6s  %s %s %s\n", $3, $6, $7, $8, $5, $9,$10, $11);
    }'
}
