# marcus_grant.macos.homebrew

A homebrew installer for macOS that also installs taps, casks and packages after
installing homebrew's dependencies and the program itself.

## Requirements

None, macOS comes with everything needed to run this role.

## Role Variables

These are the default variables for this role as visible in defaults/main.yml.
If a variable is required, it won't have a default value.

| Variable          | Default          | Choices | Comments                    |
| ----------------- | ---------------- | ------- | --------------------------- |
| homebrew_prefix   | /opt/homebrew    | str     | Path pointing to homebrew   |
| homebrew_taps     | [*/core, */cask] | [str]   | Enabled repositories (taps) |
| homebrew_packages | []               | [str]   | Packages to install         |
| homebrew_casks    | []               | [str]   | Casks (GUI apps) to install |

> `*`: Denotes the prefix to the string, `homebrew`, the default tap repository.

## Role Tags

These are task-level tags that can be used to run single sets of tasks.

| Tag              | Description                                               |
| ---------------- | --------------------------------------------------------- |
| homebrew-install | Installs homebrew, making the command available           |
| homebrew-tap     | Enables a list of taps for homebrew                       |
| homebrew-package | Installs a list of packages available in taps (NOT casks) |
| homebrew-cask    | Installs a list of casks available in taps (casks ONLY)   |

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: all
      roles:
         - ansible-role-template

License
-------

See license.md

Author Information
------------------

https://cyverse.org