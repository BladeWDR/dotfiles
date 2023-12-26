release_file=/etc/os-release
VERSION_CODENAME=$(shell . /etc/os-release && echo $$VERSION_CODENAME)
.PHONY: install-dependencies add-ansible-repository update-apt-repository install-ansible setup

dotbot: setup install
	@echo "Configuring dotfiles..."
	cd ~/dotfiles
	./install
	@echo "Configuration done."


install: setup 
	@echo "Running ansible playbook."
	ansible-playbook -K ./staging/staging.yml

setup: install-dependencies add-ansible-repository update-apt-repository install-ansible

install-dependencies:
	sudo apt update
	sudo apt install software-properties-common python3-launchpadlib git -y

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
