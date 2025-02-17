#!/bin/bash

dir=`pwd`/`dirname $0`/

cd $dir
./git-subrepo.sh

f="all"

if [ "$1" == "build" ]; then
 f="prepare"
fi

./multiple-sitl/install/$f.sh default $dir/Firmware

if [ "$1" != "build" ]; then
 sudo apt install ros-noetic-gazebo-ros-control
fi
