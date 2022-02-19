Nextcloud
=========

A role to install and partially configure nextcloud using docker.


Requirements
------------

Any role or script that installs traefik is necessary to enable reverse proxying the container and to handle TLS certificates.

Role Variables
--------------

Below are all role variables *along with their default values if they have one otherwise they are required*. All the defaults can also bee seen in `defaults/main.yml`.

```yaml
# Variables from defaults
nextcloud_available_externally: "true"  # MUST BE STRING "true" | "false"
nextcloud_data_directory: "/mnt/docker/nextcloud"
nextcloud_port: "8080"
nextcloud_hostname: "nextcloud"  # The subdomain to use for nextcloud
nextcloud_docker_image: "nextcloud:22"  # The docker image for nextcloud app
nextcloud_db_docker_image: "postgres:14" # The database docker image to use
nextcloud_cache_docker_image: "redis" # The cache/redice image to use
nextcloud_memory: 1g  # The amount of memory to allow docker to allocate
nextcloud_db_memory: 1g  # Amount of memory to reserve for nextcloud database
nextcloud_cache_memory: 1g  # Amount of memory to reserve for redis/cache

# Required variables that have no defaults
nextcloud_sql_user:  # A string for nextcloud's database username
nextcloud_sql_password:  # A string for the nextcloud database password
```

Dependencies
------------

TODO add the traefik and docker roles here with proper references

Example Playbook
----------------

```yaml
- hosts: all
  roles:
  - role: marcus_grant.selfhosted_docker.nextcloud
    vars:
      
```

License
-------

GPL3

Author Information
------------------

https://marcusgrant.me
