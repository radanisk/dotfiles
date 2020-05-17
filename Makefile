install_dotfiles:
	ansible-playbook dotfiles.yml -i local -vv -e curdir=$(CURDIR)

nvim-install:
	mkdir -p ~/.config/nvim
	ln -s $(PWD)/files/init.vim ~/.config/nvim/init.vim | true
	ln -s $(PWD)/files/coc-settings.json ~/.config/nvim/coc-settings.json | true
