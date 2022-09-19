Pacman-Install
==============

Install packages with pacman on Archlinux family hosts and install/configure AUR.

Requirements
------------

None

Role Variables
--------------

### Variables with Defaults

Available variables are listed below, along with the default values as shown in this role's `defaults/main.yml`.

```yaml
pacman_extra_packages: [curl]  # Must be a list of valid package names
```

The variable `pacman_extra_packages` is a list of packages for pacman to install.



### Required Variable Definitions

### Known Hosts

Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: laptops
  roles:
  - role: marcus_grant.pacman-install
    vars:
      pacman_extra_packages: [curl,git,cowsay]
```

License
-------

GPL3

Author Information
------------------

Marcus Grant (2022)
marcusgrant.dev
github.com/marcus-grant
marcusfg@protonmail.com


