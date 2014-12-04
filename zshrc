#prompt off
#PROMPT="%{$fg[pink]%}%n%{$reset_color%}@%{$fg[green]%}%m %{$fg_no_bold[blue]%}%1~ %{$reset_color%}%#"
#RPROMPT="[%{$fg_no_bold[pink]%}%?%{$reset_color%}]"
PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg_no_bold[yellow]%}%1~ %{$reset_color%}%#"
RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

# Path to your oh-my-zsh configuration.
ZSH=/usr/share/oh-my-zsh/
#source auto-fu.zsh

autoload -U promptinit
promptinit
autoload -U compinit
compinit
zstyle ':completion:*' menu select
setopt completealiases

export MARKPATH=$HOME/.marks
  function jump {
      cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark: $1"
  }
mark() {
    mkdir -p $MARKPATH
    mark=${1:-$(basename $PWD)}
    ln -s $(pwd) $MARKPATH/$mark && alias $mark="jump $mark"
}

  function unmark {
      rm -if $MARKPATH/$1
  }
  function marks {
      ls -l $MARKPATH | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
  }

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="random"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
  COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)

plugins=(autojump terminator wakeonlan extract sublime tmux copyfile copydir colorize colored-man)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

#Aliases Pacman
alias pacyy='sudo pacman -Syy'
alias pacsu='sudo pacman -Su'
alias pacs='sudo pacman -Syyu'
alias pacsi='sudo pacman -S'
alias pacss='sudo pacman -Ss'
alias upac='sudo pacman -U'
alias yaursu='yaourt -Su --aur'
alias yaurss='yaourt -Ss'
alias yaursi='yaourt -Si'
alias ryaur='yaourt -R'
alias rsnyaur='yaourt -Rsn'
alias yaur='yaourt -S'

#Aliases Configurations
alias nan='sudo nano'
alias nbash='sudo nano ~/.bashrc'
alias nhist='sudo nano ~/.bash_history'
alias xtn='sudo nano ~/Documents/DailyNotes.T420.EVO.9.10.14.txt'
alias nix='sudo nano ~/.xinitrc'
alias nstab='sudo nano /etc/fstab'
alias ncpio='sudo nano /etc/mkinitcpio.conf'
alias l='ls -lAh --color'
alias zash='sudo nano ~/.zshrc'
alias sx='startx'
alias zhist='sudo nano ~/.zsh_history'
alias zan='sudo nano'

#Alias zsh
alias zrc='source ~/.zshrc'

#Active Network Connections
spy () { lsof -i -P +c 0 +M | grep -i "$1"
}

#function
function psgrep () { ps aux | grep "$@" -i --color=auto; }

#Tail with search highlight
t() {
tail -f $1 | perl -pe "s/$2/\e[1;31;43m$&\e[0m/g"
}

#Remove Duplicate Lines Awk
#function awkniq() { awk '!seen[$0]++' 
#}

#alias akniq='awk '!seen[$0]++''

#MultiMerge
mmerge () { for file in *.txt
do
   cat "$file" >> result
   echo >> result
done
}

#Aliases Networking
alias listips='sudo nmap -sS -O 192.168.0.1/24'
alias listen='sudo lsof -i -P | grep LISTEN'
#alias ethup='sudo dhcpcd enp0s25'
alias ntcp='sudo netstat -alnp | grep -i list | grep -i tcp | sort'

function psgrep () { ps axuf | grep -v grep | grep "$@" -i --color=auto;
}

#Aliases Bash
alias freq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'
alias ralias='source ~/.bashrc'
alias duks='du -ks *|sort -n'
alias pralias='source ~/.bash_profile'
alias k9='sudo kill -9'
alias dums='du -cms *|sort -rn|head -11' #largest f/d in dir in Mbs
alias inet='ifconfig | grep inet'
alias off='sudo systemctl poweroff'
alias rbt='sudo reboot'

#Remove Specific Line From Known Hosts
function rmh() { sed -i "$1d" ~/.ssh/known_hosts; }

#Recursive directory listing
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\$

#alias l.=' ls -d.* --color=auto'

#Aliases System
alias memuse=' ps -o time,ppid,pid,nice,pcpu,pmem,user,comm -A | sort -n -k 6 | tail -15'
alias l.='ls -d .* --color=auto'
alias lf='ls -alF'
alias la='ls -A'
alias lc='ls -CF'
alias lg='ls -G'
alias lag='ls -AhGp'

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

#Encryption

function encry() {
    gpg -ac --no-options "$1"
}

function decry() {
    gpg --no-options "$1"
}

    ranger-cd() {
       tempfile=$(mktemp)
       ranger --choosedir="$tempfile" "${@:-$(pwd)}" < $TTY
       test -f "$tempfile" &&
       if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
         cd -- "$(cat "$tempfile")"
       fi
       rm -f -- "$tempfile"
     }

export MARKPATH=$HOME/.marks
function g { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

function _completemarks {
  reply=($(ls $MARKPATH))
}

compctl -K _completemarks g
compctl -K _completemarks unmark
eval $(dircolors -b $HOME/.dircolors)
source ~/.fzf.zsh
alias pacu='sudo pacman -Su'
#alias acoc='/home/oorollergirloo/.gem/ruby/2.1.0/bin/acoc'
alias acoc='/home/oorollergirloo/.gem/ruby/2.1.0/bin/acoc'
alias psmem='sudo ps_mem'
alias tuanp='netstat -tuanp | grep LISTEN'
