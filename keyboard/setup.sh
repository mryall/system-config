#!/bin/sh

setxkbmap -option "ctrl:nocaps,lalt:lalt_bksp"
xmodmap -e "add mod3 = Print"
