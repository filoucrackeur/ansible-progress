#!/bin/bash
echo "Installing Ansible-progress"
curl https://raw.githubusercontent.com/filoucrackeur/ansible-progress/HEAD/ansible-progress.sh > /usr/local/bin/ansible-progress 2>&1 > /dev/null
echo "Done"