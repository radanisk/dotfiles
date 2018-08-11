install_dotfiles:
	ansible-playbook dotfiles.yml -i local -vv -e curdir=$(CURDIR)

nvim_configure:
	ansible-playbook nvim.yml -i local -vv -e curdir=$(CURDIR)
