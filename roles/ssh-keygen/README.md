SSH-Keygen
==========

Generate SSH keys

Requirements
------------

This uses the Ansible [community.general.ssh_config](https://bit.ly/3JqWEkh) to add new entries to the host's SSH config.

Role Variables
--------------

### Variables with Defaults

Available variables are listed below, along with the default values as shown in this role's `defaults/main.yml`.

```yaml
ssh_keygen_key_type: rsa 
ssh_keygen_key_bits: 4096
ssh_keygen_key_file: omit
ssh_keygen_passphrase: omit
ssh_keygen_comment: omit
ssh_keygen_force: false
ssh_keygen_pause_on_change: false
ssh_keygen_known_hosts: undefined
```

Most correspond to they properties of the `ansible.builtin.user` [module](https://bit.ly/37M0jv1). The only one that doesn't is `ssh_keygen_pause_on_change` which is used to pause the playbook then print out the newly generated key file if a new one was created so there's time for someone to write it down or copy and paste it somewhere so it can be used later. This is useful if for example a later role requires a git SSH key to be copied to GitHub or something.

### Required Variable Definitions

There's only one required variable, `ssh_keygen_user_name` to specify which user is going to get this SSH key. The example playbook below shows it in use.

### Known Hosts

The `ssh_keygen_known_hosts` variable takes a list of SSH `known_hosts` as the [concept](https://bit.ly/3udEdco) is used in configuring SSH clients. If a new key is generated and this variable is defined with a list, then each known host in the list will get an entry in `known_hosts` with this new key file after deleting all previous keys to this known host.

Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: laptops
  roles:
  - role: marcus_grant.ssh_keygen
    vars:
      ssh_keygen_user_name: root
      ssh_keygen_known_hosts: [github.com,steve@example.com]
```

TODO
----

- [ ] Add a remove task to remove old known hosts of the given list before adding new ones.

License
-------

GPL3

Author Information
------------------

Marcus Grant (2022)
marcusgrant.dev
github.com/marcus-grant
marcusfg@protonmail.com


