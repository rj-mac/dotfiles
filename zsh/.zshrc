HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
zstyle :compinstall filename '/home/urc/.zshrc'

# note: much of this was from this source:
# https://scriptingosx.com/2019/06/moving-to-zsh/

### ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# tmux alias for forcing true color support
alias tmux='tmux -2'
# if terminal is interactive and tmux is not already running, start tmux
 if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] \
 && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
 	exec tmux
 fi

### case insensitive globbing
setopt NO_CASE_GLOB

### additional history options
setopt SHARE_HISTORY # share hist amongst all zsh sessions
setopt APPEND_HISTORY # don't overwrite hist file in each zsh session
setopt INC_APPEND_HISTORY # add commands to hist as they are typed (not on shell exit)
setopt HIST_IGNORE_ALL_DUPS # don't store duped commands
setopt HIST_REDUCE_BLANKS # remove blank lines from history
setopt HIST_VERIFY # substitute command before executing on !!

# autocorrect bad commands
setopt CORRECT

#### tab complete settings

# case-insensitive completion
#autoload -Uz compinit && compinit 
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

### prompt

############################### Load zsh modules ###############################
autoload -Uz colors && colors # used to color prompt elements

################################## Build Prompt ################################

local workdir="%F{013}(%2~)%f "
local cmdstat=" %(?.%F{010}✔.%F{001}✘)%f "

# turn on substitution to allow for dynamic elements (git status, etc)
setopt PROMPT_SUBST

# build prompt
export PROMPT=$cmdstat$workdir$stat_tag$wdir_tag"%# "

### turn on colors for ls (copied from bash)

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

### improved history search
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^[[A' history-search-backward-end
bindkey '^[[B' history-search-forward-end

### plugins

# necessary zle widgets for syntax highlighting
zle -N history-search-backward-end
zle -N history-search-forward-end

# syntax highlighting: https://github.com/zsh-users/zsh-syntax-highlighting
source  ~/.df/zsh/plugins/zsh-syntax-highlighting.zsh # TODO add some sort of portable plugin folder

# substring history search: https://github.com/zsh-users/zsh-history-substring-search
source ~/.df/zsh/plugins/zsh-history-substring-search.zsh # TODO not this!

# keybinds for history search
# bindkey "$terminfo[kcuu1]" history-substring-search-up
# bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

### vi keybinds

# set editor to vim and configure zsh line editor to use vi bindings
export EDITOR=vim
bindkey -v
# the following to lines fix weird behavior where I can't delete 'non-inserted' test
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char
export KEYTIMEOUT=1
# TODO: make it so that cursor visually changes in insert mode

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# adding neovim to path since the newest version is not available on Ubuntu
export PATH="$PATH:/opt/nvim-linux64/bin"

# TODO: move this to its own file or otherwise make it conditional on being on a ROS system
source /opt/ros/humble/setup.zsh
# workaround for lack of zsh completion
eval "$(register-python-argcomplete3 ros2)"
eval "$(register-python-argcomplete3 colcon)"

# workaround alias; source'ing setup.zsh breaks autocomplete
alias r2src='source install/setup.zsh && source ~/.zshrc'

# colcon_cd
source /usr/share/colcon_cd/function/colcon_cd.sh
export _colcon_cd_root=/opt/ros/humble/

# potential TODO: autocomplete on rosdep may not work....

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
