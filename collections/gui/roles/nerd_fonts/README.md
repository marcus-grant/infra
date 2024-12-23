Role Name
=========

Install nerd fonts.

Requirements
------------

* For `curl` or `wget` to be installed and accessible.
* Ansible 2.9 or higher
* Supported Linux distributions:
  * Any distribution with fc-cache for managing font caches (e.g., Ubuntu, Debian, Fedora)
* Internet access to download font archives from Nerd Fonts' GitHub releases.

Role Variables
--------------

### Default Variables

The following variables can be overridden to customize the role behavior:

```yaml
nerd_fonts_dir: "~/.local/share/fonts"
```

* Description: Directory where fonts will be downloaded and extracted
  * Default: `~/.local/share/fonts`

```yaml
nerd_fonts_dicts:
  - { name: "FiraCode", url: "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.zip" }
  - { name: "Iosevka", url: "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/IosevkaTerm.zip" }
  - { name: "BigBlue", url: "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/BigBlueTerminal.zip" }

```

* Description: List of fonts to be installed, including their names and download URLs.
* Default: Includes example fonts (FiraCode, Iosevka, BigBlue).

### Overriding Variables

To customize the fonts or directory, provide your own values in your playbook or inventory.

```yaml
nerd_fonts_dicts:
  - { name: "Hack", url: "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip" }

```

Dependencies
------------

None really.

Example Playbook
----------------

### Basic Example

```yaml
- hosts: all
  roles:
    - role: nerd_fonts
      vars:
        nerd_fonts_dir: "~/.fonts"
```

### Custom Font Example

```yaml
- hosts: all
  roles:
    - role: nerd_fonts
      vars:
        nerd_fonts_dicts:
          - { name: "JetBrainsMono", url: "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip" }
          - { name: "UbuntuMono", url: "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/UbuntuMono.zip" }
```

License
-------

GPLv3

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
