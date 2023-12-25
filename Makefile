dotbot: setup install
	@echo "Run install here."

install: setup 
	cd staging
	@echo "Running ansible playbook."
	ansible-playbook -K staging.yml

setup:
	cd ~/dotfiles
	@echo "Marking ansible_setup.sh as executable."
	chmod +x ansible_install.sh


