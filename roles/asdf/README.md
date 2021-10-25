Role Name
=========

Install [`asdf-vm`](https://asdf-vm.com/) and configure it to manage several programming environments including pyenv, node, php composer, etc.

Requirements
------------

Only git is required to be installed on the host this role will control.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

The git role from this collection could be used to make sure this role runs smoothly, but that has a bunch of other stuff that's not necessary here other than installing git with a package manager.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

GPL3

Author Information
------------------

Marcus Grant (2021) marcusgrant.dev
