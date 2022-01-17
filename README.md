# Infrastructure as Code Monorepo

My infrastructure as code (IaC) monorepo that at first will mostly use ansible plays and variables referencing various ansible roles and collections externally developed, will eventually contain terraform, podman, kubernets and other IaC tools to configure all of my servers, workstations, and serverless controllers.

This is going to take a lot of cues from my old repositories that split ansible work in a hodge podge manner between servers and workstations in the repositories [marcus-grant/playbook-mycloud](https://github.com/marcus-grant/playbook-mycloud) and [marcus-grant/playbook-myworkstation](https://github.com/marcus-grant/playbook-myworkstation) respectively. It is however starting fresh and only copying over code as needed because both previous repositories were made when I was very new to ansible and now I have a better understanding that allows me to structure playbooks more effectively and even include new tools like kubernetes, podman and terraform.

## The Inventory

In the old ansible repositories I used vault encrypted inventories, as well as a vault variable file that can be referenced by all plays. I didn't like that an inventory which has largely unchanging URLs referencing them being potentially leaked one day. A database password, or API key can always be changed. A domain name, although theoretically can be changed, I'd prefer not to so I'm keeping the inventory out of this and will show people how to create their own in the global host file ansible searches for.
