Fail2ban Docker image based on Ubuntu  

Clone this repo if you want to use configs already set by me.

## Configs
- If you use [AbuseIPDB](https://www.abuseipdb.com) to query and/or report malicious IP, set an [AbuseIPDB API Key](https://www.abuseipdb.com/account/api) in [confs/action.d/abuseipdb.local](confs/action.d/abuseipdb.local) or declare the docker env var __ABUSEIPDB_APIKEY__
- If you want to use a Redis instance to store matches, configure [confs/action.d/redis.local](confs/action.d/redis.local) and set `rhost` and `rport` or declare the docker env vars __REDIS_HOST__, __REDIS_PORT__ and __REDIS_KEY__ 
- Set `nodename` and `ignoreip` in [jail.d/neo.conf](jail.d/neo.conf) to match your needs  

| Variable | Default | Description |
| -------- | ------- | ----------- |
| F2B_DEST_EMAIL | root@localhost | destination email to receive reports |
| F2B_SENDER | root@$(hostname -f) | sender email for reports |
| SSMTP_HOST | none | SMTP host to use for send email |
| SSMTP_PORT | 25| SMTP port |
| ABUSEIPDB_APIKEY | (unset) | API key taken from [AbuseIPDB](https://www.abuseipdb.com) |
| REDIS_KEY | bad:defer:honey:honey:0 | key used to store matches in a Redis server |
| REDIS_HOST | 127.0.0.1 | Redis server address |
| REDIS_PORT | 6379 | Redis server port
| (other settings) | () | see entrypoint.sh |   

## Running
```
BASE_DIR="/srv/data/docker/containers/fail2ban/"
NAME="fail2ban"
docker run -d --privileged --net=host --name $NAME --hostname $NAME -v $BASED_DIR/confs:/data neomediatech/$NAME
```
Add a bind mount where to point your logs that f2b need to monitor for ex:
`-v $BASED_DIR/logs:/var/log`

## Warning
Portainer doesn't understand `env_file` parameter (at least for now, 27 feb 2019).

## Wishlist
- [ ] Use a init system to allow f2b to reload rules without reload container
