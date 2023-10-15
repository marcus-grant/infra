# marcus_grant.dotfiles.git

Configures git and installs git related packages.

## Requirements

Only a package manager.

## Role Variables

Available variables are listed below, along with the default values as shown in this role's `defaults/main.yml`.

```yaml
git_default_branch: main
git_user_name: Ivana Tinkle
git_user_email: ivanatinkle@microsoft.com
git_pull_rebase: false
git_extra_packages: []
```

## Dependencies

Only a package manager

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: laptops
  roles:
  - role: marcus_grant.git
    vars:
      git_default_branch: dev
      git_user_name: Ivana Tinkler
      git_user_email: ivanatinkler@microsoft.com
      git_pull_rebase: true
```

License
-------

GPL3

Author Information
------------------

Marcus Grant (2021)
marcusgrant.dev
github.com/marcus-grant
marcusfg@protonmail.com

