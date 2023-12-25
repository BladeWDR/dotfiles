dotbot: setup install
	@echo "Run install here."
	cd ~/dotfiles
	./install


install: setup 
	cd staging
	@echo "Running ansible playbook."
	ansible-playbook -K staging.yml

setup:
	@echo "Marking ansible_setup.sh as executable."
	chmod +x ansible_install.sh
