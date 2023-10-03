# marcus_grant.macos.mas

A role that installs and uses MAS (Mac App Store, a cli program)
to install/uninstall apps from the App Store.

## Requirements

Homebrew must be installed for this role to work.
Use `marcus_grant.macos.homebrew` to install homebrew.

## Role Variables

These are the default variables for this role as visible in defaults/main.yml.
If a variable is required, it won't have a default value.

| Variable             | Default       | Choices | Comments                               |
| -------------------- | ------------- | ------- | -------------------------------------- |
| mas_homebrew_prefix  | /opt/homebrew | str     | Path pointing to homebrew              |
| mas_installed_apps   | []            | [*]     | List of id & name of apps to install   |
| mas_uninstalled_apps | []            | [*]     | List of id & name of apps to uninstall |

> `*`: Denotes the dictionary of form, `{id: str, name: str}`, within the list.


## Role Tags

These are task-level tags that can be used to run single sets of tasks.

| Tag               | Description                                              |
| ----------------- | -------------------------------------------------------- |
| mas-install       | Installs `mas`, using homebrew                           |
| mas-install-app   | Installs `mas_installed_apps` list of apps (id & name)   |
| mas-uninstall-app | Installs `mas_uninstalled_apps` list of apps (id & name) |

## Dependencies

The sibling role, `marcus_grant.macos.homebrew`,
is required for this role to work.
Or any other role that installs homebrew.

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: all
  roles:
    - name: marcus_grant.macos.homebrew

    - name: marcus_grant.macos.homebrew
      vars:
        homebrew_prefix: /opt/homebrew
      tags: homebrew-install

    - name: marcus_grant.macos.homebrew
      vars:
        homebrew_taps: [homebrew/core, homebrew/cask]
      tags: homebrew-tap

    - name: marcus_grant.macos.homebrew
      vars:
        homebrew_packages: [git, curl, ansible]
      tags: homebrew-package

    - name: marcus_grant.macos.homebrew
      vars:
        homebrew_casks: [github, visual-studio-code, steam]
      tags: homebrew-cask
```

## License

GPL-3.0-or-later

## Author Information

[Personal Site](https://marcusgrant.me)
[GitHub](https://github.com/marcus-grant)
[Mastodon](https://fosstodon.org/@marcusgrant)
