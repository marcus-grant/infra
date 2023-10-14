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
git_gh_enabled: false
git_ssh_enabled: false
git_gh_token: ''
git_ssh_key_title: ''
```

These three are some of the most common configuration changes people will make to git. The default branch defaults to `main` as that is the most common default branch for most git servers. The `git_user_name` and `git_user_email` however cannot be generalized by defaults and will be left undefined if not given as variables for the role.

Another important and very consequential configuration for git is the pull and rebase options. The different behaviors are discussed [here](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/about-merge-methods-on-github) at GitHub and there's some very strong conflicting opinions on what choice is best. I'm not here to have that argument, the default is to merge commits on pull rather than rebasing them and that's defined by git so this role's default reflects that. It should be a boolean value ie `true`, `false,` `yes` or `no` and not a string.

```yaml
git_pull_rebase: false
```

If you want to have GitHub's CLI client installed, or you want to add a valid SSH public key for the remote machine to use with git operations, set `git_gh_enable` to `true`. This will install the program.

If you want to use the Github CLI to upload a public SSH key that this role will generate for the remote machine named `~/.ssh/git.key` with a key length of 4096 bits (the maximum) you're going to need to set `git_ssh_enabled` to true. That's not all though, you also need to use the process described in the previous requirements section to go to GitHub, generate a token and set that token as the value of `git_gh_token` and optionally give this key a title on Github using `git_ssh_key_title`.

Again, this poses a potential security risk if misused. The GitHub token should be set to a short expiration time, ideally less than a month. It shouldn't be stored anywhere unencrypted, especially not in an ansible playbook without a vault. Ideally you'll use this role in a playbook with the `git_gh_token`, `git_ssh_key_title` and `git_ssh_enabled` set to true and the GitHub token only once, and let their false and empty string defaults be used every other time this role is used on that machine.


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

