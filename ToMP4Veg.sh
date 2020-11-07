#!/bin/sh
SRC="$1"
EXT=${SRC##*.}
DST=${SRC%.$EXT}.mp4
rm "$DST" 2> /dev/null
["$SRC" == "$DST"] && exit
echo "===========================Re-Encodeando==========================="
echo "Origien: $SRC"
echo "Destino: $DST"
echo "===================================================================" >> $LOG
/usr/bin/ffmpeg -i "$SRC"  -c:v libx264 -crf 24 "$DST" && rm "$SRC"
