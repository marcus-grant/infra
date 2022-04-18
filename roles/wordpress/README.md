WordPress
=========

A role that installs WordPress with MariaDB in its own container.


Requirements
------------

Any role or script that installs traefik is necessary to enable reverse proxying the container and to handle TLS certificates.

Role Variables
--------------

Below are all role variables *along with their default values if they have one otherwise they are required*. All the defaults can also bee seen in `defaults/main.yml`.

```yaml
# Variables from defaults
wordpress_available_externally: "true"  # MUST BE STRING "true" | "false"
wordpress_data_directory: "/mnt/docker/wordpress"
wordpress_uid: omit  # Omit to use default mariaDB user map otherwise uid int
wordpress_port: "8080"
wordpress_subdomain: "wordpress"  # The subdomain to use for nextcloud
wordpress_docker_image: "wordpress:latest"  # The docker image for nextcloud app
wordpress_db_docker_image: "mariadb:latest" # The database docker image to use
wordpress_memory: 256m  # The amount of memory to allow docker to allocate
wordpress_db_memory: 512m  # Amount of memory to reserve for nextcloud database
```

The only non default variable that must be defined is the `wordpress_db_password` which gets used for both the MariaDB container's root password and the created `wordpress` database user.

```yaml
wordpress_db_password: SomeSecurePassword
```

Dependencies
------------

TODO add the traefik and docker roles here with proper references

Example Playbook
----------------

```yaml
- hosts: all
  roles:
  - role: marcus_grant.selfhosted_docker.wordpress
    vars:
      wordpress_available_externally: true
      wordpress_data_directory: /mnt/docker/wordpress
      wordpress_port: 8080
      wordpress_docker_image: wordpress:php8.1-apache
      wordpress_db_docker_image: mariadb:10.4
      wordpress_db_password: actually_good_password
      wordpress_subdomain: wp
      wordpress_extra_fqdn:
        - example.com
        - blog.example.com
      
```

License
-------

GPL3

Author Information
------------------

https://marcusgrant.me
