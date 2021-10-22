Role Name
=========

Install & configure git and some helper programs. The community collection `community.general.git_config` gets used to modify git's configurations like user name, default branch, aliases, url shortcuts, credential managers, etc. Also helper programs are given the same treatment, including my favorite git client [`gitui`](https://github.com/Extrawurst/gitui).

Requirements
------------

Because a lot of this role modifies the git configuration file, the community collection [`community.general.git`](https://docs.ansible.com/ansible/latest/collections/community/general/git_config_module.html) gets used. This must be installed through ansible galaxy using the below sample `requirements.yml` file.

```yml
---
collections:
  - name: community.general
```

Role Variables
--------------

Available variables are listed below, along with the default values as shown in this role's `defaults/main.yml`.

```yaml
git_default_branch: main
git_user_name: Ivana Tinkle
git_user_email: ivanatinkle@microsoft.com
```

These three are some of the most common configuration changes people will make to git. The default branch defaults to `main` as that is the most common default branch for most git servers. The `git_user_name` and `git_user_email` however cannot be generalized by defaults and will be left undefined if not given as variables for the role.

Another important and very consequential configuration for git is the pull and rebase options. The different behaviors are discussed [here](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/about-merge-methods-on-github) at GitHub and there's some very strong conflicting opinions on what choice is best. I'm not here to have that argument, the default is to merge commits on pull rather than rebasing them and that's defined by git so this role's default reflects that. It should be a boolean value ie `true`, `false,` `yes` or `no` and not a string.

```yaml
git_pull_rebase: false
```

Dependencies
------------

When the cargo/rust roles are ready, they will be needed for gitui and any other rust git utilies to be installed as many distributions don't have gitui yet.

Example Playbook
----------------

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

