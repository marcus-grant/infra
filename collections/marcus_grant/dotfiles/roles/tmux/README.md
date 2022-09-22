Role Name
=========

Install TMux, clone a dotfile/configuration repo for it, place links to it from the locations TMux expects, and finally copy TPM *TMux Plugin Manager* into it.

Requirements
------------

Git is the only remote host requirement.

Role Variables
--------------

Here are the available variables along with their default values, which can also be found in the `defaults/main.yml` file.

```yaml
tmux_config_dir: ~/.config/tmux
tmux_conf_path: "{{ tmux_config_dir }}/.tmux.conf"
```

These two variables point to where the config/dotfile directory should be pulled to on the remote machine having this role run on it. The `vim_config_dir` variable is the directory to be pulled to. Then `tmux_conf_path` is the main configuration file within that directory that TMux will read to configure itself, and this role will link to where TMux usually looks for this file `~/.tmux.conf`.

```yaml
tmux_git_repo: ''
```

The git repository to pull from into the directory `tmux_config_dir`. This variable only has a default empty string, it must be defined in order to function.

```yaml
tmux_git_version: HEAD
```

A string representing either a branch name, tag or commit hash of the repository specified in `tmux_git_repo` that ansible's git module should pull into the remote machine. The default value is `HEAD` representing the latest commit of the default branch. This could be used to pull for example a `stable` branch for use on servers where stability is important.

```yaml
tmux_git_force: false
```

When pulling or cloning by using git it's possible that changes exist on the remote machine that have yet to be committed. The variable `tmux_git_force`, which defaults to `false`, let's you chose whether to pull the remote changes and override the local changes yet to be committed, or simply not pull anything from the repository. This role will create a backup of the local changes before pulling the remote repository changes if `tmux_git_force` is set to true to prevent losing any local changes.

```yaml
tmux_tpm_enable: true
```

TMux has a plugin manager called `tpm`, which this role can install using `tmux_tpm_enable`. After it has been installed simply hit the key combo: `Ctrl+I` *(I as in capital I with the shift key)* and let TMux prompt you to reload the configuration.

Dependencies
------------

Git is the only dependency here, it must be installed on the remote machine being controlled through ansible by this role.

Example Playbook
----------------

```yaml
- hosts: all
  tasks:
    - name: "Include tmux"
      include_role:
        name: "tmux"
      vars:
        tmux_config_dir: ~/.config/tmux
        tmux_conf_path: "{{ tmux_config_dir }}/tmux.conf"
        tmux_tpm_enable: true
        tmux_git_repo: https://github.com/marcus-grant/dots-tmux
        tmux_git_version: HEAD
        tmux_git_force: true
```

License
-------

GPL3

Author Information
------------------

Marcus Grant (2021) marcusgrant.dev
