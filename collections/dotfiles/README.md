# Ansible Collection - marcus_grant.dotfiles

My colleciton of Ansible roles and modules that are used to setup myself as a developer or admin for basically all of my systems, be they servers, workstations, containers, or even embedded devices. I'm going to attempt to make these roles as general use as possible, so feel free to use them through ansible galaxy, fork them, or use them as a template for your own collection/roles. If you see a problem with any of them you'd like me to address please file an issue and/or provide pull requests and I'll get to them.

## Roles

* **profile**
  * *Description*:
    Sets up the user's shell profile via templating the `~/.profile` file.
  * [*Role link!*](./roles/profile/)
* **userdirs**
  * *Description*:
    Sets up shell `userdirs` using custom list and `XDG_`* variables.
  * [*Role link!*](./roles/userdirs/)
* **bash**
  * A role that installs, sets as default shell, git clones a dotfiles repo,
    and symlinks all expected file locations to
    their respective locations in the dotfile repo.
  * [*Role link!*](./roles/bash/)
* **zsh**
  * A role that installs then configures a ZSH shell environment using
    a clone git repo of ZSH dotfiles.
  * [*Role link!*](./roles/zsh/)
