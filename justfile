# The default recipe of the justfile
default: help

# Show this info message
help:
  just --list

# Remaster a Debian Installer ISO to be automatic
debian iso_path pub_key_path:
    ./debian/build.bash {{ iso_path }} {{ pub_key_path }}

# Setup the basic server scaffolding to allow main user authentication
ansible-root-setup user_password:
    cd ansible && ansible-playbook 01-root-setup.yml --extra-vars "user_password={{user_password}}"

# Setup the server
ansible-user-setup:
    cd ansible && ansible-playbook 02-user-setup.yml -K

# Clean and harden the root user
ansible-clean-root:
    cd ansible && ansible-playbook 03-clean-root.yml -K