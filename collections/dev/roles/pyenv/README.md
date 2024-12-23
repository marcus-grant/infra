# Ansible Role: marcus_grant.dev.python

An Ansible role for managing Python and PyEnv on target hosts.

## Role Variables

| Variable               | Default        | Description                                          |
| ---------------------- | -------------- | ---------------------------------------------------- |
| `pyenv_install_sys_py` | `false`        | To install system python with package manager        |
| `pyenv_extra_sys_pkgs` | `[]`           | Extra system PyEnv/Python packages to install        |
| `pyenv_root`           | `$HOME/.pyenv` | PyEnv root directory, use $HOME as necessary         |
| `pyenv_version_global` | `system`       | Global Python version to set, use semver or 'system' |
| `pyenv_versions`       | `[]`           | List of Python versions to install with PyEnv        |
| `pyenv_profile_d_path` | **?1**     | Path of a profile.d directory to create shell file   |
| `pyenv_priority`       | `11`           | Prefix to profile.d file for loading lexical order   |
| `pyenv_init`           | `true`         | If to add `eval $(pyenv init -)` to shell            |
| `pyenv_add_path_file`  | N/A            | The shell dotfile to add pyenv configs to            |

>**TODO**: The `pyenv_add_path_file` should be renamed and explained better.
>Essentially it provides an option to ensure lines in profile or shell files that
>put pyenv in PATH and runs the eval init command

### Role Variables Notes

* `pyenv_version_global`
  * If set to `system`, will use the system python version.
  * If set to a semver string, will use that version if it's an available version.
  * Defaults to `system`.
* `pyenv_versions`
  * A list of Python versions to install with PyEnv.
  * Defaults to `[]`, *i.e.* it won't install any version.
* `pyenv_profile_d_path`
  * If set, assumes a profile.d directory exists at the given path.
    * Assumption is that a shell or profile config will load all files in directory.
    * Allows this role to configure PyEnv without modifying other shell configs.
    * `marcus_grant.dotfile.profile` uses `profile_d_path`
      * If this was defined before, it will be used as a default.
  * Defaults to `N/A`, *i.e.* it won't create a file in the profile.d directory.
  * See [marcus_grant.dotfiles.profile](https://github.com/marcus-grant/infra/tree/main/collections/dotfiles/roles/profile)
    for an idea of how this gets used, it creates a `~/.profile.d` directory and
    loads all files within it.
* `pyenv_add_path_file`
  * If this file is given it will add PyEnv configs to the given file.
  * For example if you give `~/.bashrc` it will add PyEnv configs to that file.
  * This is here incase you don't use the `profile.d` directory method.
  * **WARNING**: Using this while ansible managing your shell configs
    will cause ansible to overwrite them on every run.
* `pyenv_init`
  * Whether to add `eval $(pyenv init -)` to shell file.
  * Applies to both the `profile.d` directory and `pyenv_add_path_file` methods.

## Dependencies

None.

## Example Playbook

```yaml
- name: Install Python and PyEnv
  hosts: your_target_hosts
  roles:
    - role: marcus_grant.dev.python
      vars:
        pyenv_install_sys_py: true
        pyenv_extra_sys_pkgs:
          - python3-dev
          - python3-pip
        pyenv_install_curl: true
        pyenv_versions:
          - '3.7.3'
          - '3.11.2'
          - '3.12.0'
        pyenv_version_global: '3.11.2'
```

## Author

* Marcus Grant
* [Personal Site](https://marcusgrant.me)
* [Github](https://github.com/marcus-grant)
* [Mastodon](https://fosstodon.org/@marcusgrant)

## License

This role is licensed under the GPLv3 License.
See the [LICENSE](./LICENSE) file for details.
