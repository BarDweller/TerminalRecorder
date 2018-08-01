# TerminalRecorder
A project to convert terminal sessions into video files

## Overview

This project uses Vagrant to configure a known state VM that can be used for recording terminal sessions, and then converting those sessions into video. 

## Getting Started

First, bring up the VM using Vagrant.

`vagrant up`

Then ssh into it..

`vagrant ssh`

## To record a session

Outside the VM, use the `script` command to record your session, using an xterm with identical specs to the one that will be used to record the playback.

`script` records timing info to one file, and character data to another. 
_(The font can be obtained via `apt-get install fonts-inconsolata`)_

`xterm -fa "Inconsolata" -fs 12 -rv -geometry 80x28 -e "script -tTIMING -q MYSCRIPT`

Repeat this step until you have a session recorded that you are happy with, etc. 

## To convert a session into a video file. 

`/vagrant/makerecording.sh MYSCRIPT MYTIMING /vagrant/output.mp4`

