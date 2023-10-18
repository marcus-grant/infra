# Ansible Collection Role - marcus_grant.dev.pip

A role that installs, configures and manages pip, pipx, poetry packages.
It does so in conjunction with pyenv as well on all their python versions.

## Requirements

A package manager and optionally pyenv.

## Role Variables

| Variable       | Default | Example     | Description                                |
| -------------- | ------- | ----------- | ------------------------------------------ |
| pip_sys        | true    | false       | To install pip in system scope.            |
| pip_sys_pipx   | true    | false       | To install pipx in system scope.           |
| pip_sys_poetry | true    | false       | To install poetry in system scope.         |
| pip_sys_extra  | []      | [pip-tools] | Install Extra pip/py related sys packages. |

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
    pip_sys_extra:
      - pip-tools
      - pip-completion
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
