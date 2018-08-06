# TerminalRecorder
A project to convert terminal sessions into video files

## Overview

This project uses Vagrant to configure a known state VM that can be used for recording terminal sessions, and then converting those sessions into video. 

## Getting Started

First, bring up the VM using Vagrant.

`vagrant up`

Then ssh into it.. (passing `-X` if you are on linux/mac, to let vagrant launch X apps back to your host)

`vagrant ssh -- -X`

## To record a session

Outside the VM, use the `script` command to record your session, using an xterm with identical specs to the one that will be used to record the playback. (This works real well if using `-X` as you can launch an xterm directly from the VM to your host.)

`script` records timing info to one file, and character data to another. 

`xterm -fa "Inconsolata" -fs 12 -rv -geometry 80x28 -e "script --timing=/tmp/TIMING -q /tmp/MYSCRIPT"`

Repeat this step until you have a session recorded that you are happy with, etc. 

## To convert a session into a video file. 

`/vagrant/makerecording.sh MYSCRIPT MYTIMING /vagrant/output.mp4`

