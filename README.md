# Saving my zsh configurations here

#first install zsh

# linux

$ sudo apt install zsh

# install these from their page

#a nerd font of your choice(can skip)

https://www.nerdfonts.com/

#starship

https://starship.rs/ja-jp/guide/


# Then , clone these two inside .zsh directory and zopy .zsh in home directory

$ cd .zsh

$ git clone https://github.com/zsh-users/zsh-autosuggestions

$ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git


#copy the .zsh  and .zshrc in home dir

# make the deaful shell to zsh

$ chsh -s $(which zsh)
