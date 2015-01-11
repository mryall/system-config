########################################
#                .zshrc 
#            mryall 20080321
########################################

# Setup my default prompt
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
    (( count = $count + 1 ))
done
PR_NO_COLOUR="%{$terminfo[sgr0]%}"

# default prompt
PS1="[$PR_LIGHT_CYAN%n@%m$PR_NO_COLOUR:$PR_CYAN%2c$PR_NO_COLOUR]> "

# prompt for right side of screen
RPS1="[$PR_CYAN%/$PR_NO_COLOUR]"

#### key setups 
# emacs key bindings
bindkey -e
# also do history expansion on space
bindkey ' ' magic-space 

# completion
autoload -U compinit
compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:cd:*' ignore-parents parent pwd

bindkey '^i' expand-or-complete-prefix

#### history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.history
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_GLOB

#### environment
export PAGER='less'
export EDITOR='emacsclient -c'
export VISUAL='emacsclient -c'
export PATH=~/bin:$PATH
export CDPATH=.:/home/mryall

## Terminal title
case $TERM in
    *xterm*|ansi)
	function settab { print -Pn "\e]1;%n@%m: %~\a" }
	function settitle { print -Pn "\e]2;%n@%m: %~\a" }
	function chpwd { settab;settitle }
	settab;settitle
        ;;
esac

#### options
setopt CORRECT AUTO_CD AUTO_LIST AUTO_MENU AUTO_PUSHD
setopt HIST_FIND_NO_DUPS HIST_IGNORE_SPACE LIST_PACKED
setopt ALL_EXPORT
setopt GLOB_DOTS GLOB_SUBST

unsetopt BEEP

#### fix backspace when logging in from os x
bindkey  backward-delete-char

# command options
export LS_OPTIONS='--color=auto'
export GREP_OPTIONS='--color=auto'
export LS_COLORS="di=00;32:ln=00;35:so=00;32:pi=00;33:ex=00;31:bd=34;46:cd=34;43:su=00;41:sg=00;46:tw=00;42:ow=00;43:"
#export TERM=screen

# fix C-s for emacs
## This no longer works so it's commmented for the moment 
#stty stop ^-

# emacs
if [ ${TERM} = "dumb" ]
then
    unsetopt zle;
    unsetopt prompt_cr
    unsetopt prompt_subst
    PS1='$ '
fi

# aliases
alias ls='ls -F $LS_OPTIONS'
alias lperl='perl -Mlocal::lib '
alias lcpan="perl -Mlocal::lib -MCPAN -e 'shell'"
alias cs="perl script/*_server.pl -d -r"
alias carpcs="perl -MCarp::Always script/*_server.pl -d -r"
alias emc='emacsclient -t "$@"'
alias smxt="xterm -font '-xos4-terminus-medium-r-*-*-14-*-*-*-*-*-iso10646-1'"

# Mac specific block
#if [ ${TERM_PROGRAM} = "Apple_Terminal" ]
if [ `uname` = "Darwin" ]
then
    # coloured ls 
    alias ls='ls -G'

    # MacPorts
    #export PATH=/opt/local/bin:/opt/local/sbin:$PATH
fi

# MPD
export MPD_HOST=127.0.0.1
export MPD_PORT=6600

tagperl () {
    find /usr/lib/perl -follow -name '*.p[lm]' -print0 | xargs -0 etags -f TAGS --append;
    find ~/perl5 -follow -name '*.p[lm]' -print0 | xargs -0 etags -f TAGS --append;
    find . -follow -name '*.p[lm]' -print0 | xargs -0 etags -f TAGS --append;
}

tagjava () {
    find . -follow -name '*.java' -print0 | xargs -0 etags -f TAGS --append;
}

if [[ -a  ~/perl5/perlbrew/etc/bashrc ]]; then
    source ~/perl5/perlbrew/etc/bashrc
fi
