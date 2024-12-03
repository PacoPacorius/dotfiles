#!/usr/bin/bash

date=$(date +"%Y-%m-%d")
rm $2
urxvt -geometry 40x15+0+0 -e ffcast -s ffmpeg -y -f x11grab -show_region 1 -s %s -i %D+%c -f pulse -i default "$HOME/screencast/temp${date}.mp4"
ffmpeg -i $HOME/screencast/temp${date}.mp4 -ss 00:00:00.000 -pix_fmt rgb8 -r 10 -s $1 $2


