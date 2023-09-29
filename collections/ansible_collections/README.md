# Collections Directory Rules

## Purpose

The purpose of this directory is to
organize the Ansible search path for collections.
Ansible allows configuration of the collections search path.
However, wherever you specify the search path,
it expects an `ansible_collections` directory to be present.
To keep the directory structure compact and less confusing,
this `collections` directory is used to hold all collections under
my namespace, `marcus_grant`.
Then in the `ansible_collections` directory,
a symbolic link is created to this directory.
The role is then accessible via the namespace and role name.

## Example

For example, if you have a role named `bar` from collection `foo`,
in the root of the `collections` directory,
you can access the role using the default `marcus_grant` namespace like so:

```yaml
- hosts: all
  roles:
    - marcus_grant.foo.bar
```

## Configuration

To make this work we add this relative directory to the collections search path.
To do this in `ansible.cfg` add the following:

```ini
collections_paths = ~/.ansible/collections:/usr/share/ansible/collections:./collections
```
