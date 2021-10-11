Role Name
=========

A brief description of the role goes here.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

* `bash_set_default_shell`
  * Default value: `false`
  * Whether to set a user's default shell to `/bin/bash`
* `bash_dotfiles_repo`
  * **Required**
  * Corresponds to `ansible.builtin.git` parameter `repo`
  * The git repositository remote URL, meant for HTTP references, but if there is a SSH key permitted on the git server that will work as well, but you may want to leave `bash_dotfiles_set_ssh_remote` as undefined or its default value `false`.
* `bash_dotfiles_version`
  * Default value: `HEAD`
  * Corresponds to `ansible.builtin.git` parameter `version`
  * What version of remote repository to clone/pull
  * Can be a branch name, a tag or even a commit hash
* `bash_dotfiles_git_force`
  * Default value: `false`
  * Corresponds to `ansible.builtin.git` parameter `force`
  * Whether this role should forcefully discard any local files in the dotfiles directory to update it with remote content
* `bash_dotfile_version`
  * Default value of `HEAD`, *ie the latest default branch*
  * A version tag, branch name or commit hash to clone/pull from the remote repository
* `bash_dotfiles_dest`
  * **Required**
  * Corresponds to `ansible.builtin.git` parameter `dest`
  * The directory to clone the dotfile repo into


Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

** MY ADDITIONS **

The `git` role from this collection is necessary in any playbook that will run this due to the use of the git module. If ssh is used in the variable `bash_dotfiles_repo` to clone/pull repositories to machines using this rule then role variables either must set a public SSH key to the git server the bash dotfiles are stored in the `git` role or it must have already been set manually using that git server's web interface.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
