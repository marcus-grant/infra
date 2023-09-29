GPG Role
========

Role to install GPG with several helper utilities like pinentry and gpgme and optionally transfer keys from the ansible controller machine to the remote machine.


Requirements
------------

The only requirements are a gpg made `~/.gnupg` directory to copy its keyring from the ansible controller to the remote host **if** the `gpg_copy_keyring` variable is set to true. And along with that read permission must be given to the ansible controller user to read the keyring.

Role Variables
--------------

All role variables are listed below, along with default values, which you can see in `defaults/main.yml`.

```yaml
gpg_gpgme_enable: false
gpg_pinentry_enable: false
gpg_copy_keyring: false
gpg_copy_keyring_force: false

# Variables without defaults
gpg_extra_packages:
    - seahorse
    - pinentry-qt4
```

Extra packages can be installed using `gpg_extrapackages` as a list of any package manager name for packages, so technically you could install any valid package name from here as well.

The `gpg_gpgme_enable` variable installs the distro-specific gpgme software package many programs use to interact seamlessly with gpg keys. `gpg_pinentry_enable` installs pinentry which prompts you for the gpg passphrase whenever the keyring needs to be unlocked either through the terminal or through a dialog window on your GUI.

Then there's the option to copy your whole keyring directory, typically located in `~/.gnupg` from the machine running ansible to any remote host this role is being run on. This is enabled by `gpg_copy_keyring` and if you want to force the copy to go happen despite local files existing *potentially dangerous*, you enable that with `gpg_copy_keyring_force`. You'll want to be careful with forcing the copy, because you might lose any non backed up keyrings that exist locally already.

Dependencies
------------

None <!-- TODO this might need to include ansible.posix.synchronize in the future -->

Example Playbook
----------------

```yaml
- hosts: all
    roles:
    - role: marcus_grant.dotfiles.gpg
      vars:
        gpg_extra_packages: [pinentry-gtk2, seahore]
        gpg_pinentry_enable: true
        gpg_copy_keyring: true
```

License
-------

GPL

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
