Role Name
=========

Install [`asdf-vm`](https://asdf-vm.com/) and configure it to manage several programming environments including pyenv, node, php composer, etc.

Requirements
------------

None

Role Variables
--------------

Below are all role variables with their defaults. You can also find them in the defaults file (`defaults/main.yml`)

```yaml
asdf_data_dir: .asdf  # i.e. $HOME/.asdf
asdf_config_dir: "{{ asdf_data_dir }}"  # i.e. $HOME/.asdf
```

Sets the directory **with respect to asdf_user's home directory** to store asdf's installation. This is a relative path to the home directory of the user. Because we the `asdf_user` must be defined explicitly for the role as explained next, we need to have paths relative to it. `asdf_data_dir` corresponds to asdf's expected environment variable `ASDF_DIR` and `ASDF_DATA_DIR` while the `ASDF_CONFIG_DIR` environment variable corresponds to this role's `asdf_config_dir` variable. You can read more about how to position the asdf expected directories [here](https://asdf-vm.com/manage/configuration.html#environment-variables).

The `asdf_config_file` is the **filename** of the configuration file that will be stored in `asdf_config_dir`.

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

```yaml
asdf_add_bashrc_sources: false
```

With `asdf_add_bashrc_sources` set to `true` *(and not the default false)* the role will put the sourcing lines into the `~/.bashrc` file of the `asdf_user` so the program can set up the user's environment in a way asdf knows how to deal with it.

```yaml
asdf_plugins: []
```

A list of dictionaries defined in `asdf_plugins` defines all the different asdf plugins that should be installed, the versions of each asdf plugin that should be installed and which version should be `global`, or the default version used by the `asdf_user`. They are defined in the example below.

```yaml
- name: python
  global: 3.9.7
  versions:
    - 2.7.18
    - 3.9.7
- name: nodejs
  global: 17.0.1
  versions:
    - 17.0.1
```

The `name` of each dictionary entry in the list denotes a valid asdf plugin, in the above example that is both `python` & `nodejs`. For each of them, an optional `global` property is set to make that version of either `python` or `nodejs` to that version, in the above example that would be `3.9.7` and `17.0.1` respectively. `versions` defines the versions of the asdf plugin that should be installed as a list of version numbers corresponding to the plugin, so for nodejs that is `17.0.1`.

```yaml
- name: python
  delete_versions:
    - 2.7.18
```

This role can also be used to `delete_versions` of an asdf runtime by creating the same list of dictionaries with a `name` for the `asdf_plugin` and a property `delete_versions` with a list of version strings that should be deleted.

```yaml
asdf_plugin_dependencies: []
```

Because it's very difficult to keep track of all dependencies for all kinds of host systems to install all of asdf-vm's plugins, a variable `asdf_plugin_dependencies` allows for specifying required dependencies for the remote host. A `ansible.builtin.package` task is run before installing any asdf pluginsusing the list of packages in `asdf_plugin_dependencies` making sure that when the task to install asdf plugins runs, all their dependencies are accounted for in this variable.

Dependencies
------------

None

Example Playbook
----------------

```yaml
- name: Converge
  hosts: all
  gather_facts: true
  tasks:
    - name: "Include asdf"
      include_role:
        name: "asdf"
      vars:
        asdf_user: test
        asdf_data_dir: .local/asdf
        asdf_config_dir: .config/asdf
        asdf_add_profile_source: true
        asdf_add_bashrc_sources: true
        # asdf_version: v0.8.1
        asdf_apt_optional_dependencies: [cowsay]
        asdf_plugins:
          - name: python
            versions:
              - 2.7.18
              - 3.9.7
            global: 3.9.7
```

License
-------

GPL3

Author Information
------------------

Marcus Grant (2021) marcusgrant.dev
