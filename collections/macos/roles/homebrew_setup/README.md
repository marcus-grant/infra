# marcus_grant.macos.homebrew-setup

A homebrew installer for macOS, that installs its dependencies then brew.

## Requirements

None, macOS comes with everything needed to run this role.

## Role Variables

These are the default variables for this role as visible in defaults/main.yml.
If a variable is required, it won't have a default value.

| Variable              | Default       | Choices | Comments                  |
| --------------------- | ------------- | ------- | ------------------------- |
| homebrew_setup_prefix | /opt/homebrew | str     | Path pointing to homebrew |

## Role Tags

These are task-level tags that can be used to run single sets of tasks.

| Tag            | Description                                     |
| -------------- | ----------------------------------------------- |
| homebrew-setup | Installs homebrew, making the command available |

## Dependencies

None

## Example Playbook

```yaml
- hosts: all
  roles:
    - name: marcus_grant.macos.homebrew-setup

    - name: marcus_grant.macos.homebrew-setup
      vars:
        homebrew_prefix: /opt/homebrew
      tags: homebrew-setup
```

## License

GPL-3.0-or-later

## Author Information

[Personal Site](https://marcusgrant.me)
[GitHub](https://github.com/marcus-grant)
[Mastodon](https://fosstodon.org/@marcusgrant)
