#!/bin/bash

# Setting up scrolling on laptop
if synclient >/dev/null; then
  synclient HorizTwoFingerScroll=1
  synclient HorizScrollDelta=250
  synclient PalmDetect=1
  synclient VertEdgeScroll=0
  synclient TapButton2=2
	# Touch point scroll inertia when emulating scroll wheel.
	xinput set-prop 13 303 5
	# Touch point acceleration profile
	xinput set-prop 13 251 6
	# Touch point pointer inertia
	xinput set-prop 13 252 0.6
	# Touch point pointer accelation
	xinput set-prop 13 254 3
fi
# Set the keymap and set caps to be a windows key.
setxkbmap qq dvorak
setxkbmap -option caps:super
