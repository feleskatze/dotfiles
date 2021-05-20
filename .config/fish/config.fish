
alias ls="ls -GF"
alias la="ls -a -GF"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias py="python3"
alias python="python3"
alias rmmrmm="rm"
alias rm="mv -i -t ~/Trash"
alias tmuxend="tmux kill-server"
alias dev="cd /mnt/c/users/ttomo/dropbox/develop"
alias cits="cd /mnt/c/users/ttomo/onedrive/CITS"


scheme set monokai

functions --copy cd standard_cd

function cd
  standard_cd $argv; and la
end


function open
  cmd.exe /c start {$wslpath -m (pwd)}
end

  


setenv PYENV_ROOT "$HOME/.pyenv"
setenv PATH "$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"
pyenv rehash
