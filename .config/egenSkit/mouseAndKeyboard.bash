#!/bin/bash

# Setting up scrolling on laptop
if synclient &>/dev/null; then
  synclient HorizTwoFingerScroll=1
  synclient HorizScrollDelta=250
  synclient PalmDetect=1
  synclient VertEdgeScroll=0
  synclient TapButton2=2

	deviceNumber=$(xinput list | grep TrackPoint | sed -rn 's/.*id=([0-9]+).*/\1/p')
	# Touch point scroll inertia when emulating scroll wheel.
	xinput set-prop $deviceNumber 303 5
	# Touch point acceleration profile
	xinput set-prop $deviceNumber 251 6
	# Touch point pointer inertia
	xinput set-prop $deviceNumber 252 0.6
	# Touch point pointer accelation
	xinput set-prop $deviceNumber 254 3
fi
# Set the keymap and set caps to be a windows key.
setxkbmap qq dvorak
setxkbmap -option caps:super
