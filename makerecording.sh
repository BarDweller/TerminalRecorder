#!/bin/bash

SCRIPT=$1
TIMING=$2
OUTPUT=$3

#cleanup from previous runs
sudo rm -rf /tmp/xvfb* 
rm -f /tmp/.alteredtimings
tmux kill-session -t TREC

if [ -f $OUTPUT ]; then
  if [ $OVERWRITE==true ]; then
    echo Output $OUTPUT exists, OVERWRITE is true, removing old file.
    rm $OUTPUT;
  else
    echo Error: output $OUTPUT already exists.
    exit 1;
  fi
fi

if [ ! -f $SCRIPT ]; then
  echo "Error unable to find $SCRIPT"
  exit 2;
fi

if [ ! -f $TIMING ]; then
  echo "Error unable to find $TIMING"
  exit 3
fi

#find total length of script
LEN=`gawk -M -F' ' -v ROUNDMODE="U" 'BEGIN{ OFMT="%.f";} {sum += $1;} END {print sum}' ${TIMING}`

#rounded up length.
echo "Original Script is $LEN seconds long"

#pad the playback to make it easier to grab the video.
gawk -f /vagrant/padtimings.awk /tmp/timing > /tmp/.alteredtimings

echo "Launching terminal"
#run script inside an xterm using custom font, window size is 644x480 as per 'xwininfo' in a test terminal.
xvfb-run --listen-tcp --server-args ":99 -auth /tmp/xvfb.auth -ac -screen 0 644x480x24" xterm -display :99 -fa "Inconsolata
" -fs 12 -rv -geometry 80x28 -e "scriptreplay -t /tmp/.alteredtimings ${SCRIPT}" &

#let the xvfb start
sleep 3 

echo "Starting recording"
#record terminal (use tmux to run in bg, so we can send the 'q' key to terminal the recording.
tmux new-session -d -s TREC "ffmpeg -y -f x11grab -video_size 644x480 -i :99 -codec:v libx264 -r 12 ${OUTPUT}"

echo "Waiting for script to complete"
#let the script finish
sleep $LEN 

echo "Completing the recording"
#end the recording.
tmux send-keys -t TREC q

echo "Allowing recording to save"
sleep 10 

