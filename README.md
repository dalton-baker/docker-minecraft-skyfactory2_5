# Skyfactory 2.5 Minecraft Server Docker
[![Docker Pulls](https://badgen.net/docker/pulls/daltonsbaker/skyfactory2_5?icon=docker&label=pulls)](https://hub.docker.com/r/daltonsbaker/skyfactory2_5/) 
[![Docker Stars](https://badgen.net/docker/stars/daltonsbaker/skyfactory2_5?icon=docker&label=stars)](https://hub.docker.com/r/daltonsbaker/skyfactory2_5/) 
[![Docker Image Size](https://badgen.net/docker/size/daltonsbaker/skyfactory2_5?icon=docker&label=image%20size)](https://hub.docker.com/r/daltonsbaker/skyfactory2_5/) 
![Github Commits](https://badgen.net/github/commits/dalton-baker/docker-minecraft-skyfactory2_5?icon=github&label=commits) 
![GitHub last commit](https://badgen.net/github/last-commit/dalton-baker/docker-minecraft-skyfactory2_5?icon=github&label=last%20commit) 
![Github stars](https://badgen.net/github/stars/dalton-baker/docker-minecraft-skyfactory2_5?icon=github&label=stars) 
![Github forks](https://badgen.net/github/forks/dalton-baker/docker-minecraft-skyfactory2_5?icon=github&label=forks)

Github repo: https://github.com/dalton-baker/docker-minecraft-skyfactory2_5<br>
Dockerhub repo: https://hub.docker.com/r/daltonsbaker/skyfactory2_5

This repo is a fork of https://github.com/TrueOsiris/docker-minecraft-skyfactory4, but altered to work for SkyFactory 2.5


## Running
To simply use the latest stable version, run:
```
docker run -d -p 25565:25565 daltonsbaker/skyfactory2_5
```
    
where the default server port, 25565, will be exposed on your host machine. If you want to serve up multiple Minecraft servers or just use an alternate port, change the host-side port mapping such as:
```
docker run -p 25566:25565 ...
```
will service port 25566.


Speaking of multiple servers, it's handy to give your containers explicit names using `--name`, such as
```
docker run -d -p 25565:25565 --name minecraft daltonsbaker/skyfactory2_5
```

With that you can easily view the logs, stop, or re-start the container:
```
docker logs -f minecraft
        ( Ctrl-C to exit logs action )

docker stop minecraft

docker start minecraft
```


## Attaching data directory to host filesystem

In order to persist the Minecraft data, which you *probably want to do for a real server setup*, use the `-v` argument to map a directory of the host to ``/data``:
```
docker run -d -v /path/on/host:/data -p 25565:25565 daltonsbaker/skyfactory2_5
```

When attached in this way you can stop the server, edit the configuration under your attached ``/path/on/host`` and start the server again with `docker start CONTAINERID` to pick up the new configuration.


## Server configuration

The message of the day, shown below each server entry in the UI, can be changed with the `MOTD` environment variable, such as:
```
docker run -d -e 'MOTD=My Server' ...
```

If you leave it off, the last used or default message will be used.

The Java memory limit can be adjusted using the `JVM_OPTS` environment variable, where the default is the setting shown in the example (max and min at 2048 MB):
```
docker run -e 'JVM_OPTS=-Xmx2048M -Xms2048M' ...
```

The server level-name property can be set with `LEVEL`. This defaults to 'world'
```
docker run -e 'LEVEL=world2 ...
```

## Docker Compose
You can use the following docker compose file instead of running the containers manually
```
version: "3.9"
services:
  skyfactory2_5:
    image: daltonsbaker/skyfactory2_5
    volumes:
      - /your/local/dir:/data
    ports:
      - 25565:25565
    environment:
      - MOTD=My Server
      - JVM_OPTS=-Xmx2048M -Xms2048M
      - LEVEL=world2
    restart: unless-stopped
```
