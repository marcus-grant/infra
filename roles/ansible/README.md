Ansible Development Role
========================

A role that installs & configures ansible along with a lot of useful 3rd party applications and scripts.

Requirements
------------

None specific to running this role in isolation unless for example a pre-existing inventory, config file or vault is needed locally on the machine controlling a remote machine to run the role in order to transfer it.

Role Variables
--------------

All the variables meant to be defined in this role will be listed here with their default value, unless they require explicitly defining them. All the default values to variables that have them can also be found in `defaults/main.yml`. In order to avoid problems with magic variables that are normally prefixed as `ansible_*` that relate to the ansible runtime's internal functioning, these variables will be prefixed with `ans_*`.

<!-- ```yaml -->
<!-- ans_config_level: system -->
<!-- ``` -->
<!--  -->
<!-- Ansible searches for configurations in this order, `ANSIBLE_CONFIG` as a shell environment variable, `./ansible.cfg` in the current directory, `~/.ansible.cfg` for user scoped configurations, then finally system-wide configurations in `/etc/ansible/ansible.cfg`. -->

```yaml
ans_vault_passfile: omit
```

This defines the path that ansible will look for a passphrase file to decrypt an ansible vault for the user this role is run on. It defaults to `omit` to omit templating of `ansible.cfg` for that property.

```yaml
```

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
