# A better ROS Docker setup

This is a Docker Compose setup for [ROS 1](https://www.ros.org/) which lets you visualise GUIs through [noVNC](https://github.com/theasp/docker-novnc) and interact with ROS via terminal.

The `ros` container makes use of a Docker volume to contain persistent data.

I also took the liberty to install a Neovim instance with my configs and `clangd` for LSP support when using ROS.

## Requirements

I highly recommend having a terminal emulator that allows for splits and tabs in order to use this setup.

My recommendations are:

- For macOS users, [iTerm 2](https://iterm2.com/)
- For Linux users, [kitty](https://sw.kovidgoyal.net/kitty/)
- For Windows users, I'm sorry, I have absolutely no idea

You can also use any terminal emulator of your choice and [tmux](https://github.com/tmux/tmux/wiki), although it might be a bit difficult to get used to.

## First run

In order to start everything up, just run the following command in your terminal

```
sudo docker compose up --build --detach
```

You should be able to see two containers, `ros` and `novnc`, running by executing the command:

```
sudo docker ps -a
```

## Later spins

If you've already built the image, just run the following command to start the containers:

```
sudo docker compose up -d
```

## Connect to noVNC instance

To see your GUI applications, just navigate to the following URL:

```
http://localhost:8080/vnc.html
```

Alternatively, you can click [here](http://localhost:8080/vnc.html).

## Connect a shell to the ROS container

To interact via a tty with the ROS container, you can simply run this command:

```
sudo docker exec -it ros /bin/bash
```

This will attach your current terminal window to a `bash` session in the ROS Docker container, so that you can send commands to your nodes.

## Stop the services

When you have finished your work, you can run:

```
sudo docker compose down
```

This command will stop the two previously started containers and delete them.
