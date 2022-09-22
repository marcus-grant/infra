Bash Role
=========

A role that controls the bash environment of remote systems. Includes installing bash, setting it to default shell, using git to clone a dotfile repository and linking the files within it to the expected locations in the home directory.

Requirements
------------

This role will make use of git to clone in dotfile repositories from remote git servers like github, so obviously git is a requirement here. I'm eventually working on a git role in this colleciton and that will be linked to in this role's meta description. An optional dependency is my SSH role in this collection which can be set to configure ssh keys, ssh config entries and use the github/gitlab/gitea API with vaulted API key vars to send an SSH public key to the git server. This is necessary to be able to use this role with an SSH url in the variable `dotfiles_bash_repo`.

Role Variables
--------------

The role variables are all listed below in list format.

* `bash_set_default_shell`
  * Default value: `false`
  * Whether to set a user's default shell to `/bin/bash`
* `dotfiles_bash_repo`
  * **Required**
  * Corresponds to `ansible.builtin.git` parameter `repo`
  * The git repositository remote URL
  * Can be either an SSH or HTTPS URL
  * If SSH is given, then a valid public key for this machine must be configured both locally and for the remote git server or this role will fail
* `dotfiles_bash_version`
  * Default value: `HEAD`
  * Corresponds to `ansible.builtin.git` parameter `version`
  * What version of remote repository to clone/pull
  * Can be a branch name, a tag or even a commit hash
* `dotfiles_bash_git_force`
  * Default value: `false`
  * Corresponds to `ansible.builtin.git` parameter `force`
  * Whether this role should forcefully discard any local files in the dotfiles directory to update it with remote content
* `dotfiles_bash_version`
  * Default value of `HEAD`, *ie the latest default branch*
  * A version tag, branch name or commit hash to clone/pull from the remote repository
* `dotfiles_bash_dest`
  * **Required**
  * Corresponds to `ansible.builtin.git` parameter `dest`
  * The directory to clone the dotfile repo into
* `dotfiles_bash_backup`
  * Default value: `false`
  * Determines if any local `~/.bashrc` or `~/.bash_profile` file should be backed up to a filename `/.bashrc.{{ISO8601TIMESTAMP}}.bak`
  * Every run of this role will delete any `~/.bashrc` instance on the remote user if it is a regular file, and relink it if it exists
  * This gives the option to keep a copy of the original `~/.bashrc` or `~/.bash_profile` files if it already exists and you want to keep it somewhere
* `dotfiles_bash_bashrc`
  * **Required**
  * The path to the ~/.bashrc file in the dotfile repo that will be linked to from bash's expected location `~/.bashrc`
* `dotfiles_bash_profile`
  * **Required**
  * The path to the `~/.bash_profile` file in the dotfile repo that will be linked to from bash's expected location `~/.bashrc`
Dependencies
------------

The `git` role from this collection is necessary in any playbook that will run this due to the use of the git module. If ssh is used in the variable `dotfiles_bash_repo` to clone/pull repositories to machines using this rule then role variables either must set a public SSH key to the git server the bash dotfiles are stored in the `git` role or it must have already been set manually using that git server's web interface.

Example Playbook
----------------

    - hosts: servers
      roles:
        - name: marcus_grant.dotfiles.bash
          vars:
            bash_set_default_shell: true
            dotfiles_bash_repo: 'https://github.com/marcus-grant/dots-bash'
            dotfiles_bash_dest: ~/.config/bash
            dotfiles_bash_git_force: true
            dotfiles_bash_bashrc: '{{ dotfiles_bash_dest }}/bashrc'
            dotfiles_bash_profile: '{{ dotfiles_bash_dest }}/bashprofile'
            dotfiles_bash_backup: false


License
-------

AGPLv3

Author Information
------------------

Marcus Grant
marcusfg@protonmail.com
marcusgrant.dev
