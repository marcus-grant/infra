# marcus_grant.dotfiles.zsh

Ansible role to clone a dotfile repository holding ZSH configuration files and
templating expected ZSH files that source the dotfiles in the cloned directory.
Also optionally sets as the default shell and
installs ZSH along with extra packages.

## Requirements

Only git is required.

## Role Variables

Below is a table of variables,
some optional usually with default values or necessary for the role to function.

| Variable               | Needed | Default      | Choices        | Comments                                          |
| ---------------------- | ------ | ------------ | -------------- | ------------------------------------------------- |
| zsh_shell_as_default   | false  | false        | bool           | Whether to set ZSH as default shell               |
| zsh_default_shell_path | false  | /usr/bin/zsh | command path   | Where the desired ZSH binary to use as default is |
| zsh_parent_dir         | false  | ~/.config    | dir path       | Parent directory to clone dotfile repo into       |
| zsh_config_dir_name    | false  | zsh          | dir name       | Name of directory in zsh_parent_dir to clone to   |
| zsh_rc_file            | false  | zshrc        | filename       | Filename inside repo that .zshrc sources          |
| zsh_profile_file       | false  | zprofile     | filename       | Filename inside repo that .zprofile sources       |
| zsh_env_file           | false  | zshenv       | filename       | Filename inside repo that .zshenv   sources       |
| zsh_env_source_profile | false  | true         | bool           | Whether .zshenv should source ~/.profile          |
| zsh_git_repo           | true   | n/a          | git repo url   | URL where the ZSH dotfile repo can be cloned from |
| zsh_git_version        | false  | HEAD         | git branch/tag | Which branch/tag to clone or pull                 |
| zsh_git_force          | false  | false        | boolean        | Whether to force pull repositories on config_dir  |

## Dependencies

Optional dependency on the sibling role `marcus_grant.dotfiles.profile`.
This can be used to define the `profile` file that is sourced by the `zshenv`.
Recommended to use it, but not needed.

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: all
  tasks:
    - name: "Include zsh"
      vars:
        zsh_git_repo: https://github.com/marcus-grant/dots-zsh
        zsh_shell_as_default: false
        zsh_default_shell_path: /usr/bin/zsh
        zsh_parent_dir: ~/.config
        zsh_config_dir_name: zsh
        zsh_rc_file: zshrc
        zsh_profile_file: zprofile
        zsh_env_file: zshenv
        zsh_env_source_profile: true
        zsh_git_version: HEAD
        zsh_git_force: false
        zsh_extra_packages: [zsh-autopair]

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
