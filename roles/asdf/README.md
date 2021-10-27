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
asdf_data_dir: .asdf  # i.e. $HOME/.asdf
asdf_config_dir: "{{ asdf_data_dir }}"  # i.e. $HOME/.asdf
```

Sets the directory **with respect to asdf_user's home directory** to store asdf's installation. This is a relative path to the home directory of the user. Because we the `asdf_user` must be defined explicitly for the role as explained next, we need to have paths relative to it. `asdf_data_dir` corresponds to asdf's expected environment variable `ASDF_DIR` and `ASDF_DATA_DIR` while the `ASDF_CONFIG_DIR` environment variable corresponds to this role's `asdf_config_dir` variable. You can read more about how to position the asdf expected directories [here](https://asdf-vm.com/manage/configuration.html#environment-variables).

```yaml
asdf_user: ''
```

The `adsf_user` **is required**. Because the home directory can be different than `/home/asdf_user`, because shell configurations can be different between users and ansible's `become` property can mess with how this role is deployed this must be explicitly defined so the role tasks involving users can be independent of how it is used. So you must define `asdf_user` with a valid user name to have asdf installed on.

```yaml
asdf_version: HEAD
```

The version of asdf installed is controlled by the role variable `asdf_version`. This variable gets used in the ansible module `ansible.builtin.git` property `version`, which can be a release tag, commit hash or branch name and that is how this role will use git to pull a specific version of the codebase for installation. `HEAD` is just the latest commit on the default branch. At the time of this writing `v0.8.1` is the release tag that corresponds to `HEAD` so it would be the same version, but that will change eventually.

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
