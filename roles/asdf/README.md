Role Name
=========

Install [`asdf-vm`](https://asdf-vm.com/) and configure it to manage several programming environments including pyenv, node, php composer, etc.

Requirements
------------

Only git is required to be installed on the host this role will control.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

```yaml
asdf_add_profile_source: false
```

This will template in a single purpose shell file into `/etc/profile.d/asdf.sh` containing the relevant asdf.sh script path that asdf uses to make itself available to all users running a `sh` compatible shell. If you want to individually manage access to asdf on a per user basis or different shell than bash or sh then make sure their respective config file *(think ~/.bashrc)* has a line sourcing this file. ASDF has a relevant document detailing what is necessary for each kind of system [here](https://asdf-vm.com/guide/getting-started.html#_3-install-asdf). The bash and zsh roles in this collection could manage dotfile repositories that have references to `$ASDF_DIR` and source `$ASDF_DIR/asdf.sh` inside them making this variable unnecessary.

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
