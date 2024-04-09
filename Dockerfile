# Start from the ROS Noetic perception image
FROM ros:noetic-perception

# Install required packages
RUN apt-get update && \
    apt-get install -y ros-noetic-rqt* net-tools iproute2 ros-noetic-plotjuggler* ros-noetic-foxglove-bridge ros-noetic-turtlesim

# Create catkin workspace and add it to .bashrc
RUN mkdir -p /root/catkin_ws/src && \
    echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc
    
# Switch to the directory and initialize the workspace 
RUN /bin/bash -c '. /opt/ros/noetic/setup.bash; cd /root/catkin_ws; catkin_make'

# Switch to the catkin working directory for convenience
WORKDIR /root/catkin_ws

# Start ROS core services
CMD ["roscore"]
