# Ansible Collection - marcus_grant.dev

My collection of roles setting up software development environments.

## Roles

* **git**
  * *Description*:
    Installs git and sets git configs.
  * [*Role link!*](./roles/git/)
* **pip**
  * *Description*:
    Install pip, *optionally* pipx, configure them and install packages.
    This version of the pip role, depends on [pyenv](./roles/pyenv/) and
    performs all actions on all python versions installed with pyenv.
  * [*Role link!*](./roles/pyenv/)
* **pyenv**
  * *Description*:
    Installs pyenv, configure it, install python versions with it
    & configure global version.
  * [*Role link!*](./roles/pyenv/)
