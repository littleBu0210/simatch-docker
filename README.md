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