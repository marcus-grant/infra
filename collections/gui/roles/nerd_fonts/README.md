# nerd_fonts

Installs Nerd Fonts for the current user by downloading zip archives from
GitHub releases, extracting them, and updating the font cache.

## Requirements

- Internet access to download font archives from Nerd Fonts GitHub releases
- Ansible 2.9 or higher
- Supported platforms: Linux (any distro with `fontconfig`), macOS (via Homebrew)

## Role Variables

### Default Variables

```yaml
nerd_fonts_dir: ~/.local/share/fonts
```

Directory where fonts will be downloaded and extracted.

```yaml
nerd_fonts_dicts:
  - name: FiraCode
    file: FiraCode.zip
    url: "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip"
  - name: SourceCodePro
    file: SourceCodePro.zip
    url: "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/SourceCodePro.zip"
```

List of fonts to install. Each entry requires:

- `name` — directory name the font will be extracted into
- `file` — zip filename used for download destination
- `url` — full download URL to the zip archive

### macOS-only Variables

```yaml
nerd_fonts_list:
  - font-fira-code-nerd-font
  - font-hack-nerd-font
```

Homebrew cask names used on macOS. Not used on Linux.

## Dependencies

None.

## Example Playbook

### Basic usage

```yaml
- hosts: all
  roles:
    - role: marcus_grant.gui.nerd_fonts
```

### Custom fonts

```yaml
- hosts: all
  roles:
    - role: marcus_grant.gui.nerd_fonts
      vars:
        nerd_fonts_dicts:
          - name: JetBrainsMono
            file: JetBrainsMono.zip
            url: "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip"
```

### Custom install directory

```yaml
- hosts: all
  roles:
    - role: marcus_grant.gui.nerd_fonts
      vars:
        nerd_fonts_dir: ~/.fonts
```

## License

MIT-0

## Author

Marcus Grant
