# Monitors containers with **HEALTHCHECK** if unhealthy it restart's container


![Alt text](https://raw.githubusercontent.com/pmshydra/qbvpn/master/qbvpn_image.png "qBittorrent with OpenVPN")

**Originally pulled from [willfarrel/docker-autoheal](https://github.com/willfarrell/docker-autoheal) with a few changes, mostly the base image.**

I didn't change much because much isn't needed. Just enough that it easier to use. **Health Check is inside as well, in case the torrent client** fails for some reason it can restart if you also use  [The Fixer](https://hub.docker.com/r/pmshydra/thefixer) and configure accordingly.

## Docker run command:
```
docker run -d \
    --name The_Fixer \
    --restart=always \
    -e CONTAINER_LABEL=all \
    -v /var/run/docker.sock:/var/run/docker.sock \
    pmshydra/thefixer
```
### On first run it'll generate the config folder to where you configured it, place inside a .ovpn(or multiple) but make sure that the name is something like Country_Location.ovpn .

> Apply the label fixme=true to your container to have it watched and restarted if the container is unhealthy.(Not applicable if CONTAINER_LABEL=all is set)

## PUID/PGID
User ID (PUID) and Group ID (PGID) can be found by issuing the following command for the user you want to run the container as:

```
id <username>
```

# Variables, Volumes, and Ports
## Environment Variables
| Variable | Required | Function | Example |
|----------|----------|----------|----------|
|`VPN_ENABLED`| Yes | Enable VPN? (yes/no) Default:yes|`VPN_ENABLED=yes`|
|`VPN_USERNAME`| No | If username and password provided, configures ovpn file automatically |`VPN_USERNAME=p1123456`|
|`VPN_PASSWORD`| No | If username and password provided, configures ovpn file automatically |`VPN_PASSWORD=0987655`|
|`OVPN_FILE`| Yes | If no file is entered, it will not know what to look for. |`OVPN_FILE=US_Chicago`|
|`LAN_NETWORK`| Yes | Local Network with CIDR notation |`LAN_NETWORK=192.168.0.0/24`|
|`NAME_SERVERS`| No | Comma delimited name servers |`NAME_SERVERS=1.1.1.1,1.0.0.1`|
|`PUID`| No | UID applied to config files and downloads |`PUID=1000`|
|`PGID`| No | GID applied to config files and downloads |`PGID=1000`|
|`UMASK`| No | GID applied to config files and downloads |`UMASK=002`|
|`WEBUI_PORT_ENV`| No | Applies WebUI port to qBittorrents config at boot (Must change exposed ports to match)  |`WEBUI_PORT_ENV=8080`|
|`INCOMING_PORT_ENV`| No | Applies Incoming port to qBittorrents config at boot (Must change exposed ports to match) |`INCOMING_PORT_ENV=8999`|

## Tell's it what container's to look for
| Sets container label status | Value | Description
|-----------------------------|-------|------------|
|`ENV CONTAINER_LABEL`| `all` | `Watch all running containers.`|
|`ENV CONTAINER_LABEL`| `true` | `Watch only the containers with the label fixme=true`|
|`ENV CONTAINER_LABEL`| `false` | `Dont watch any running containers.`|

###### HealthCheck works by checking if the webpage is normal at http://localhost:8080. If it is not accessible the container's status is marked as Unhealthy. Then if you are also using The Fixer, it'll automatically restart the container so your download's can resume like nothing happened.
