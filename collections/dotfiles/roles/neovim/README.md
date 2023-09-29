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
| nvim_appimage   | false | false        | boolean      | Whether to install nvim as an appimage          |
| nvim_version    | false | latest       | semver string| A semver string or 'latest' to download         |

When using an AppImage to install a custom version of neovim which may be quite desirable since a lot of big changes are happening quickly to neovim with regards to its use of lua a few things to keep in mind:
- `nvim_appimage` must be set to true
- `nvim_version` defaults to 'latest' but can be set to any released version of the AppImage as seen on the project's Github releases page:
  - The [Neovim Github Releases](https://github.com/neovim/neovim/releases)

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
