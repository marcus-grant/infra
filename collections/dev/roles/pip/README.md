# Ansible Collection Role - marcus_grant.dev.pip

A role that installs, configures and manages pip, pipx, poetry packages.
It does so in conjunction with pyenv as well on all their python versions.

## Requirements

A package manager and optionally pyenv.

## Role Variables

| Variable            | Default  | Example        | Description                                   |
| ------------------- | -------- | -------------- | --------------------------------------------- |
| pip_sys             | true     | false          | To install pip in system scope.               |
| pip_sys_pipx        | true     | false          | To install pipx in system scope.              |
| pip_sys_poetry      | true     | false          | To install poetry in system scope.            |
| pip_sys_extra       | []       | [pip-tools]    | Install Extra pip/py related sys packages.    |
| pip_packages_common | []       | [numpy,pandas] | Install these pip packs on all pyenv vers.    |
| pip_packages_global | []       | [jupyter]      | Install these pip packs on pyenv global vers. |
| pip_pyenv_root      | ~/.pyenv | ~/.local/pyenv | Root directory of pyenv *(See below)*         |

>**Note:** `pip_pyenv_root` is used to explicitly tell the role where the pyenv root is.
>This is here in the case that the [marcus_grant.dev.pyenv](../pyenv/) role is not used.
>If it is used, then the `pyenv_root` variable should be set.
>If `pyenv_root` is set, then that will be used instead of `pip_pyenv_root`.

## Dependencies

>**TODO:** Should this be an optional dependency?

[marcus_grant.dev.pyenv](../pyenv/)

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
---
- name: Prepare
  hosts: all
  gather_facts: no
  vars:
    pip_sys: true
    pip_sys_pipx: true
    pip_sys_poetry: true
    pip_sys_extra: [pip-completion, pip-tools]
    pip_packages_common: [python-dotenv, numpy, pandas, matplotlib, seaborn]
    pip_packages_global: [jupyter]
    # This is used by pyenv role to determine the root directory of pyenv.
    # The next two lines are vars that are checked in order to
    # determine the pip pyenv version to use.
    pyenv_root: "{{ ansible_env.HOME }}/.pyenv"
    pip_pyenv_root: "{{ ansible_env.HOME }}/.pyenv"
  roles:
    - role: marcus_grant.dev.pyenv
    - role: marcus_grant.dev.pip
```

## License

GPL3

## Author Information

- [Marcus Grant](https://marcusgrant.me/)
- [GitHub](https://github.com/marcus-grant/)
- [Mastodon](https://fosstodon.org/https://fosstodon.org/@marcus_grant/)
