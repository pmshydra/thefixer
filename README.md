# Monitors containers with **HEALTHCHECK** if unhealthy it restart's container

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

> Apply the label fixme=true to your container to have it watched and restarted if the container is unhealthy.(Not applicable if CONTAINER_LABEL=all is set)

## Applying HealthCheck to a container:
```

Dockerfile: https://docs.docker.com/engine/reference/builder/#healthcheck

Here is an example
docker run --name nginx -d \
  --health-cmd='curl -sS http://127.0.0.1 || exit 1' \ 
  --health-timeout=10s \
  --health-retries=3 \
  --health-interval=5s \
  --label fixme=true \
  -p 80:80 \
  nginx/nginx

```
# The Fixer and other container environment variables.
## Environment Defaults
| Variable | Defaults | Function | Example |
|----------|----------|----------|----------|
|`CONTAINER_LABEL`| all | Watch all containers that have a HealthCheck |`CONTAINER_LABEL=all`|
|`INTERVAL`| 5 | Time inbetween checks |`INTERVAL=5`|
|`START_PERIOD`| 0 | Time to wait before starting the health check |`START_PERIOD=0`|
|`DEFAULT_STOP_TIMEOUT`| 10 |  |`DEFAULT_STOP_TIMEOUT=10`|
|`DOCKER_SOCK`| /var/run/docker.sock | Location of your docker socket |`DOCKER_SOCK=/var/run/docker.sock`|
|`CURL_TIMEOUT`| 30 | Time to wait before restarting container |`CURL_TIMEOUT=30`|

## Tell's it what container's to look for
| Sets container label status | Value | Description| Example |
|-----------------------------|-------|------------|---------|
|`ENV CONTAINER_LABEL`| `all` | `Watch all running containers.`|`CONTAINER_LABEL=all`|
|`ENV CONTAINER_LABEL`| `(empty)` | `Watch only the containers with the label fixme=true`| `CONTAINER_LABEL`|
|`stop.timeout`| 20 | `Timeout per container` | `stop.timeout=20`|
