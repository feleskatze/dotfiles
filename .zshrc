bindkey -v


function loadlib() {
        lib=${1:?"You have to specify a library file"}
        if [ -f "$lib" ];then
                . "$lib"
        fi
}

loadlib ~/.dotlocal/.zshalias

case ${OSTYPE} in
	darwin*)
		alias -g ls="ls -GF"
		alias -g gls="gls --color"
		alias -g la="ls -a -GF"
		alias -g v="nvim"
    alias -g vim="nvim"
    alias -g vimvim="vim"
		alias -g python="python3"
		alias -g pip="pip3"
		alias -g rmrm="rm"
		alias -g rm='mv -i -t ~/Trash'

		;;

	linux*)
		alias -g ls="ls -GF"
		alias -g gls="gls --color"
		alias -g la="ls -a -GF"
    alias -g ft="find -type f -name"
		alias -g v="nvim"
		alias -g vi="nvim"
		alias -g vim="nvim"
		alias -g vimvim="vim"
		alias -g python="python3"
		alias -g py="python3"
		alias -g rmrm="rm"
		alias -g rm='mv -i -t ~/Trash'
    alias -g cdl="a=('ls -l') ; ls -l | cat -n ; read b ; cd ${a[$b-l]}"
    alias -g countfile='(shopt -s dotglob; for dir in */; do all=("$dir"/*); echo "$dir: ${#all[@]}"; done)'
    alias -g view="cmd.exe /c start NeeView.exe"
    alias -g tmuxend="tmux kill-server"
esac

#function

function open() {cmd.exe /c start "" "$(wslpath -m $@)" }

function findopendir() {find -type d -name "*$1*" | {read LINE ; cd "$LINE"} }


function openwsl(){
        if [ $# -eq 1 ]; then
                readlink -f $1 |xargs wslpath -m| xargs cmd.exe /c start
        else
                echo "ERROR: argument is missing."
                echo "Please specify file/open to execute by Windows"
                echo "open [file/path]"
        fi
}

##

export LANG='C.UTF-8'
export LC_CTYPE='C.UTF-8'
export LC_MESSAAGE='C.UTF-8'
export LC_ALL='C.UTF-8'
export KCODE=u

setopt print_eight_bit

#export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.6/site-packages/

autoload -Uz compinit
compinit -u
setopt correct
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
/usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin


autoload -U compinit
compinit

autoload -U colors
colors


export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

chpwd() {ls}


autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' max-exports 6 # format‚É“ü‚é•Ï”‚ÌÅ‘å”
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%b@%r' '%c' '%u'
zstyle ':vcs_info:git:*' actionformats '%b@%r|%a' '%c' '%u'
setopt prompt_subst
function vcs_echo {
    local st branch color
	STY= LANG=en_US.UTF-8 vcs_info
	st=`git status 2> /dev/null`
	if [[ -z "$st" ]]; then return; fi
	branch="$vcs_info_msg_0_"
	if   [[ -n "$vcs_info_msg_1_" ]]; then color=${fg[green]} #staged
	elif [[ -n "$vcs_info_msg_2_" ]]; then color=${fg[red]} #unstaged
	elif [[ -n `echo "$st" | grep "^Untracked"` ]]; then color=${fg[blue]} # untracked
	else color=${fg[cyan]}
	fi
	echo "%{$color%}(%{$branch%})%{$reset_color%}" | sed -e s/@/"%F{yellow}@%f%{$color%}"/
}
PROMPT='
%F{yellow}[%~]%f `vcs_echo`
%(?.$.%F{red}$%f) '


setopt auto_pushd
setopt pushd_ignore_dups

alias -g L='| less'
alias -g G='| grep'

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVAHIST=100000
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups


setopt extended_glob


setopt no_beep

setopt ignore_eof

setopt interactive_comments



export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"



##########################################
#             zinit setting
##########################################

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit light zsh-users/zsh-autosuggestions

zinit light zdharma/fast-syntax-highlighting

zinit light zdharma/history-search-multi-word

zinit light supercrabtree/k

zinit light mollifier/anyframe

zinit light zsh-users/zsh-completions

zinit light b4b4r07/enhancd

# zinit snippet OMZL::git.zsh
# zinit snippet OMZP::git
# zinit snippet OMZL::prompt_info_functions.zsh
# zinit cdclear -q

setopt promptsubst
# zinit snippet OMZT::gnzh

#zinit snippet OMZ::themes/robbyrussell.zsh-theme
#zinit snippet OMZ::themes/amuse.zsh-theme
#zinit snippet OMZ::themes/frontcube.zsh-theme
#zinit snippet OMZ::themes/murilasso.zsh-theme
#zinit snippet OMZ::themes/pmcgee.zsh-theme

#zinit snippet OMZ::themes/refined.zsh-theme
zinit light romkatv/powerlevel10k
zinit snippet https://github.com/sainnhe/dotfiles/raw/master/.zsh-theme-gruvbox-material-dark

##########################################
#            zinit setting end
##########################################
