#!/bin/bash
# Usage scap.sh screen_num
# screen_num: number of screens, accepts 1 or 2

timer="20"
resolution="1280x720"
screen_num=$1

trap ctrl_c INT

function ctrl_c() {
        echo -n "black" | nc -4u -w0 localhost 1738
        exit 0
}

if [ $# -eq 0 ]
  then
    echo "Usage scap.sh screen_num"
    echo "  screen_num: number of screens, accepts 1 or 2"
    exit 1
fi

while true; do
  date=$(date "+%Y-%m-%d")
  time=$(date "+%H.%M.%S")

  dir="/Users/travis.brackett/scap/${date}"

  echo -n "red" | nc -4u -w0 localhost 1738

  if [ ! -d "${dir}" ]; then
    mkdir "${dir}"
  fi

  if [ $screen_num -eq 1 ]; then

    if [ ! -d "${dir}/1" ]; then
      mkdir "${dir}/1"
    fi

    screencapture -x "${dir}/1/${time}.jpg"
    convert "${dir}/1/${time}.jpg" -resize $resolution "${dir}/1/${time}.jpg"
    sleep $timer
  else

    if [ ! -d "${dir}/1" ]; then
      mkdir "${dir}/1"
    fi

    if [ ! -d "${dir}/2" ]; then
      mkdir "${dir}/2"
    fi

    screencapture -x "${dir}/1/${time}.jpg" "${dir}/2/${time}.jpg"
    convert "${dir}/1/${time}.jpg" -resize $resolution "${dir}/1/${time}.jpg"
    convert "${dir}/2/${time}.jpg" -resize $resolution "${dir}/2/${time}.jpg"
    sleep $timer
  fi

echo -n "white" | nc -4u -w0 localhost 1738
sleep .1

done
