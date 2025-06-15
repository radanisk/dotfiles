dotfiles-install:
	ln -s $(PWD)/files/gitconfig ~/.gitconfig | true
	ln -s $(PWD)/files/gitignore_global ~/.gitignore_global | true
	ln -s $(PWD)/files/tmux.conf ~/.tmux.conf | true

nvim-install:
	mkdir -p ~/.config/nvim
	ln -s $(PWD)/files/init.lua ~/.config/nvim/init.lua | true
	test -e ~/.config/nvim/lua || ln -s $(PWD)/files/lua ~/.config/nvim/lua
	ln -s $(PWD)/files/lazy-lock.json ~/.config/nvim/lazy-lock.json | true
