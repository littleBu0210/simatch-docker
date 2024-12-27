docker run -it \
    --runtime=nvidia \
    --gpus all \
    --env DISPLAY=$DISPLAY \
    --env QT_X11_NO_MITSHM=1 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    simatch-ros-melodic-gazebo9-ubuntu1804\
    bash