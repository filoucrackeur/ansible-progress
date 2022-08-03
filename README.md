# ANSIBLE PROGRESS

## Requirements
You need binary: ```whiptail```

On MacOS :
```bash
brew install whiptail
```

On Linux Enterprise
```bash
dnf install -y whiptail
```

## Installation

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/filoucrackeur/ansible-progress/HEAD/install.sh)"

```


## How to use

You'll need to add a ansible configuration variable in ```ansible.cfg```

```ini
[defaults]
stdout_callback = counter_enabled
```

Exemple with ansible-playbook

```bash
$ ansible-playbook playbook.yml | ansible-progress
```

Exemple with ansible

```bash
$ ansible localhost -m ping  | ansible-progress
```