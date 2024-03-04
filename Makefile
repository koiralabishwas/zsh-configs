OS=macos
FONT_NAME=font-hack-nerd-font

help: ## help
	@echo "------- Commands ------"
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36mmake %-25s\033[0m %s\n", $$1, $$2}'

install-all: ## install all [ args : OS ]
	make install-zsh-$(OS)
	make install-font-$(OS)
	make install-starship-$(OS)
	make clone-repos
	make setup-zsh

install-font-macos: ## install font for macos [ args : FONT_NAME ]
	brew tap homebrew/cask-fonts
	brew install --cask $(FONT_NAME)
	
install-font-linux: ## install font for linux [ args : FONT_NAME ]
	@echo "どうやってたるのこれ？"

install-zsh-macos: ## install zsh for macos
	brew install zsh

install-zsh-linux: ## install zsh for linux
	sudo apt install zsh

install-starship-macos: ## install starship for macos
	brew install starship

install-starship-linux: ## install starship for linux
	curl -sS https://starship.rs/install.sh | sh

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
	echo ''; \
	echo '#syntax highlighting extension'; \
	echo 'source "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"'; \
	echo '#auto suggestion'; \
	echo 'source "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"'; \
	echo '#starship init'; \
	echo 'eval "$$(starship init zsh)"'; \
	} > ~/.zsh-config
	@echo "Updating .zshrc to source .zsh-config..."
	@if grep -q '.zsh-config' ~/.zshrc; then \
	echo '.zsh-config already sourced in .zshrc'; \
	else \
	echo 'source ~/.zsh-config' >> ~/.zshrc; \
	fi
	@echo "Setup completed!!! Please restart your terminal or run:"
	@echo "\tsource ~/.zshrc"

remove-all: ## remove all installed components [ args : OS ]
	make remove-zsh-$(OS)
	make remove-font
	make remove-starship-$(OS)
	make remove-repos
	make remove-zsh-setup

remove-font: ## remove font [ args : FONT_NAME ]
	brew uninstall --cask $(FONT_NAME)

remove-zsh-macos: ## remove zsh for macos
	brew uninstall zsh

remove-zsh-linux: ## remove zsh for linux
	sudo apt remove --purge zsh

remove-starship-macos: ## remove starship for macos
	brew uninstall starship

remove-starship-linux: ## remove starship for linux
	# Assuming uninstallation is simply removing the binary as there's no standard uninstall script
	rm -f $(which starship)

remove-repos: ## remove cloned repos
	rm -rf ~/.zsh

remove-zsh-setup: ## remove .zsh-config and update .zshrc
	@echo "Removing .zsh-config..."
	@rm -f ~/.zsh-config
	@echo "Updating .zshrc to remove source to .zsh-config..."
	@sed -i '' '/.zsh-config/d' ~/.zshrc
	@echo "Removal completed!!! Please restart your terminal or run:"
	@echo "\tsource ~/.zshrc"
