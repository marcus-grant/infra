Role Name
=========

A brief description of the role goes here.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

This dependency is entirely optional based on my specific git preferences. I use [`fzf`](marcus_grant.not_coreutil) along with [`fd`](https://github.com/sharkdp/fd) and [`ripgrep`](https://github.com/BurntSushi/ripgrep) as replacements to several GNU coreutil programs. Junegun's utility `fzf` also has a corresponding vim plugin that makes these work together nicely in vim so they make an optional dependency for my particular configuration in this collection called `not_coreutil` since they're rust alternatives to GNU coreutil.

Example Playbook
----------------

Here are the available variables along with their default values, you can also see `defaults/main.yml` for defaults.

```yaml
vim_config_dir: ~/.config/vim
vim_config_vimrc: "{{ vim_config_dir }}/.vimrc"
```

These two variables point out where to actually store all vim configurations. The `vim_config_dir` variable is the directory that is supposed to contain all vim configuration files. Then `vim_config_vimrc` is the path where the expected vimrc file, *(the default entrypoint)* for vim to set configurations is located. This lets custom names for vimrc to be configured, personally I like setting this to `rc.vim` so the file extension tells vim that this is a vim file. To account for that I set `vim_config_dir` to `~/.config/vim/rc.vim`.

```yaml
vim_git_repo: ''
```

Tells git what the URL the repository that holds the vim configurations are stored in and corresponds to the ansible module `ansible.builtin.git` property `repo`. This needs to be specified and has no default that functions.

```yaml
vim_git_version: HEAD
```

A string corresponding to either a branch name, tag, or commit hash that git should clone or pull from the repository. This is useful to for example only pull from a `stable` branch. The default value `HEAD` simply pulls the latest commit from the default branch.

```yaml
vim_git_force: false
```

When pulling or cloning by using git it's always possible that changes exist on the remote machine that have yet to be comitted and this variable tells `ansible.builtin.git` what to do with the unstaged work that already exists before cloning or pulling. If the default `false` is used then it simply won't do anything unless there's no uncommitted/unstaged changes present. If `true`, this role will create a backup directory in the parent directory of `vim_config_dir` before cloning/pulling.

License
-------

GPL3

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
