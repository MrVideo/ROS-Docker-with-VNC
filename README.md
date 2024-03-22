# A better ROS Docker setup

This repo contains a setup for ROS 1 which contains a lightweight desktop environment called LXDE and a VNC server to connect to it locally.

## How to build

Just run the following command in your terminal:

```
sudo docker compose up --build
```

## Change VNC configuration

If you want to change the password for your VNC server, change the corresponding line in the `docker-compose.yml` file.

If you want to change which port is bound to the VNC server on your host machine, change the first number in the `ports` section of the same file.

## How to use VNC

On Linux, you can use an app like [Connections](https://apps.gnome.org/Connections/), which comes included with GNOME desktop environments.

On macOS, you can simply connect to the VNC URL through Finder.

On Windows, use a VNC client, there are a lot around.

The URL to connect to is, by default:

```
vnc://localhost:12345
```

