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
| zsh_rc_file            | false  | zshrc        | filename       | Filename inside repo that .zshrc sources    |
| zsh_profile_file       | false  | zprofile     | filename       | Filename inside repo that .zprofile sources |
| zsh_env_file           | false  | zshenv       | filename       | Filename inside repo that .zshenv   sources |
| zsh_git_repo           | true   | n/a          | git repo url   | Where to clone/pull dotfile repo from             |
| zsh_git_version        | false  | HEAD         | git branch/tag | Which branch/tag to clone or pull                 |
| zsh_git_force          | false  | false        | boolean        | Whether to force pull repositories on config_dir  |
<!-- | zsh_git_backup   | false  | true       | boolean      | Backup dotfile directory if zsh_git_force        | -->

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

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
