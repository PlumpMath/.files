#!/bin/bash

# Setting up scrolling on laptop
if synclient &>/dev/null; then
  synclient HorizTwoFingerScroll=1
  synclient HorizScrollDelta=250
  synclient PalmDetect=1
  synclient VertEdgeScroll=0
  synclient TapButton2=2
fi
# Set the keymap and set caps to be a windows key.
setxkbmap qq dvorak
setxkbmap -option caps:super
