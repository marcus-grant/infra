# marcus_grant.macos.homebrew

A homebrew installer for macOS that also installs taps, casks and packages after
installing homebrew's dependencies and the program itself.

## Requirements

None, macOS comes with everything needed to run this role.

## Role Variables

These are the default variables for this role as visible in defaults/main.yml.
If a variable is required,
it won't have a default value and will be marked as required.

| Variable                | Required | Default | Choices                   | Comments                                 |
|-------------------------|----------|---------|---------------------------|------------------------------------------|
| foo                     | no       | false   | true, false               | example variable                         |
| bar                     | yes      |         | eggs, spam                | example variable                         |

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: all
      roles:
         - ansible-role-template

License
-------

See license.md

Author Information
------------------

https://cyverse.org