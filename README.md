## simatch-docker
The old version of simatch-docker can be found here: https://github.com/dortmans/simatch-docker.git

The Simatch sources and documentation can be found here: https://github.com/nubot-nudt/simatch

The master branch environment is ros-melodic + gazebo9 + ubuntu1804

The Kinetic branch environment is ros-Kinetic + gazebo7 + ubuntu1604(there is a catkin_make error that has not been resolved yet)
## Installation
1. Install NVIDIA graphics driver on the host machine
2. Install NVIDIA Container Toolkit: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
3. Check X11 configuration and permissions
## Usage
### Build the container
```bash
chmod +x build.sh
./build.sh
```
### Run the image
```bash
chmod +x run.sh
./run.sh
```
### Run within the image
```bash
roslaunch simatch_cyan.launch
```