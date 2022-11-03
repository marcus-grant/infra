# LUKS Role

by Marcus Grant

## Overview

Open/Close Mount/Dismount ansible role for kernel the LUKS partition and volume encryption system of linux. Made specifically to produce bash scripts with all the specific arguments for a list of dictionaries of mount points, block device IDs, LUKS mapping points, LVM logical volumes and kernel mount options. That way no keys need to be given, but a key can be delivered via variables but that will end up being stored in plaintext so be careful about how you secure it.

## Requirements

Only that a linux host is being configured, one with LUKS which should ship with the vast majority of Linux distributions since it is mainlined.

## Role Variables

Only one variable is used right now, `luks_mappings`. It is a list of dictionaries containing the attributes: `mount`, `mount_opts`, `volume`, `luks_map` and `block_id`. For volume/partition layout schemes, including with LVM it's possible to write a lot of duplicates so long as the `mount` is unique for each dictionary. For example, if `volume` is `/dev/volume-group/logical-volume-a` and for another dictionary it's `/dev/volume-group/logical-volume-b` but they're both inside a `luks_map` mapped to `crypto-map` *(ie /dev/mapper/crypto-map)* then you can have two dictionaries with duplicate `luks_map` attributes but with a common `luks_map` and even `block_id`.

### luks_mapping dictionary attributes

| Variable   | Required | Default  | Choices          | Comments                                             |
| ---------- | -------- | -------- | ---------------- | ---------------------------------------------------- |
| mount      | false    | None     | valid mount path | Directory to mount to                                |
| mount_opts | false    | defaults | valid mount opts | Filesystem mount options following `mount -o`        |
| volume     | false    | None     | valid LVM path   | If present, a path to an LVM logtical volume         |
| luks_map   | false    | None     | valid LUKS path  | If present, a LUKS mapped path. Skip unlock if empty |
| block_id   | true     | None     | UUID of a volume | A partition/block/volume id acquired using `blkid`   |

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
/dev/nvme0n1p4: UUID="00000000-0000-0000-0000-000000000003" TYPE="crypto_LUKS"
/dev/sdb1: UUID="0000000000-0000-0000-0000-000000000000b" TYPE="LVM2_member"
/dev/mapper/coldvg-coldlv: UUID="00000000-0000-0000-0000-000000000001"
/dev/mapper/coldvg-vidslv: UUID="00000000-0000-0000-0000-000000000002"
```

You would create a playbook like this:

```yaml
- hosts: some_host
  roles:
    - name: luks
      vars:
        luks_mappings:
          - mount: /mnt/drv/cold
            mount_opts: defaults,noatime,space_cache=v2,compress=zstd
            volume: /dev/coldvg/coldlv
            luks_map: crypt-cold
            block_id: 00000000-0000-0000-0000-000000000001
          - mount: /mnt/drv/cold/vids
            mount_opts: defaults,noatime,space_cache=v2
            volume: /dev/coldvg/vidslv
            luks_map: crypt-vids
            block_id: 00000000-0000-0000-0000-000000000002
          - mount: /mnt/drv/hot
            mount_opts: >-
              defaults,ssd,noatime,discard,space_cache=v1,compress=zstd
            volume: /dev/hotvg/hotlv
            luks_map: crypt-hot
            block_id: 00000000-0000-0000-0000-000000000003
          - mount: /mnt/drv/sys
            mount_opts: defaults,noatime,discard
            volume: /dev/hotvg/syslv
            luks_map: crypt-hot
            block_id: >-  # same block id as hotlv because same luks container
              00000000-0000-0000-0000-000000000003
```
