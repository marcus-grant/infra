Reverb DDNS
===========

Using the reverb client & server to update cloudflare DDNS with host's public IP.

Requirements
------------

A [reverb server](https://github.com/marcus-grant/reverb)
must be running on an accessible host somewhere.
This [role](https://github.com/marcus-grant/infra/tree/main/roles/podman/reverb)
from my [infra monorepo](https://github.com/marcus-grant/infra)
will install & run it.

Role Variables
--------------

| Variable             | Needed | Default               | Choices     | Comments                                  |
| -------------------- | ------ | --------------------- | ----------- | ----------------------------------------- |
| reverb_server        | yes    |                       | URL         | URL of reverb server to get public IP     |
| reverb_ddns_zoneid   | yes    |                       | DDNS ZoneID | ZoneID of DNS provider for domain         |
| reverb_ddns_auth     | yes    |                       | API Token   | API Token of DNS provider                 |
| reverb_ddns_recordid | yes    |                       | DDNS RecID  | RecordID of DNS provider for zone rule    |
| reverb_ddns_dir      | no     | /usr/local/lib/reverb | directory   | Directory path to clone reverb files in   |
| reverb_ddns_bin      | no     | /usr/local/bin/reverb | dir/file    | Directory/file path to put service script |
| reverb_ip_header     | no     | X-Forwarded-For       | HTTP header | HTTP Header to look for public IP in      |
| reverb_ddns_log_dir  | no     | /var/log/reverb-ddns  | directory   | Directory path to store logs in           |
| reverb_ddns_onactive | no     | ''                    | onActive    | SystemD onActive string; leave to not use |
| reverb_ddns_oncal    | no     | *-*-* 0/2:01:00       | onCalendar  | SystemD onCalendar str; leave to not use  |
| reverb_ddns_version  | no     | main                  | git version | Ansible.builtin.git version string        |
| reverb_ddns_ttl      | no     | 300                   | seconds     | TTL for DDNS provider in seconds          |

Dependencies
------------

This [role](https://github.com/marcus-grant/infra/tree/main/roles/podman/reverb)
to install a reverb server using a container runtime & caddy for reverse proxying.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: all
      vars:
        reverb_server: https://reverb.example.com
        reverb_ddns_zoneid: somezoneid
        reverb_ddns_auth: someapitoken
        reverb_ddns_recordid: someddnsrecordid
      roles:
         - reverb-ddns

License
-------

See license.md

Author Information
------------------

[marcusgrant.me](https://marcusgrant.me)
