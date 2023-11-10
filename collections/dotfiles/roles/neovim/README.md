# Neovim Dotfiles Role

Install neovim and manage its dotfiles via git.

## Requirements

Only git.

## Role Variables

Below is a table of variables,
defaults are listed here as they appear in `defaults/main.yml`.

| Variable          | Default          | Choices   | Comments                                         |
| ----------------- | ---------------- | --------- | ------------------------------------------------ |
| neovim_pkgs_extra | `[]`             | Packages  | List of extra packages to install.               |
| neovim_config_dir | `~/.config/nvim` | Dir path  | Path string where nvim configs should go.        |
| neovim_git_repo   | `''`             | Repo URL  | URL to dotfile git repo, doesn't pull if absent. |
| neovim_git_vers   | `HEAD`           | Git vers. | Git version string of dotfile repo to clone.     |
| neovim_git_force  | `false`          | Bool      | If to force git pull if directory is present.    |

### Role Variables - Extra Notes

* `neovim_pkgs_extra`:
  * This is a list of extra packages to install with system package manager.
  * This is useful for installing language servers and other plugins.
  * In my case I always use neovim with `fzf`, `ripgrep`, `fd` and `tree-sitter`.
* `neovim_git_repo`:
  * Not providing a value for this will skip any task involved in
    cloning the dotfile repo into the `neovim_config_dir`.
* `neovim_git_vers`:
  * This corresponds to the git version string to use to
    clone or pull the dotfile repo.
  * This includes branch names, tags, and commit hashes.
  * The default `HEAD` will always pull the latest changes.
* `neovim_git_force`:
  * Corresponds to Ansible's
    [`ansible.builtin.git`][ansible.builtin.git] `force` parameter.
  * If something is already present at `neovim_config_dir`
    and this is set to `true` then the dotfile repo will be
    force pulled.
  * Can cause loss of data in the local configuration repository if
    the remote repository has been updated since the last pull.

## Dependencies

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: all
  vars:
    neovim_git_repo: git@github.com:marcus-grant/dots-neovim.git
    neovim_pkgs_extra: [fzf, ripgrep, fd, tree-sitter]
    neovim_config_dir: ~/.config/nvim
    neovim_git_vers: HEAD
    neovim_git_force: false
  roles:
    - role: marcus_grant.dotfiles.neovim
```

## License

GPL3

## Author Information

Marcus Grant
[https://marcusgrant.me](https://marcusgrant.me)
[marcusfg@protonmail.com](marcusfg@pm.me)

<!-- Reference Links -->
[ansible.builtin.git]: https://docs.ansible.com/ansible/latest/collections/ansible/builtin/git_module.html "Ansible Module Documentation: ansible.builtin.git"
