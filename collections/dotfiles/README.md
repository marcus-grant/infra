# Ansible Collection - marcus_grant.dotfiles

My ansible collection for managing dotfiles and shell configurations.
There's some previous work here that I'm not re-using till
I've had time to review and modify it to my current standards.
Any of the roles that exist in this collection but
not listed below are of low quality and should not be used.

## Roles

* **profile**
  * *Description*:
    Sets up the user's shell profile via templating the `~/.profile` file.
  * [*Role link!*](./roles/profile/)
  * **TODO**:
    * Add support for a profile.d folder and sourcing it lexically
      * Allows for other roles to add their own profile configurations.
* **ssh**
  * *Description*:
    Sets up SSH environtment (config, add keys, instruct manual entry).
  * [*Role link!*](./roles/ssh/)
* **git**
  * *Description*:
    Installs git & optional extras and configures global git configs.
  * [*Role link!*](./roles/git/)
* **neovim**
  * *Description*:
    Installs neovim via package manager &
    clones a repository containing its configurations.
  * [*Role link!*](./roles/neovim/)
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
