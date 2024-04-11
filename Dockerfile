# Start from the ROS Noetic image
FROM ros:noetic-perception

### ROS INSTALLATION ###

# Install required packages
RUN apt-get update && \
    apt-get install -y ros-noetic-rqt* net-tools iproute2 ros-noetic-plotjuggler* ros-noetic-foxglove-bridge ros-noetic-turtlesim

# Create catkin workspace and add it to .bashrc
RUN mkdir -p /root/robotics/src && \
    echo "source /root/robotics/devel/setup.bash" >> /root/.bashrc
    
# Switch to the directory and initialize the workspace 
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; cd /root/robotics; catkin_make'

### NEOVIM INSTALLATION ###

# Install build dependencies for Neovim
RUN apt update && apt upgrade -y
RUN apt install -y ninja-build gettext cmake unzip curl build-essential git

# Install ripgrep for live grep in Telescope.nvim
RUN apt install -y ripgrep

# Install clangd-12 for LSP functionality in Neovim and set it as default
RUN apt install -y clangd-12
RUN update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-12 100

# Move to home directory
WORKDIR /root/

# Clone Neovim from source
RUN git clone https://github.com/neovim/neovim

# Move into the Neovim directory
WORKDIR /root/neovim

# Select stable version
RUN git checkout stable

# Build and install
RUN make CMAKE_BUILD_TYPE=RelWithDebInfo
RUN make install

### NEOVIM CONFIGURATION ###

# Move to home directory
WORKDIR /root/

# Clone configs for Neovim
RUN git clone https://github.com/MrVideo/arch-dotfiles.git

# Create .config directory
RUN mkdir .config

# Move to .config directory and link configs via symlink
RUN cd .config && ln -s ~/arch-dotfiles/.config/nvim

# Setup clangd with a config file in the working directory
WORKDIR /root/robotics
RUN echo "CompileFlags:" >> .clangd
RUN echo "  Add: [-I/opt/ros/noetic/include, -L/opt/ros/noetic/lib, -I/root/robotics/devel/include/]" >> .clangd

# Start ROS core services
CMD ["roscore"]
