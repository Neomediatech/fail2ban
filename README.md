Fail2ban Docker image based on Ubuntu

## Configs
- Put your [AbuseIPDB API Key](https://www.abuseipdb.com/account/api) in [confs/action.d/abuseipdb.local](confs/action.d/abuseipdb.local)
- Set `rhost` and `rport` in [confs/action.d/redis.local](confs/action.d/redis.local) to match your Redis instance
- Set `nodename` and `ignoreip` in [jail.d/neo.conf](jail.d/neo.conf) to match your needs  
| Variable | Default | Description |
| -------- | ------- | ----------- |
| F2B_DEST_EMAIL | root@localhost | destination email to receive reports |
| F2B_SENDER | root@$(hostname -f) | sender email for reports |
| SSMTP_HOST | none | SMTP host to use for send email |
| SSMTP_PORT | 25| SMTP port |
| (other settings) | () | see entrypoint.sh |

## Warning
Portainer doesn't understand `env_file` parameter (at least for now, 27 feb 2019).

## Wishlist
- [ ] Use a init system to allow f2b to reload rules without reload container

