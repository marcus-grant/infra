Role Name
=========

Installs vim, clones a dotfile repository to your specified location then links the expected `~/.vimrc` & `~/.vim` references to it.

Requirements
------------

Git being installed is the only real requirement for this role

Role Variables
--------------

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

```yaml
vim_git_backup: true
```

When `vim_git_force` is enabled, there's a chance that local changes get overwritten by the git pull that occurs. To preserve those changes as a copied directory set `vim_git_backup` as `true` the default value. However, this creates a lot of directory copies, one for each git pull that changes the local repository. To avoid this set `vim_git_backup` to `false`.

Dependencies
------------

Git is a non-role dependency for this role, the remote system must have it inorder to complete this role under any variable combination.

This dependency is entirely optional based on my specific git preferences. I use [`fzf`](marcus_grant.not_coreutil) along with [`fd`](https://github.com/sharkdp/fd) and [`ripgrep`](https://github.com/BurntSushi/ripgrep) as replacements to several GNU coreutil programs. Junegun's utility `fzf` also has a corresponding vim plugin that makes these work together nicely in vim so they make an optional dependency for my particular configuration in this collection called `not_coreutil` since they're rust alternatives to GNU coreutil.

Example Playbook
----------------

```yaml
- name: Converge
  hosts: all
  tasks:
    - name: "Include vim"
      include_role:
        name: "vim"
      vars:
        vim_config_dir: ~/.config/vim
        vim_vimrc_path: "{{ vim_config_dir }}/vimrc"
        vim_git_version: HEAD
        vim_git_repo: https://github.com/marcus-grant/dots-vim
        vim_git_force: true
```

License
-------

GPL3

Author Information
------------------

Marcus Grant (2021) marcusgrant.dev
