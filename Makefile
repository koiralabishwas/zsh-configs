OS=ubuntu
FONT_NAME_CODE=font-hack-nerd-font
FONT_NAME=0xProto
FONT_VERSION=v3.1.1

help: ## help  first setup zsh and reboot for gods shake
	@echo "------- Commands ------"
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36mmake %-25s\033[0m %s\n", $$1, $$2}'

install-zsh-ubuntu: ## install zsh for ubuntu and set zsh as default shell
	@echo "Installing zsh..."
	sudo apt install zsh
	@echo "Setting zsh as default shell..."
	chsh -s /bin/zsh
	@echo "!!!!!Plese Restart your Shell / Terminal App !!!!!!!!!"

install-starship-ubuntu: ## install starship for ubuntu
	@echo "Installing starship..."
	curl -sS https://starship.rs/install.sh | sh

install-font-ubuntu: ## install font for ubuntu [ args : FONT_NAME, FONT_VERSION ]
	@echo "Installing fonts..."
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/$(FONT_VERSION)/$(FONT_NAME).zip
	mkdir -p ~/.local/share/fonts/
	sudo apt install unzip ## sometimes the unzip is not available by default
	unzip $(FONT_NAME).zip -d ~/.local/share/fonts/$(FONT_NAME)
	sudo apt install fontconfig ## sometimes fontconfig is not installed by default
	fc-cache -f -v

install-colorls-ubuntu: ## install colorls for ubuntu
	@echo "Installing colorls..."
	sudo apt install ruby-dev
	sudo apt install build-essential
	sudo gem install colorls

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
	echo '# colour of dir'; \
	echo 'alias ls="ls --color" '; \
	echo ''; \
	echo '#syntax highlighting extension'; \
	echo 'source "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"'; \
	echo '#auto suggestion'; \
	echo 'source "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"'; \
	echo '#starship init'; \
	echo 'eval "$$(starship init zsh)"'; \
	echo '# colorls settings'; \
	echo 'alias lc="colorls"'; \
	echo 'source $$(dirname $$(gem which colorls))/tab_complete.sh'; \
	echo '# command-not-found utility'; \
	echo 'if [ -f /etc/zsh_command_not_found ]; then'; \
	echo '. /etc/zsh_command_not_found'; \
	echo 'fi'; \
	} > ~/.zsh-config
	@echo "Updating .zshrc to source .zsh-config..."
	@if grep -q '.zsh-config' ~/.zshrc; then \
		echo '.zsh-config already sourced in .zshrc'; \
	else \
		echo 'source ~/.zsh-config' >> ~/.zshrc; \
	fi

# do these after doing the settings above↑
# additions programming tools i.e save in .zshrc
install-nvm-ubuntu: ## install nvm for ubuntu
	@echo "Installing nvm..."
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash


install-bun-ubuntu: ## install bun for ubuntu
	@echo "Installing bun..."
	curl -fsSL https://bun.sh/install | bash
