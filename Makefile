ROOT := $(CURDIR)

deps-install:
	./scripts/install-deps.sh

dotfiles-install:
	./scripts/link.sh $(ROOT)/files/gitconfig ~/.gitconfig
	./scripts/link.sh $(ROOT)/files/gitignore_global ~/.gitignore_global
	./scripts/link.sh $(ROOT)/files/tmux.conf ~/.tmux.conf
	./scripts/link.sh $(ROOT)/files/ghostty/config ~/.config/ghostty/config
	@if [ ! -e ~/.gitconfig.local ]; then \
		cp $(ROOT)/files/gitconfig.local.example ~/.gitconfig.local; \
		echo "NOTICE: Created ~/.gitconfig.local. Set user.name and user.email before committing."; \
	fi
	@if [ -x "$$HOME/.tmux/plugins/tpm/bin/install_plugins" ]; then \
		echo "Installing tmux plugins..."; \
		$$HOME/.tmux/plugins/tpm/bin/install_plugins; \
	else \
		echo "SKIP: tmux TPM not installed"; \
	fi

nvim-install:
	./scripts/link.sh $(ROOT)/files/init.lua ~/.config/nvim/init.lua
	./scripts/link.sh $(ROOT)/files/lua ~/.config/nvim/lua

update:
	@if command -v brew >/dev/null 2>&1; then \
		brew update; \
		brew upgrade; \
		brew upgrade --cask; \
	else \
		echo "SKIP: brew not installed"; \
	fi
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
