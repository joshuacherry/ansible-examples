# ansible-examples

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://travis-ci.org/joshuacherry/ansible-examples.svg?branch=master)](https://travis-ci.org/joshuacherry/ansible-examples)
![Ansible](https://img.shields.io/badge/ansible-2.4.1.0-green.svg)

Includes all desired ansible roles as submodules for testing integrated functionality between roles that were developed independantly. This repository can be used as an example for a functional central ansible server.

## Install

This role requires Ansible 2.4+ to be installed. For local testing, the Vagrantfile takes care of everything for you. For deploying this code into production to manage your ansible environment, please follow the most up to date instructions.

* [Ansible Installation](http://docs.ansible.com/ansible/latest/intro_installation.html)

For examples, please see the Dockerfiles included in this repository.

| OS            |                                                          |
| :------------ | :------------------------------------------------------: |
| Debian 8      | [docker/jessie64/Dockerfile](docker/jessie64/Dockerfile) |
| Ubuntu 16.04  | [docker/xenial64/Dockerfile](docker/xenial64/Dockerfile) |
| Centos 7      | [docker/centos7/Dockerfile](docker/centos7/Dockerfile)   |

## Versioning

[Semantic Versioning](http://semver.org/)

For the versions available, see the [tags on this repository](https://github.com/joshuacherry/ansible-examples/tags).

Additionaly you can see what change in each version in the [CHANGELOG.md](CHANGELOG.md) file.

## Testing

This role includes a Vagrantfile used with a Docker-based test harness that approximates the Travis CI setup for integration testing. Using Vagrant allows all contributors to test on the same platform and avoid false test failures due to untested or incompatible docker versions.

1. Install [Vagrant](https://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/).
1. Run `vagrant up` from the same directory as the Vagrantfile in this repository.
1. SSH into the VM with: `vagrant ssh`
1. Run tests with `make`.

### Testing with Docker and inspec

```bash
make -C /vagrant xenial64 test PLAYBOOK=example
```

See `make help` for more information including a full list of available targets.

#### Debug testing with Docker and inspec

Use the docker-compose.yml file to define port mappings from the Docker container to the Vagrant VM. This allows you to interactively test services such as web content with your local browser by pointing to the IP address that `vagrant up` displays in your console during initialization.

Running make with debug instead of test will execute the playbook and leave the ssh session logged into an interacive shell within the Docker container. While this shell is active, you can test your application/server/website interactively. Typing `exit` will logout and remove the container.

```bash
make -C /vagrant xenail64 debug PLAYBOOK=example.yml
```

## Using Ansible Vault

Vault is a feature of ansible that allows keeping sensitive data such as passwords or keys in encrypted files, rather than as plaintext in your playbooks or roles. These vault files can then be distributed or placed in source control.

To enable this feature, a command line tool, ansible-vault is used to edit files, and a command line flag –ask-vault-pass or –vault-password-file is used.

* [More Details](http://docs.ansible.com/ansible/latest/playbooks_vault.html)

## Running Ansible

For development, running the playbooks are taken care of by docker and a shell script. In a production environment, the below command is the recommended way to run a playbook.

```bash
ansible-playbook -i /etc/ansible/environments/prod /etc/ansible/playbooks/YOUR_PLAYBOOK.yml --vault-password-file /etc/ansible/vault_credentials/vault_pass.txt
```

Ansible has very detailed documentation, please take the time to read it.

[Ansible Best Practices](http://docs.ansible.com/ansible/latest/playbooks_best_practices.html)

[Ansible Latest Documentation](http://docs.ansible.com/ansible/latest/index.html)

## Adding New Roles

Adding new roles to this repository is simple. `git submodule add <Repository> <PATH>`

```bash
git submodule add git@github.com:joshuacherry/ansible-role-prometheus.git roles/prometheus
```

For more information on git submodule, please see the [Documentation](https://git-scm.com/docs/git-submodule)