# Ansible Role: Fonts

<!-- [![Build Status](https://travis-ci.com/davidalger/ansible-role-boilerplate.svg?branch=master)](https://travis-ci.com/davidalger/ansible-role-boilerplate) -->

Installs a given font accessible via a URL using HTTP(S) to either the shared system directories/caches or to the ansible `become` user given to the role.

## Requirements

None.

## Role Variables

| variable     | default| choices | description                                                 |
|--------------|--------|---------|-------------------------------------------------------------|
| fonts_to_user| false  | boolean | Whether installing to shared system fonts or to role's user |
| fonts_to_get | None   | listdict| A list of dictionaries defined below of where/if  get fonts |

### fonts_to_get Dictionary Properties

| property     | default| choices | description                                                 |
|--------------|--------|---------|-------------------------------------------------------------|
| url          | None   | URL     | A valid URL pointing to a zip file of a font to download    |
| file_pattern | None   | file pattern | A file glob pattern for ansible.find to detect already downloaded files with |

## Dependencies

No role dependencies

## Example Playbook

```yaml
- role: marcus-grant.fonts
  become: someguy
  vars:
    fonts_to_user: true
  tags: [font, fonts, ui]
```

## License

This work is licensed under the GPLv3 license. See LICENSE file for details.

## Author Information

This role was created in 2016 by [Marcus Grant](https://marcusgrant.me).