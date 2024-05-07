OS=macos
FONT_NAME_CODE=font-hack-nerd-font
FONT_NAME=Hack
FONT_VERSION=v3.1.1

help: ## help
	@echo "------- Commands ------"
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36mmake %-25s\033[0m %s\n", $$1, $$2}'

install-all: ## install all [ args : OS ]
	make install-zsh-$(OS)
	make set-zsh-as-default
	make install-font-$(OS)
	make install-starship-$(OS)
	make clone-repos
	make setup-zsh

install-zsh-macos: ## install zsh for macos
	@echo "Installing zsh..."
	brew update
	brew install zsh

install-zsh-ubuntu: ## install zsh for ubuntu
	@echo "Installing zsh..."
	sudo apt-get update && sudo apt-get upgrade
	sudo apt install zsh

set-zsh-as-default: ## set zsh as default shell
	@echo "Setting zsh as default shell..."
	chsh -s /bin/zsh

install-starship-macos: ## install starship for macos
	@echo "Installing starship..."
	brew install starship

install-starship-ubuntu: ## install starship for ubuntu
	@echo "Installing starship..."
	curl -sS https://starship.rs/install.sh | sh

install-font-macos: ## install font for macos [ args : FONT_NAME_CODE ]
	@echo "Installing fonts..."
	brew tap homebrew/cask-fonts
	brew install --cask $(FONT_NAME_CODE)

install-colorls-ubuntu :
	@echo "Installing colorls..."
	sudo apt install ruby-dev
	sudo apt innstall build-essential
	sudo gem install colorls

	
	
install-font-ubuntu: ## install font for ubuntu [ args : FONT_NAME, FONT_VERSION ]
	@echo "Installing fonts..."
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/$(FONT_VERSION)/$(FONT_NAME).zip
	mkdir -p ~/.local/share/fonts/
	sudo apt install unzip ## sometimes the unzip is not available by default
	unzip $(FONT_NAME).zip -d ~/.local/share/fonts/$(FONT_NAME)
	
	sudo apt install fontconfig ## sometime fontconfig is not installed by default
	fc-cache -f -v

clone-repos: ## clone repos
	@mkdir -p ~/.zsh && \
	cd ~/.zsh && \
	git clone https://github.com/zsh-users/zsh-autosuggestions && \
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

setup-zsh: ## create .zsh-config and update .zshrc to source it
	@echo "Creating .zsh-config with specified configurations..."
	@{ \
	echo '# Lines configured by zsh-newuser-install'; \
	echo 'HISTFILE=~/.histfile'; \
	echo 'HISTSIZE=1000'; \
	echo 'SAVEHIST=1000'; \
	echo 'bindkey -e'; \
	echo '# End of lines configured by zsh-newuser-install'; \
	echo '# The following lines were added by compinstall'; \
	echo 'zstyle :compinstall filename '\''~/.zshrc'\'''; \
	echo ''; \
	echo 'autoload -Uz compinit'; \
	echo 'compinit'; \
	echo '# End of lines added by compinstall'; \
	echo ' # colour of dir'; \
  echo 'alias ls="ls --color" '; \
	echo ''; \
	echo '#syntax highlighting extension'; \
	echo 'source "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"'; \
	echo '#auto suggestion'; \
	echo 'source "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"'; \
	echo '#starship init'; \
	echo 'eval "$$(starship init zsh)"'; \
	echo ' # colorls settings'
	echo 'alias lc='colorls''
	echo 'source $(dirname $(gem which colorls))/tab_complete.sh'

	
	} > ~/.zsh-config
	@echo "Updating .zshrc to source .zsh-config..."
	@if grep -q '.zsh-config' ~/.zshrc; then \
	echo '.zsh-config already sourced in .zshrc'; \
	else \
	echo 'source ~/.zsh-config' >> ~/.zshrc; \
	fi
	@echo "Setup completed!!! Please restart your terminal or run:"
	@echo "\tsource ~/.zshrc"


