# fail2ban-docker
Fail2ban Docker image based on Alpine Linux and inspired from [crazy-max](https://github.com/crazy-max/docker-fail2ban) work.

## Warning
Portainer doesn't understand `env_file` parameter (at least for now, 27 feb 2019).

## Wishlist
- [ ] Use a init system to allow f2b to reload rules without reload container
- [x] Use the default apk for f2b
