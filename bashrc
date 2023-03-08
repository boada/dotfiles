
########################
# Bash prompt customization. Sets the prompt color and truncates it to make
# sure it doesn't get too long.
########################

color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval              "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


s="\[\033"       # color start
nc="$s[00m\]"    # no color
red="$s[00;31m\]"
green="$s[01;32m\]"
yellow="$s[00;33m\]"
blue="$s[01;34m\]"
purple="$s[00;35m\]"
cyan="$s[00;36m\]"
white="$s[01;37m\]"
#red="$s[0;38;5;1m\]"
#green="$s[0;38;5;2m\]"
smoothgreen="$s[0;38;5;42m\]"
#yellow="$s[0;38;5;3m\]"
#blue="$s[0;38;5;4m\]"
bblue="$s[0;38;5;12m\]"
coldblue="$s[0;38;5;33m\]"
smoothblue="$s[0;38;5;111m\]"
iceblue="$s[0;38;5;45m\]"
white="$s[0;38;5;7m\]"
black="$s[0;38;5;0m\]"
orange="$s[0;38;5;130m\]"
magenta="$s[0;38;5;55m\]"
cyan="$s[0;38;5;6m\]"
turqoise="$s[0;38;5;50m\]"

trunclen=20
# This is a LONG line that I didn't want to break up here.
truncated_path='$(echo -n "${PWD/#$HOME/~}" | awk -F "/" '"'"'{if (length($0) > '"$trunclen"') { if (NF>4) print $1 "/" $2 "/.../" $(NF-1) "/" $NF; else if (NF>3) print $1 "/" $2 "/.../" $NF; else print $1 "/.../" $NF; } else print $0;}'"'"')'

# "who am i" is a check to see if logged in over ssh
if [[ -n "$(who am i | grep \()" ]]; then
    user=${red}
    host=${red}
    path=${white}
else
    user=${smoothgreen}
    host=${smoothgreen}
    path=${coldblue}
fi
user+="\u"
host+="\h"${nc}:
path+='$(eval "echo ${truncated_path}")'${nc}"$ "

PS1=${user}@${host}${path}${nc}

# If this is an xterm, set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

##################
# Custom functions
##################

# Copy file and change to that directory
function cpc {
cp $1 $2
cd $2
}

upinfo ()
{
    echo -ne "${smoothgreen}$HOSTNAME ${red}uptime is ${cyan} \t ";uptime | awk /'up/ {print   $3,$4,$5,$6,$7,$8,$9,$10}'
}


# clock - A bash clock that can run in your terminal window.
clock ()
{
    while true;do clear;echo "===========";date +"%r";echo "===========";sleep 1;done
}

extract()
{
if [ -f "$1" ] ; then
    case "$1" in
        *.tar.bz2) tar xjf "$1" ;;
        *.tar.gz) tar xzf "$1" ;;
        *.tar.Z) tar xzf "$1" ;;
        *.bz2) bunzip2 "$1" ;;
        *.rar) unrar x "$1" ;;
        *.gz) gunzip "$1" ;;
        *.jar) unzip "$1" ;;
        *.tar) tar xf "$1" ;;
        *.tbz2) tar xjf "$1" ;;
        *.tgz) tar xzf "$1" ;;
        *.zip) unzip "$1" ;;
        *.Z) uncompress "$1" ;;
        *) echo "'$1' cannot be extracted." ;;
    esac
    else
        echo "'$1' is not a file."
fi
}

RemovePath() # Remove $2 from the path variable named by $1
{
    if [ "eval '$'${1}x" != "x" ]; then
        _tmp="`eval echo '$'${1}`"
        _tmp=`echo "$_tmp" | sed "s%$2%%g" | sed "s%::%:%g"`
        eval ${1}='$_tmp'
    fi
}

AddPathUnique() #  Add $2 to path variable named by $1, uniquely
{
    RemovePath "${1}" "${2}"
    eval _tmp="'$'${1}"
    if [ "x${_tmp}" != "x" ]; then
    eval "${1}"="${_tmp}:${2}"
    else
        eval "${1}"="${2}"
    fi
    export ${1}
}

###################
# Misc. Stuff -- add color to the ls command (for mac)
# More history lines
###################
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
HISTSIZE=5000

#########
# Aliases
#########

# Directory navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# General aliases
alias py='python3'
alias py2='python2'
alias py3='python3'
if [[ -n "$(who am i | grep \()" ]]; then
    alias ipy='ipython3 --colors=linux --pprint'
    alias notebook='jupyter notebook --no-browser'
else
    alias ipy='ipython3 --pylab --colors=linux --pprint'
    alias notebook='jupyter notebook'
fi
alias ll='ls -lh --color=auto'
alias dbx='databricks'


############
# Path stuff
############

# Executables
#AddPathUnique PATH /opt/cfitsio_3.39/bin
#export PATH=/usr/local/texlive/2016/bin/x86_64-linux:$PATH

# Python
# everything is in the $HOME/.local file
# .profile says to add that to my path when a shell starts
#python3.6
AddPathUnique PATH /opt/Python_3.9.1/bin

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.bash.inc' ]; then . '/opt/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.bash.inc' ]; then . '/opt/google-cloud-sdk/completion.bash.inc'; fi

source /Users/sboada/.docker/init-bash.sh || true # Added by Docker Desktop
