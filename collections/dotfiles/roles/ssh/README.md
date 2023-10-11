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

### Default id_ed25519 & id_rsa Key Generation Variables

These variables are used to create the default SSH keys for the user.
These will typically have the name of `id_ed25519` and `id_rsa` respectively for
ED25519 and RSA keys used by SSH.
The default key gets chosen when no config or ssh-agent points to
a specific key for an endpoint so these are important keys to have.
Below, these values control whether one should be generated,
if so what the password should be, and what the comment should be.
Blank password and comment are allowed and signify no password or comment.

| Variable                    | Default | Choices | Comments                          |
| --------------------------- | ------- | ------- | --------------------------------- |
| ssh_default_ed_key          | true    | bool    | Generate a default id_ed25519 key |
| ssh_default_ed_key_pass     | ''      | str     | Default id_ed25519 key's password |
| ssh_default_ed_key_comment  | ''      | str     | Default id_ed25519 key's comment  |
| ssh_default_rsa_key         | false   | bool    | Generate a default RSA key        |
| ssh_default_rsa_key_pass    | ''      | str     | Default RSA key's password        |
| ssh_default_rsa_key_comment | ''      | str     | Default RSA key's comment         |

### Custom SSH Key Variables

On top of generating the default keys,
this role can also generate a list of custom defined keys/identity files.
Since the default RSA is included, legacy support can be given with this option.
ED25519 is quickly becoming the standard and is more secure than RSA.
RSA is mostly only used anymore due to legacy support
which is why it's included.

Custom SSH keys are generated whenever
the variable `ssh_custom_keys` has at least one entry in its list.
The list contains dictionaries with the below keys where
the `name` key is the only required key.

| Variable        | Default    | Choices | Comments                           |
| --------------- | ---------- | ------- | ---------------------------------- |
| ssh_custom_keys | []         | [?dict] | Dictionaries with below keys       |
| name            | **Needed** | str     | **Required** file*name* of key     |
| pass            | ''         | str     | Key password, defaults to none     |
| comment         | ''         | str     | Key comment, defaults to user@host |

### SSH Config Variables

This task configures the SSH config file for the user.
This file is usually found at `~/.ssh/config` and
contains entries for different hosts to connect to and their parameters.
Since ansible has inventories to connect to hosts,
it makes sense to use the inventory to generate the config file.
In this role these variables below are used to add groups' hosts and
individual hosts to lists of hosts to include and exclude in the config.

Any host in `ssh_include_groups` groups will be included in the config.
Any host in `ssh_include_hosts` will be included in the config.
Any host in `ssh_exclude_groups` groups will be excluded from the config.
The host this role is being run on will be excluded from the config.
What remains is all the hosts that will have generated entries in the config.

| Variable           | Default | Choices | Comments                                  |
| ------------------ | ------- | ------- | ----------------------------------------- |
| ssh_include_groups | []      | [str]   | Groups whose hosts to include in config   |
| ssh_exclude_hosts  | []      | [str]   | Individual hosts to exclude from config   |
| ssh_exclude_groups | []      | [str]   | Groups whose hosts to exclude from config |


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
