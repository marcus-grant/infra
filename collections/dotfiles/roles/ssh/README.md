# marcus_grant.dotfiles.profile

Role for setting up SSH environment.
Includes templating .ssh/config file based on inventory & custom variables.
Creates default ED25519 and RSA keys for user.
Creates a list of custom SSH keys for user (all ED25519).
Finally allows creating prompt with instructions for
adding SSH keys to remote hosts defined by variables.

## Requirements

SSH needs to be installed, but most systems that aren't windows have this.


## Role Variables

These are the variables along with
their default values as shown in `defaults/main.yml`.

| Variable | Default | Choices | Comments |
| -------- | ------- | ------- | -------- |
| ssh_default_ed_key         |         |         |          |

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
