# marcus_grant.dotfiles.userdirs

Ansible role to manage user directories,
either explicitly or via XDG environment variables.

## Requirements

None

## Role Variables

Below is a table of variables,
some optional usually with default values or necessary for the role to function.

| Variable             | Default | Choices | Comments                                  |
| -------------------- | ------- | ------- | ----------------------------------------- |
| userdirs_xdg_use     | true    | bool    | Whether to create `XDG_` env. vars. dirs  |
| userdirs_custom_dirs | []      | [str]   | List of paths to create extra directories |

## Dependencies

Only XDG environment variables are optionally required.
If that is the case, sibling role `marcus_grant.dotfiles.profile` can be used.

## Example Playbook

```yaml
- hosts: all
  tasks:
    - name: "Include zsh"
      vars:
        userdirs_xdg_use: true
        userdirs_custom_dirs:
          - "{{ ansible_env.HOME }}/bin"
          - "{{ ansible_env.HOME }}/.cache/run"
      ansible.builtin.include_role:
        name: "zsh"
         - role: marcus_grant.dotfiles.zsh
```

## License

GPL3

## Author Information

Marcus Grant
[https://marcusgrant.me](https://marcusgrant.me)
[marcusfg@protonmail.com](marcusfg@protonmail.com)
[github:marcus-grant](https://github.com/marcus-grant)
