#!/bin/sh

setxkbmap -option "ctrl:nocaps,lalt:lalt_bksp"
xmodmap -e "keycode 107 = Super_L"
# xmodmap -e "add mod3 = Print"