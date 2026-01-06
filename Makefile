dotfiles-install:
	ln -s $(PWD)/files/gitconfig ~/.gitconfig | true
	ln -s $(PWD)/files/gitignore_global ~/.gitignore_global | true
	ln -s $(PWD)/files/tmux.conf ~/.tmux.conf | true
	test -e ~/.gitconfig.local || cp $(PWD)/files/gitconfig.local.example ~/.gitconfig.local

nvim-install:
	mkdir -p ~/.config/nvim
	ln -s $(PWD)/files/init.lua ~/.config/nvim/init.lua | true
	test -e ~/.config/nvim/lua || ln -s $(PWD)/files/lua ~/.config/nvim/lua
	ln -s $(PWD)/files/lazy-lock.json ~/.config/nvim/lazy-lock.json | true

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
