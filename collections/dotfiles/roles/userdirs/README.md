# marcus_grant.dotfiles.userdirs

Ansible role to manage user directories,
either explicitly or via XDG environment variables.

## Requirements

None

## Role Variables

Below is a table of variables,
some optional usually with default values or necessary for the role to function.

| Variable                 | Default        | Choices   | Comments                             |
| ------------------------ | -------------- | ----------| ------------------------------------ |
| userdirs_xdg_profile_d   | true           | bool      | Create `XDG_` envars. profile.d file |
| userdirs_profile_d_path  | *              | str(dir)  | Path to directory of profile.d see * |
| userdirs_xdg_mkdirs      | true           | bool      | Ensure below `XDG_` dirs exist       |
| userdirs_xdg_bin_home    | ~/.local/bin   | str(dir)  | Custom value for XDG_BIN_HOME        |
| userdirs_xdg_data_home   | ~/.local/share | str(dir)  | Custom value for XDG_DATA_HOME       |
| userdirs_xdg_config_home | ~/.config      | str(dir)  | Custom value for XDG_CONFIG_HOME     |
| userdirs_xdg_cache_home  | ~/.cache       | str(dir)  | Custom value for XDG_CACHE_HOME      |
| userdirs_xdg_runtime_dir | ~/.cache/run   | str(dir)  | Custom value for XDG_RUNTIME_DIR     |
| userdirs_custom_dirs     | []             | [str(dir)]| List of paths to create extra dirs   |

> **\***: Default of `userdirs_profile_d_path` can be either of these:
> `profile_d_path` a role variable to `marcus_grant.dotfiles.profile`,
> `~/.config/profile.d` this is also the default value to `profile_d_path`.
> If both `userdirs_profile_d_path` & `profile_d_path` are undefined,
> the default to `profile_d_path` of `~/.config/profile.d` gets used.

### Role Variables Exaplanation

The main thing this role does is to define either custom directories to
ensure are created or
to create a partial profile file in a `profile.d` directory that
gets sourced by the shell profile file in `~/.profile`.
There's XDG variables associated with some important default user directories.
These can be overriden to different paths for various purposes.

To create a partial profile.d file named `10-userdirs.sh`
you enable with `userdirs_xdg_profile_d`.
Then the variables `userdirs_xdg_{bin_home,data_home,config_home,cache_home,runtime_dir}`
will define the paths to their correspondingly named XDG variables as environment vars.

Then if `userdirs_xdg_mkdirs` is enabled,
the role will ensure the directories exist.
As in how those environment variables define them.
So if you want to change them from default or just ensure the default values of
directories exist, the default value of `true` for `userdirs_xdg_mkdirs`.

## Dependencies

Only XDG environment variables are optionally required.
If that is the case, sibling role `marcus_grant.dotfiles.profile` can be used.

## Example Playbook

```yaml
- hosts: all
  tasks:
    - name: "Include zsh"
      vars:
        userdirs_xdg_use: true
        userdirs_custom_dirs:
          - "{{ ansible_env.HOME }}/bin"
          - "{{ ansible_env.HOME }}/.cache/run"
      ansible.builtin.include_role:
        name: "zsh"
         - role: marcus_grant.dotfiles.zsh
```

## License

GPL3

## Author Information

Marcus Grant
[https://marcusgrant.me](https://marcusgrant.me)
[marcusfg@protonmail.com](marcusfg@protonmail.com)
[github:marcus-grant](https://github.com/marcus-grant)
