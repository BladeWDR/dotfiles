release_file=/etc/os-release
VERSION_CODENAME=$(shell . /etc/os-release && echo $$VERSION_CODENAME)
.PHONY: install-dependencies add-ansible-repository update-apt-repository install-ansible setup

dotbot: setup install
	@echo "######################################################"
	@echo "Configuring dotfiles..."
	@echo "######################################################"
	cd ~/dotfiles
	./install
	@echo "######################################################"
	@echo "Configuration done."
	@echo "######################################################"


install: setup 
	@echo "######################################################"
	@echo "Running ansible playbook."
	@echo "######################################################"
	ansible-galaxy install -r staging/meta/requirements.yml --roles-path ./staging/roles
	ansible-playbook -K ./staging/staging.yml

setup: install-dependencies add-ansible-repository update-apt-repository install-ansible

install-dependencies:
	sudo apt update
	sudo apt install software-properties-common python3-launchpadlib git zsh zsh-autosuggestions zsh-syntax-highlighting tmux neofetch direnv thefuck zoxide -y

add-ansible-repository:
	if [ -f /etc/apt/sources.list.d/ansible-ubuntu-ansible-$(VERSION_CODENAME).list ]; then \
		echo "Repository already exists, skipping."; \
	else \
		sudo apt-add-repository ppa:ansible/ansible -y -n; \
	fi

update-apt-repository:
ifeq ($(shell grep -q "Ubuntu" $(release_file) && echo "true"), true)
	sudo apt update
else
	sudo sed -i "s/$(VERSION_CODENAME)/jammy/" /etc/apt/sources.list.d/ansible-ubuntu-ansible-$(VERSION_CODENAME).list
	sudo apt update
endif

install-ansible:
	sudo apt install ansible -y

install-neovim: install
	@echo "######################################################"
	@echo "Installing Neovim."
	@echo "######################################################"
	ansible-playbook -K ./staging/neovim.yml
	@echo "######################################################"
	@echo "Neovim installed."
	@echo "######################################################"

upgrade-neovim: 
	@echo "######################################################"
	@echo "Installing Neovim."
	@echo "######################################################"
	ansible-playbook -K ./staging/neovim.yml
	@echo "######################################################"
	@echo "Neovim installed."
	@echo "######################################################"
