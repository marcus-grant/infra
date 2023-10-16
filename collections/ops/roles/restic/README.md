# marcus_grant.ops.restic

A role that installs, configures (globally & per-repo) restic,
then sets up automatic snapshot taking per repo.

## Requirements

None

## Role Variables

These are the default variables for this role as visible in `defaults/main.yml`.
If a variable is required, it won't have a default value.

| Variable         | Default | Choices | Comments                          |
| ---------------- | ------- | ------- | --------------------------------- |
| *_extra_pkgs | []      | [str]   | List of extra packages to install |

> `*`: A shortening of the role variable role prefix `restic`,
> for example `*_install` represents `restic_install`.

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
