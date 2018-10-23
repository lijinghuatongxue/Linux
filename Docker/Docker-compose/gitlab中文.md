

# 环境



```
root@233:~# docker-co
docker-compose          docker-containerd       docker-containerd-ctr   docker-containerd-shim
root@233:~# docker-compose --version
docker-compose version 1.16.1, build 6d1ac21
root@233:~# docker --version
Docker version 17.03.2-ce, build f5ec1e2
```

# docker-compose.yml

```
root@233:~# cat docker-compose.yml
version: '3'
services:
  gitlab:
    image: 'twang2218/gitlab-ce-zh:11.0.3'
    # build: .
    container_name: 'gitlab'
    restart: 'always'
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
    ports:
      - '8081:80'
      - '4443:443'
      - '2222:22'
    volumes:
      - '/home/docker/gitlab/config:/etc/gitlab'
      - '/home/docker/gitlab/logs:/var/log/gitlab'
      - '/home/docker/gitlab/data:/var/opt/gitlab'
networks:
  app_net:
    driver: 'bridge'
    ipam:
      driver: 'default'
```

# run

```
docker-compose up -d
```

