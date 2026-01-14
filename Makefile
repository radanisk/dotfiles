deps-install:
	./scripts/install-deps.sh

dotfiles-install:
	./scripts/link.sh $(PWD)/files/gitconfig ~/.gitconfig
	./scripts/link.sh $(PWD)/files/gitignore_global ~/.gitignore_global
	./scripts/link.sh $(PWD)/files/tmux.conf ~/.tmux.conf
	./scripts/link.sh $(PWD)/files/tmux/statusline_windows.sh ~/.config/tmux/statusline_windows.sh
	./scripts/link.sh $(PWD)/files/ghostty/config ~/.config/ghostty/config
	test -e ~/.gitconfig.local || cp $(PWD)/files/gitconfig.local.example ~/.gitconfig.local

nvim-install:
	./scripts/link.sh $(PWD)/files/init.lua ~/.config/nvim/init.lua
	./scripts/link.sh $(PWD)/files/lua ~/.config/nvim/lua

update:
	brew update
	brew upgrade
	brew upgrade --cask
	@if [ -x "$$HOME/.tmux/plugins/tpm/bin/update_plugins" ]; then \
		echo "Updating tmux plugins..."; \
		$$HOME/.tmux/plugins/tpm/bin/update_plugins all; \
	else \
		echo "SKIP: tmux TPM not installed"; \
	fi
	@if command -v nvim >/dev/null 2>&1; then \
		echo "Updating Neovim plugins (Lazy sync)..."; \
		nvim --headless "+Lazy! sync" "+qa"; \
		echo "Neovim plugins update complete"; \
	else \
		echo "SKIP: nvim not installed"; \
	fi
