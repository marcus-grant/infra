Role Name
=========

A brief description of the role goes here.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

This dependency is entirely optional based on my specific git preferences. I use [`fzf`](marcus_grant.not_coreutil) along with [`fd`](https://github.com/sharkdp/fd) and [`ripgrep`](https://github.com/BurntSushi/ripgrep) as replacements to several GNU coreutil programs. Junegun's utility `fzf` also has a corresponding vim plugin that makes these work together nicely in vim so they make an optional dependency for my particular configuration in this collection called `not_coreutil` since they're rust alternatives to GNU coreutil.

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

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
