Fail2ban Docker image based on Ubuntu

## Configs
- In [confs/action.d/abuseipdb.local](confs/action.d/abuseipdb.local) put your [AbuseIPDB API Key](https://www.abuseipdb.com/account/api)


## Warning
Portainer doesn't understand `env_file` parameter (at least for now, 27 feb 2019).

## Wishlist
- [ ] Use a init system to allow f2b to reload rules without reload container

