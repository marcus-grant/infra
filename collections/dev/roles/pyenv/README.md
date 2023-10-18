# Ansible Role: marcus_grant.dev.python

An Ansible role for managing Python and PyEnv on target hosts.

## Role Variables

| Variable             | Default        | Description                                                                    |
| -------------------- | -------------- | ------------------------------------------------------------------------------ |
| pyenv_install_sys_py | `false`        | Controls the installation of system Python packages.                           |
| pyenv_extra_sys_pkgs | `[]`           | Additional system Python packages to install.                                  |
| pyenv_root           | `$HOME/.pyenv` | The root directory for PyEnv, use $HOME as necessary.                                                  |
| pyenv_version_global | `system`       | The global Python version to set for PyEnv.                                    |
| pyenv_versions       | `[]`           | List of Python versions to be installed with PyEnv. Defaults to an empty list. |

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

- Marcus Grant
- [Personal Site](https://marcusgrant.me)
- [Github](https://github.com/marcus-grant)
- [Mastodon](https://fosstodon.org/@marcusgrant)

## License

This role is licensed under the GPLv3 License.
See the [LICENSE](./LICENSE) file for details.
