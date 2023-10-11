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

### Manual Key Transfer Prompt Variables

These variables define a list of keys on the remote host that
should have their public keys added to
other remote hosts through manual intervention.
This could be through more complicated `ssh-copy-id` commands involving
old keys you have access to or
going to a website's admin panel and adding the key there or
even just manually adding the key to the remote host's `authorized_keys` file.

What this does is print out a message, pausing the playbook,
containing the contents of a public key and the location to send it to.
Then it prompts for the ENTER key before continuing the playbook.
This is primarily used for initial setups of hosts where
passing the key automatically isn't simple.
For example, doing this automatically for Github is non-trivial as you need to
cycle API tokens that expire.
Sometimes it's just easier to perform a manual intervention.

By default this part of the role doesn't execute,
the default value of `ssh_manual_transfer_on` is `false` so it will get skipped.
But if you run this playbook with the parameter `-e ssh_manual_transfer_on=true`
then it will execute this part of the role which could be useful for
bootstrapping scripts on new hosts.

The variable `ssh_manual_transfers` is a list of dictionaries with the below keys.
They define the name of the key to get the contents of and a location to
prompt the user to send it to manually.

| Variable               | Default    | Choices | Comments                                   |
| ---------------------- | ---------- | ------- | ------------------------------------------ |
| ssh_manual_transfer_on | false      | bool    | Will perform manual key transfer prompt    |
| ssh_manual_transfers   | []         | [dict]  | Dictionaries with prompt info keys below   |
| pub                    | **Needed** | str     | Filename of public key contents to present |
| location               | ''         | str     | Location to instruct to transfer to        |

> **NOTE**: The `pub` key is the filename of the public key to present to the user.
> The intention is to copy that key and paste it into an admin panel or
> `authorized_keys` file of the remote host hinted at in the `location` key.

## Dependencies

Only SSH, which apart from windows is usually installed by default.

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: some_host
  vars:
    ssh_exclude_groups: [dont_include_these_hosts]
    ssh_exclude_hosts: [include_this_host]
    ssh_exclude_groups: [hosts_in_group_b, hosts_in_group_c]
    ssh_custom_keys:
      - {name: git.key, comment: 'git@{{ inventory_hostname }}', pass: '{{ admin_main_git_password }}'}
    ssh_git_key: "{{ ssh_custom_keys[0].name }}"  # Alias for above custom key
    ssh_config_custom_entries:
      - {name: github.com, url: github.com, user: git, key: "{{ ssh_git_key }}"}
      - {name: codeberg.org, user: git, key: "{{ ssh_git_key }}"}
    ssh_manual_transfers:
      - {pub: "{{ ssh_git_key }}", location: https://github.com/settings/keys}
      - {pub: "{{ ssh_git_key }}", location: https://codeberg.org/user/settings/keys}
      - {pub: id_ed25519, location: "{{ hostvars['host_a']['ansible_host'] }}"}
      - {pub: id_ed25519, location: https://your-vps-provider.com/ssh-keys}
  roles:
    - role: marcus_grant.dotfiles.ssh
```

## License

GPLv3

## Author Information

[Personal Site](https://marcusgrant.me)
[GitHub](https://github.com/marcus-grant)
[Mastodon](https://fosstodon.org/@marcusgrant)
