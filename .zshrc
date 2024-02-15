# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/wasu9b/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#syntax highlightin extention
source "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
#auto suggestion
source "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
#stasrsship init
eval "$(starship init zsh)"

# keep these if nvm is installed
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This load>

