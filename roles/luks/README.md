# LUKS Role

by Marcus Grant

## Overview

Open/Close Mount/Dismount ansible role for kernel the LUKS partition and volume encryption system of linux. Made specifically to produce bash scripts with all the specific arguments for a list of dictionaries of mount points, block device IDs, LUKS mapping points, LVM logical volumes and kernel mount options. That way no keys need to be given, but a key can be delivered via variables but that will end up being stored in plaintext so be careful about how you secure it.

## Requirements

Only that a linux host is being configured, one with LUKS which should ship with the vast majority of Linux distributions since it is mainlined.

## Role Variables

Only one variable is used right now, `luks_mappings`. It is a list of dictionaries containing the attributes: `mount`, `mount_id`, `mount_opts`, `volume_group`, `logical_volume`, `luks_map`, `luks_id` and `lvm_on_luks`. For volume/partition layout schemes, including with LVM it's possible to write a lot of duplicates so long as the `mount` is unique for each dictionary. For example, if `volume` is `/dev/volume-group/logical-volume-a` and for another dictionary it's `/dev/volume-group/logical-volume-b` but they're both inside a `luks_map` mapped to `crypto-map` *(ie /dev/mapper/crypto-map)*, also known as `lvm_on_luks`, then you can have two dictionaries with duplicate `luks_map` attributes but with a common `luks_map` and even `luks_id`. Note that if the volume is `lvm_on_luks` then you must specify `true` in that dictionary entry.

### luks_mapping dictionary attributes

| Variable       | Required | Default  | Choices             | Comments                                             |
| -------------- | -------- | -------- | ------------------- | ---------------------------------------------------- |
| mount          | false    | None     | valid mount path    | Directory to mount to                                |
| mount_opts     | false    | defaults | valid mount opts    | Filesystem mount options following `mount -o`        |
| volume_group   | false    | None     | valid LVM vg name   | If present, a LVM volume group name                  |
| logical_volume | false    | None     | valid LVM lv name   | If present, a LVM logical volume                     |
| luks_map       | false    | None     | valid LUKS path     | If present, a LUKS mapped path. Skip unlock if empty |
| luks_id        | false    | None     | UUID of LUKS volume | If present, the UUID of a volume for LUKS to unlock  |
| lvm_on_luks    | false    | true     | boolean             | Whether mount point is LVM inside LUKS volume        |

There will be a lot of lists employed in the rendered scripts. That's why it's important to mount & unlock volumes in the correct order. If given parent directory `/a` and subdirectory `/a/b` then it's important that the `luks_mapping` dictionary for `/a` preceeds the dictionary for `mount` point `/a/b`.

## Example Playbook

Given an `lsblk` like this:

```sh
sdb                 8:16   0 10.9T  0 disk
└─sdb1              8:17   0 10.9T  0 part
  ├─coldvg-coldlv 253:0    0    4T  0 lvm
  └─coldvg-vidslv 253:1    0  6.9T  0 lvm
nvme0n1           259:0    0  1.8T  0 disk
├─nvme0n1p1       259:1    0  953M  0 part  /boot/efi
├─nvme0n1p2       259:2    0 28.9G  0 part  [SWAP]
├─nvme0n1p3       259:3    0 89.4G  0 part  /
└─nvme0n1p4       259:4    0  1.7T  0 part
  └─hotcrypt      253:6    0  1.7T  0 crypt
    ├─hotvg-syslv 253:7    0  200G  0 lvm
    └─hotvg-hotlv 253:8    0  1.5T  0 lvm
```

And a `blkid` of:

```sh
# ... with many irrelevant UUID lines removed
# Below is a LUKS on LVM set of containers, for each logical volume sits a LUKS container
blkid /dev/coldvg/coldlv # /dev/coldvg/coldlv: UUID="00000000-0000-0000-0000-000000000001" TYPE="crypto_LUKS"
blkid /dev/coldvg/vidslv #/dev/coldvg/vidslv: UUID="00000000-0000-0000-0000-000000000002" TYPE="crypto_LUKS"
# Below is a LVM on LUKS crypto_luks container, the volume group sits on top of LUKS here
blkid /dev/nvme0n1p4 # dev/nvme0n1p4: UUID="00000000-0000-0000-0000-000000000003" TYPE="crypto_LUKS"
```

You would create a playbook like this:

```yaml
- hosts: some_host
  roles:
    - name: luks
      vars:
        luks_mappings:
          - mount: /mnt/cold
            mount_id: SOMEUUID
            mount_opts: defaults,noatime,space_cache=v2,compress=zstd
            volume_group: coldvg
            logical_volume: coldlv
            luks_map: crypt-cold
            luks_id: SOMEUUID
            lvm_on_luks: false

          - mount: /mnt/vids
            mount_id: SOME_UUID
            mount_opts: defaults,noatime,space_cache=v2
            volume_group: coldvg
            logical_volume: vidslv
            luks_map: crypt-vids
            luks_id: SOME_UUID
            lvm_on_luks: false
```
