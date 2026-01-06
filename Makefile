dotfiles-install:
	./scripts/link.sh $(PWD)/files/gitconfig ~/.gitconfig
	./scripts/link.sh $(PWD)/files/gitignore_global ~/.gitignore_global
	./scripts/link.sh $(PWD)/files/tmux.conf ~/.tmux.conf
	test -e ~/.gitconfig.local || cp $(PWD)/files/gitconfig.local.example ~/.gitconfig.local

nvim-install:
	./scripts/link.sh $(PWD)/files/init.lua ~/.config/nvim/init.lua
	./scripts/link.sh $(PWD)/files/lua ~/.config/nvim/lua
	./scripts/link.sh $(PWD)/files/lazy-lock.json ~/.config/nvim/lazy-lock.json

doctor:
	@status=0; \
	check_cmd() { \
		cmd="$$1"; name="$$2"; \
		if command -v "$$cmd" >/dev/null 2>&1; then \
			echo "OK: $$name ($$cmd)"; \
		else \
			echo "FAIL: $$name ($$cmd) missing"; \
			status=1; \
		fi; \
	}; \
	check_file() { \
		path="$$1"; name="$$2"; \
		if [ -e "$$path" ]; then \
			echo "OK: $$name ($$path)"; \
		else \
			echo "WARN: $$name ($$path) missing"; \
		fi; \
	}; \
	check_cmd nvim "Neovim"; \
	check_cmd git "Git"; \
	check_cmd tmux "tmux"; \
	check_cmd node "Node.js"; \
	check_cmd rg "ripgrep"; \
	check_cmd delta "git-delta"; \
	check_file "$$HOME/.tmux/plugins/tpm/tpm" "tmux TPM"; \
	if [ "$$status" -ne 0 ]; then \
		echo "Doctor: missing required dependencies"; \
		exit "$$status"; \
	fi
