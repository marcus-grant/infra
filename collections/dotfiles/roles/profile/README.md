# marcus_grant.dotfiles.profile

A role that partially sets up shell environments by templating the profile file.

## Requirements

None

## Role Variables

These are the default variables for this role as visible in defaults/main.yml.
If a variable is required, it won't have a default value.

| Variable               | Default | Choices | Comments                             |
| ---------------------- | ------- | ------- | ------------------------------------ |
| profile_group          | `sudo`  | group   | Group owner, mac has NO sudo         |
| profile_paths          | `[]`    | [path]  | Add to PATH (earlier override later) |
| profile_lc_all         | **&**   | locale  | LC_ALL value, override all locale    |
| profile_editor         | `vim`   | command | Default editor command               |
| profile_ls_colors      | **^**   | options | [LS_COLORS][lsc] options string      |
| profile_d_path         | **+**   | path    | Default editor command               |
| profile_xdg_include    | `false` | bool    | *See below XDG section*              |
| profile_envs           | `[]`    | [{}]    | *See Custom Environment Variables*   |
| profile_custom_entries | `[]`    | [{}]    | *See Custom Entries Section*         |

> `&`: Shortens default string of `en_US.UTF-8`.
> `^`: Shortens the default LS_COLORS string shown in `defaults/main.yml` of role.
> `+`: Shortens default path `~/.config/profile.d`.
> ... it's quite long, no need to show here.

### Role Variable Notes

* `profile_paths`
  * This is a list of paths to add to the `$PATH` variable.
  * Earlier paths override later paths.
* `profile_lc_all`
  * This is the `LC_ALL` variable value.
  * It overrides all other locale variables.
  * It's recommended to set this to `en_US.UTF-8` for UTF-8 support.
  * Another good option is the `C` locale for POSIX support.
  * Beyond scope to explain locale variables here.
* `profile_ls_colors`
  * This is the `LS_COLORS` variable value.
  * It's a string of options that define the colors for `ls`.
  * It has different defaults depending on if it's linux or mac/BSD.
* `profile_d_path`
  * This is the path to the `profile.d` folder.
  * It's common practice in POSIX environments to name a folder `*.d` when
    it contains a collection of files that are sourced by a program.
  * This is where custom profile entries are stored.
  * It makes it easier for other roles to add their own profile entries.
  * It's lexically sorted, so to order their sourcing, prefix with a number.

### Role Variables (XDG)

These variables are specific to XDG environment variable definitions.
These can be defined or ignored according to `profile_xdg_include`.
It's a good idea to use `$HOME` when the path is relevant to user home.

| Variable    | Default          | Choices | Comments                       |
| ----------- | ---------------- | ------- | ------------------------------ |
| include     | `false`          | bool    | If to include XDG definitions  |
| config_home | *`/.config`      | str     | `XDG_CONFIG_HOME` path string  |
| data_home   | *`/.local/share` | str     | `XDG_DATA_HOME` path string    |
| cache_home  | *`/.cache`       | str     | `XDG_CACHE_HOME` path string   |
| bin_home    | *`/.local/bin`   | str     | `XDG_BIN_HOME` path string     |
| runtime_dir | *`/.cache/run`   | str     | `XDG_RUNTIME_HOME` path string |

> `_abc`: Shortens the role prefix of the XDG variables, ie `profile_xdg_abc`
> `*`: Shortens default path prefix `$HOME`.

### Role Variables (Custom Environment Variables)

Custom environment variables can be added to the `profile_env` variable as
a list of dictionaries.
The dictionary must have a `name` and `value` key,
representing the environment variable name and value respectively.
The order determines where in the file the variable is defined, earliest first.

```yaml
profile_envs:
  - name: "MY_VAR"
    value: "my value"
  - {name: "MY_VAR2", value: "my value 2"}
```

### Role Variables (Custom Profile Entries)

These are custom line-by-line entries that gets added to the end of the profile.
They're stored as a list of strings, with each string representing a line,
in the order they will be added to the profile.

```yaml
profile_custom_entries:
  - "hello='Hello World!'"
  - "echo $hello"
  - "/some/script/path/startup-script.sh"
```

## Role Tags

None

## Dependencies

None

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: all
  vars:  # Most taken from defaults/main.yml
    profile_group: sudo  # Remember macOS doesn't have this, maybe use staff, wheel or admin
    profile_paths: [/opt/mybin, ~/.local/bin]  # List of paths to add to $PATH, earlier overrides later
    profile_lc_all: en_US.UTF-8
    profile_xdg_include: false
    profile_xdg_config_home: $HOME/.config  # Defines XDG_CONFIG_HOME
    profile_xdg_data_home: $HOME/.local/share  # Defines XDG_DATA_HOME
    profile_xdg_cache_home: $HOME/.cache  # Defines XDG_CACHE_HOME
    profile_xdg_bin_home: $HOME/.local/bin  # Defines XDG_BIN_HOME
    profile_xdg_runtime_dir: $HOME/.cache/run  # Defines XDG_RUNTIME_DIR
    profile_d_path: ~/.config/profile.d  # Defines where to store custom profile entries
    profile_editor: emacs
    profile_envs:
    - name: "MY_VAR"
      value: "my value"
    - {name: "MY_VAR2", value: "my value 2"}
    profile_custom_entries:
    - "hello='Hello World!'"
    - "echo $hello"
    - "/some/script/path/startup-script.sh"

  roles:
    - name: marcus_grant.dofiles.profile
```

## License

GPL-3.0-or-later

## Author Information

[Personal Site](https://marcusgrant.me)
[GitHub](https://github.com/marcus-grant)
[Mastodon](https://fosstodon.org/@marcusgrant)

[lsc]: https://linuxopsys.com/topics/colors-for-ls-mean-change-colors-for-ls-in-bash "LS Colors"
