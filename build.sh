#!/bin/bash

# Set image name and tag
IMAGE_NAME="simatch-ros-Kinetic-gazebo7-ubuntu1604"
IMAGE_TAG="latest"

# Build Docker image and display progress and errors
docker build \
    -t $IMAGE_NAME:$IMAGE_TAG . 2>&1 | tee build.log | awk '
        BEGIN { total=0; }
        /Step [0-9]+\/[0-9]+/ {
                split($2, a, "/");
                step=a[1];
                total=a[2];
                printf("\rBuild progress: %d/%d (%.2f%%)", step, total, (step/total)*100);
                fflush(stdout);
        }
        /ERROR/ {
                print "\nBuild error: " $0;
                error=1;
        }
        END {
                if (error) {
                        print "\nErrors occurred during the build process, please check the build.log file for details.";
                        exit 1;
                } else {
                        print "\nBuild completed";
                }
        }
'