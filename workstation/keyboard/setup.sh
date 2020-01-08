#!/bin/sh

# Map Keyboardio butterfly key to mod3
xmodmap -e "clear mod1"
xmodmap -e "add mod1 = Alt_L"
xmodmap -e "add mod3 = Alt_R"
