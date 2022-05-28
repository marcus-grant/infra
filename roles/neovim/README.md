Neovim Dotfiles Role
====================

Clone/Pull any git repository containing a Neovim dotfiles directory then linking them to the correct places and running any initializations needed.

Requirements
------------

Git needs to be installed for this to work.

Role Variables
--------------

Below is a table of variables, some optional usually with default values or their manual definition is necessary for the role to function.

|     Variable    | Needed|    Default   |   Choices    |                     Comments                    |
|:---------------:|:-----:|:------------:|:------------:|:-----------------------------------------------:|
| nvim_git_repo   | true  | None         | git repo url | Where to clone/pull dotfile repo from           |
| nvim_config_dir | false |~/.config/nvim| folder path  | Where the dotfiles should be stored/linked      |
| nvim_git_version| false | HEAD         |git branch/tag| Which branch/tag to clone or pull               |
| nvim_git_force  | false | false        | boolean      | Whether to force pull repositories on config_dir|
|nvim_default_editor|false| false        | boolean      |Whether nvim should be the default (EDITOR=nvim) |


Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: all
  tasks:
    - name: "Include neovim"
      vars:
        nvim_git_repo: https://github.com/marcus-grant/dots-neovim4
        nvim_git_force: true
        nvim_default_editor: true
      ansible.builtin.include_role:
        name: "neovim"
         - role: marcus_grant.dotfiles.neovim
```

License
-------

GPL3

Author Information
------------------

Marcus Grant
[https://marcusgrant.me](https://marcusgrant.me)
[marcusfg@protonmail.com](marcusfg@protonmail.com)
