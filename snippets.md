# Ansible, Terraform, Shell Snippets

This is a document to collect snippets that are either often used and
should be taken notes on,
or shouldn't create noise on old variable, task, module files any more.

## Ansible

### Caddy

#### Caddy Variable Definition

The caddy roles used variables to template configuration files that
are loaded by caddy from the `/etc/caddy/sites-enabled` directory.
This example shows the folded string content being used in the caddy config and
some other variables.

```yaml
## Caddy
caddy_github_token: vault_github_token
caddy_create_site_dirs: true
caddy_users_in_group: ["{{ admin_user }}"]
caddy_systemd_capabilities_enabled: true
caddy_systemd_capabilities: "CAP_NET_BIND_SERVICE"
caddy_systemd_restart_startlimitinterval: "600"
caddy_systemd_restart_startlimitburst: "5"
caddy_config: |  # look here, undetermined if this really helps http://bit.ly/3Wlt8Cr
  # Templated by ansible
  # Import sites-enabled config files/snippets
  # Root Caddyfile
  {
      auto_https disable_redirects
  }
  http:// {
      redir https://{hostport}{uri} 301
  }
  :80 {
      redir https://{hostport}{uri} 301
  }
  import sites-enabled/*
caddy_create_sites: true
caddy_cloudflare_token: "{{ vault_cloudflare_dns_token }}"
caddy_sites:
  - file: root
    enabled: true
    config: |
      www.{{ svartalv_main_domain }} {
        root * /var/www
        encode gzip
        file_server
      }
```

#### Caddy Github Token

The caddy role uses a github token to create a caddy binary from source.
Here is the token reference as applied in a playbook vars directive:

```yaml
- name: '[BROKKR ONLY] Provision hetzner servers, NOTE: Should be done AFTER bootstrapping'
  hosts: brokkr
  become: true
  vars:
    caddy_github_token: "{{ vault_github_token }}"
  roles:
```
