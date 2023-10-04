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

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: all
  tasks:
    - name: "Include zsh"
      vars:
        zsh_git_repo: https://github.com/marcus-grant/dots-zsh
        zsh_rc_file: rc.zsh
        zsh_profile_file: profile.zsh
        zsh_env_file: env.zsh
        zsh_default_shell: true
        zsh_git_force: true
      ansible.builtin.include_role:
        name: "zsh"
         - role: marcus_grant.dotfiles.zsh
```

License
-------

GPL3

Author Information
------------------

Marcus Grant
[https://marcusgrant.me](https://marcusgrant.me)
[marcusfg@protonmail.com](marcusfg@protonmail.com)
