# marcus_grant.dotfiles.profile

A role that partially sets up shell environments by templating the profile file.

## Requirements

Homebrew's `brew` command must be available on the system.

## Role Variables

These are the default variables for this role as visible in defaults/main.yml.
If a variable is required, it won't have a default value.

| Variable          | Default          | Choices | Comments                    |
| ----------------- | ---------------- | ------- | --------------------------- |
| homebrew_prefix   | /opt/homebrew    | str     | Path pointing to homebrew   |
| homebrew_taps     | [*/core, */cask] | [str]   | Enabled repositories (taps) |
| homebrew_packages | []               | [str]   | Packages to install         |
| homebrew_casks    | []               | [str]   | Casks (GUI apps) to install |

> `*`: Denotes the prefix to the string, `homebrew`, the default tap repository.

## Role Tags

These are task-level tags that can be used to run single sets of tasks.

| Tag              | Description                                               |
| ---------------- | --------------------------------------------------------- |
| homebrew-tap     | Enables a list of taps for homebrew                       |
| homebrew-package | Installs a list of packages available in taps (NOT casks) |
| homebrew-cask    | Installs a list of casks available in taps (casks ONLY)   |

## Dependencies

Homebrew must be installed,
`marcus_grant.macos.homebrew-setup` is a good role to use for this.

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: all
  roles:
    - name: marcus_grant.macos.homebrew

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
