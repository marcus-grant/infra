Flatpak
=======

Install flatpak and helper programs along with any desired flatpaks

Requirements
------------

None

Role Variables
--------------

### Variables with Defaults

Available variables are listed below, along with the default values as shown in this role's `defaults/main.yml`.

```yaml
flatpak_install_gnome_software: false
```

Whether the flatpak GUI for GNOME should be installed, defaults to `false`.

```yaml
flatpak_user_flatpaks: [org.gnome.gedit]  # list of flatpaks USER
flatpak_system_flatpaks: [org.gnome.Calender]  # list of flatpaks SYSTEM
```

Specify a list of flatpaks to have ansible install for you. The `user` variable specifies flatpaks that will be installed on the currently managed user only. `system` specifies systemwide installs.



### Required Variable Definitions

### Known Hosts

Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: laptops
  roles:
  - role: marcus_grant.flatpak
    vars:
      flatpak_install_gnome_software: true
      flatpak_user_flatpaks: [org.mojang.Minecraft,org.freecadweb.FreeCAD]
      flatpak_system_flatpaks: [org.chromium.Chromium,com.usebottles.bottles]
```

License
-------

GPL3

Author Information
------------------

Marcus Grant (2022)
marcusgrant.dev
github.com/marcus-grant
marcusfg@protonmail.com


