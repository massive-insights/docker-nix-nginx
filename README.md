# Nginx Docker container (Nix)

This repository contains code that is required to build a Docker container for the HTTP server nginx. We solely use Nix expression language to declaratively describe the build process.

To build the Docker container launch the following command:

```bash
$ nix-build default.nix
```

The image will be built in `/nix/store/xxxxxxxxx-docker-image-nginx.tar.gz` and symlinked to `./result`. Load it via:

```bash
$ docker load -i result
```

Check if it has been loaded properly:

```bash
$ docker images
```

Finally run the Docker image via:

```bash
$ docker run -d -p 80:80 nginx
```

You should reach the test website at [http://DOCKER_HOST_IP](http://DOCKER_HOST_IP) at regular port 80.

List all running containers:

```bash
$ docker ps
```

To stop the Docker container, launch the following command:

```bash
$ docker stop CONTAINER_NAME
```

To remove the container and any volumes associated with it launch the following command:

```bash
$ docker rm -fv CONTAINER_NAME
```

To remove the entire Docker image run:

```bash
$ docker rmi -f nginx
```

