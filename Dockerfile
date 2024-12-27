FROM nvidia/cudagl:10.0-devel-ubuntu16.04

# Add the apt-key
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC

# Environment config
ENV DEBIAN_FRONTEND=noninteractive

# Install basic tools
RUN apt-get update && \
    apt-get install -y vim \
    curl \
    tmux \
    git \
    wget \
    lsb-release \
    lsb-core

# Add ROS repository key
RUN wget http://packages.ros.org/ros.key -O - | apt-key add -

# Add ROS repository to sources list
RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list

# Install ROS and dependencies
RUN apt-get update && \
    apt-get install -y ros-kinetic-desktop python-rosdep && \
    apt-get install -y python-rosinstall && \
    rosdep init

# Add Gazebo repository and key
RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list' && \
    wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add - && \
    apt-get update && \
    apt-get install -y gazebo7 libgazebo7-dev && \
    apt-get install -y ros-kinetic-gazebo-ros-pkgs ros-kinetic-gazebo-ros-control

# Update rosdep permissions and update
RUN rosdep fix-permissions && rosdep update

# Source ROS setup script
RUN echo "source /opt/ros/kinetic/setup.bash" >> /root/.bashrc
RUN /bin/bash -c "source /root/.bashrc"

# Install catkin tools and libncurses5-dev
RUN apt-get update && \
    apt-get install -y python-catkin-tools libncurses5-dev && \
    rm -rf /var/lib/apt/lists/*

# Compile catkin workspace
RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash && \
    cd / && \
    git clone https://github.com/nubot-nudt/simatch.git && \
    cd simatch && \
    chmod +x configure && \
    ./configure && \
    catkin_make"

# Source the setup script of the workspace
RUN echo "source /simatch/devel/setup.bash" >> /root/.bashrc
RUN /bin/bash -c "source /root/.bashrc"

# Set the working directory to /simatch
WORKDIR /simatch

# Set default command
CMD ["/bin/bash"]