dotfiles-install:
	ln -s $(PWD)/files/gitconfig ~/.gitconfig | true
	ln -s $(PWD)/files/gitignore_global ~/.gitignore_global | true
	ln -s $(PWD)/files/tmux.conf ~/.tmux.conf | true

nvim-install:
	mkdir -p ~/.config/nvim
	ln -s $(PWD)/files/init.vim ~/.config/nvim/init.vim | true
	ln -s $(PWD)/files/coc-settings.json ~/.config/nvim/coc-settings.json | true
	mkdir -p ~/.config/nvim/lua
	ln -s $(PWD)/files/lua/plugins.lua ~/.config/nvim/lua/plugins.lua | true
