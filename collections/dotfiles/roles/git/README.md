Role Name
=========

Install & configure git and some helper programs. The community collection `community.general.git_config` gets used to modify git's configurations like user name, default branch, aliases, url shortcuts, credential managers, etc. Also helper programs are given the same treatment, including my favorite git client [`gitui`](https://github.com/Extrawurst/gitui). And it includes installing GitHub's CLI [utility](https://cli.github.com/manual/) then using it to add valid public SSH keys generated for GitHub on the remote machine.

Requirements
------------

Because a lot of this role modifies the git configuration file, the community collection [`community.general.git`](https://docs.ansible.com/ansible/latest/collections/community/general/git_config_module.html) gets used. This must be installed through ansible galaxy using the below sample `requirements.yml` file.

```yml
---
collections:
  - name: community.general
```

Also, when `git_ssh_enabled`, the GitHub CLI program is used to upload a public key generated on the remote machine to enable cloning, pushing and pulling based on an SSH connection. To do this the GitHub CLI program must be logged into and the only way to do that non interactively on the remote machine is to pass the program an API token that can be generated in your GitHub account settings page.

To get to the token section of GitHub settings, go to the `Developer settings` menu on the left. Then go to the `Personal access tokens` menu on the left. Now you're on the Personal Access Token page that has a `Generate new token` button towards the top. Click on it and give the token these permissions: `admin:public_key`, `read:org`, `repo`. Crucially, do not make this key last forever. In fact, ideally you'd only give this key a lifetime of a few days to carry out your tasks on a remote machine. This token will need to be set in the `git_gh_token` variable and if you must store it in a git controlled repo, **store it in an ansible vault**.

This isn't a great workflow and I only use it for initial setups of workstation machines like desktops and laptops where I frequently code and want to update my repositories. To prevent this role from constantly attempting to logging into GitHub CLI to reuse this token that will expire I run this role with the `git_ssh_enabled` variable set to `true` only through command line variable definitions like `ansible-playbook playbook.yml -e git_ssh_enabled=true"`. This way the log in and ssh key can be made to only be performed once and the Github token can be set once for a short expiration time without worrying this role will stop future playbook runs by failing to log in and upload the SSH public key.

When this role is run for the first time it's a good idea to logout from Github's CLI client with the command `gh auth logout` since the token should be set to a short expiration time, you can then login using the interactive browser mode it defaults to by using the command `gh auth login`. It will take you to GitHub and if you haven't already, sign in and then it will tell the program you're authorized for your account in a much more secure way than leaving a token open that could leak out of your playbook/collection files.

### Note on Testing

When testing this role using molecule, an ignored vault file is expected by the `converge.yml` playbook in the `molecule/default` directory along with a matching encryption key. It's ignored by `.gitignore` to give better protection of any unplanned leaks of a GitHub API tokens. This means you will need to create the token and store it in an ansible vault file using the command: `ansible-vault create molecule/default/vault.yml`. Then you use `ansible-vault edit` to add the Github token to it.

Role Variables
--------------

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

