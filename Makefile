dotfiles-install:
	ln -s $(PWD)/files/gitconfig ~/.gitconfig | true
	ln -s $(PWD)/files/gitignore_global ~/.gitignore_global | true
	ln -s $(PWD)/files/tmux.conf ~/.tmux.conf | true

nvim-install:
	mkdir -p ~/.config/nvim
	ln -s $(PWD)/files/init.vim ~/.config/nvim/init.vim | true
	ln -s $(PWD)/files/coc-settings.json ~/.config/nvim/coc-settings.json | true
	mkdir -p ~/.config/nvim/lua/plugins
	ln -s $(PWD)/files/lua/plugins/init.lua ~/.config/nvim/lua/plugins/init.lua | true
	ln -s $(PWD)/files/lua/plugins/treesitter.lua ~/.config/nvim/lua/plugins/treesitter.lua | true
