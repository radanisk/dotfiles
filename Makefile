dotfiles-install:
	./scripts/link.sh $(PWD)/files/gitconfig ~/.gitconfig
	./scripts/link.sh $(PWD)/files/gitignore_global ~/.gitignore_global
	./scripts/link.sh $(PWD)/files/tmux.conf ~/.tmux.conf
	./scripts/link.sh $(PWD)/files/ghostty/config ~/.config/ghostty/config
	test -e ~/.gitconfig.local || cp $(PWD)/files/gitconfig.local.example ~/.gitconfig.local

nvim-install:
	./scripts/link.sh $(PWD)/files/init.lua ~/.config/nvim/init.lua
	./scripts/link.sh $(PWD)/files/lua ~/.config/nvim/lua
	./scripts/link.sh $(PWD)/files/lazy-lock.json ~/.config/nvim/lazy-lock.json
