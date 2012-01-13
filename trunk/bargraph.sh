#!/bin/sh
gnuplot << EOF
set terminal png
set output "$2"
set yrange [0:35000]
plot "$1" using 1:2 with imp ls 1
EOF
