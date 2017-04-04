#!/bin/bash
# Usage: makevideo {directory_containing_images}

dir=$1
framerate="2"

if [ $# -eq 0 ]
  then
    echo "Usage: makevideo {directory_containing_images}"
fi

ffmpeg -framerate 10 -pattern_type glob -i "${dir}/*.png" -c:v libx264 -pix_fmt yuv420p $dir/out.mp4
