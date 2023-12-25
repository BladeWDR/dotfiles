dotbot: setup install
	@echo "Configuring dotfiles..."
	cd ~/dotfiles
	./install
	@echo "Configuration done."


install: setup 
	@echo "Running ansible playbook."
	ansible-playbook -K ./staging/staging.yml

setup:
	@echo "Running ansible installation script."
	chmod +x ansible_install.sh
	./ansible_install.sh
