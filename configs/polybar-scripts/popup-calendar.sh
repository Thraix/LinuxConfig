#!/bin/sh

YAD_WIDTH=200
YAD_HEIGHT=200
BOTTOM=false
DATE="$(date +"%H:%M")"
if [ $(pgrep yad) ]; then
  pgrep yad | xargs kill
else
  eval "$(xdotool getmouselocation --shell)"
  $(( pos_y = Y + 5 ))
  $(( pos_x = X - YAD_WIDTH - 20 ))
  yad --calendar --undecorated --fixed --close-on-unfocus --no-buttons --show-weeks --width=$YAD_WIDTH \
  --height=$YAD_HEIGHT --posx=$pos_x --posy=$pos_y --gtkrc=.config/themes/gtkrc & > /dev/null
fi
