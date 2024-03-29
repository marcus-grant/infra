# marcus_grant.ops.rancher

A role to setup rancher based systems on a machine.
Mainly rancher desktop, nerdctl, etc.
Good for macOS that needs some finagling to get rancher/docker/kubernetes.

## Requirements

None

## Role Variables

These are the default variables for this role as visible in `defaults/main.yml`.
If a variable is required, it won't have a default value.

| Variable | Default | Choices | Comments |
| -------- | ------- | ------- | -------- |
| None     |         |         |          |

> There are no role variables so far, including this installs rancher desktop.

## Dependencies

None

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: all
  vars:  # Most taken from defaults/main.yml
    # None so far
    # rancher_install_rancher: true
    # rancher_install_nerdctl: true

  roles:
    - name: marcus_grant.ops.rancher
```

## License

GPL-3.0-or-later

## Author Information

[Personal Site](https://marcusgrant.me)
[GitHub](https://github.com/marcus-grant)
[Mastodon](https://fosstodon.org/@marcusgrant)
