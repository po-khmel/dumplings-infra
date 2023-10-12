Role Name
=========

Ansible role to install Docker nad Dicker Compose on Ubuntu

Requirements
------------

ansible >= 6.6.0
ansible-core >= 2.11.3


Role Defaults
--------------
| Variable        | Description                         | Default Value                              |
| --------------- | ----------------------------------- | ------------------------------------------ |
| docker_repo_url | URL for Docker repository           | "https://download.docker.com/linux/ubuntu" |
| docker_arch     | Architecture of the host system     | "{{ ansible_architecture }}"               |
| docker_gpg_path | Path to the Docker GPG keyring file | "/etc/apt/keyrings/docker.gpg"             |
| docker_codename | Ubuntu codename for the release     | "focal"                                    |

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```YAML
- name: Install Docker on Ubuntu 20.04
  hosts: all
  become: true
  vars:
    docker_codename: "focal"
  roles:
    - docker_install

```
License
-------
BSD

Author Information
------------------
[Polina Khmelevskaia](https://github.com/po-khmel)
