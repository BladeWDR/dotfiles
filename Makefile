dotbot: setup install
	@echo "Run install here."
	cd ~/dotfiles
	./install


install: setup 
	cd staging
	@echo "Running ansible playbook."
	ansible-playbook -K staging.yml

setup:
	@echo "Running ansible installation script."
	chmod +x ansible_install.sh
	./ansible_install.sh

