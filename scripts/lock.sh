#!/bin/sh

CLEAR='#00000000'
BLACK_DARK='#222D31FF'
BLACK_LIGHT='#585858FF'

RED_DARK='#ab4642ff'
RED_LIGHT='#ab4642ff'

GREEN_DARK='#7E807Eff'
GREEN_LIGHT='#8D8F8Dff'

YELLOW_DARK='#f7ca88ff'
YELLOW_LIGHT='#f7ca88ff'

BLUE_DARK='#8cafc2ff'
BLUE_LIGHT='#7cafc2ff'

MAGENTA_DARK='#ba8bafff'
MAGENTA_LIGHT='#ba8bafff'

CYAN_DARK='#1ABB9Bff'
CYAN_LIGHT='#1ABB9Bff'

WHITE_DARK='#d8d8d8ff'
WHITE_LIGHT='#f8f8f8ff'

i3lock \
--insidevercolor=$BLACK_DARK \
--ringvercolor=$WHITE_DARK \
\
--insidewrongcolor=$BLACK_DARK \
--ringwrongcolor=$RED_DARK   \
\
--insidecolor=$BLACK_DARK \
--ringcolor=$WHITE_DARK \
--linecolor=$WHITE_DARK \
--separatorcolor=$MAGENTA_LIGHT \
\
--verifcolor=$WHITE_DARK \
--wrongcolor=$RED_DARK        \
--timecolor=$WHITE_LIGHT        \
--datecolor=$WHITE_LIGHT                \
--layoutcolor=$WHITE_LIGHT              \
--keyhlcolor=$BLACK_DARK \
--bshlcolor=$RED_DARK \
\
--screen 1            \
--blur 8              \
--clock               \
--indicator           \
--timestr="%H:%M:%S"  \
--datestr="%A, %m %Y" \
--keylayout 2         \

# --veriftext="Drinking verification can..."
# --wrongtext="Nope!"
# --textsize=20
# --modsize=10 \
# --timefont=comic-sans
# --datefont=monofur
# etc
