#!/usr/bin/env bash

set -u


if (( $# != 2 )) || ! [[ $1 =~ ^-?[0-9]+.?[0-9]*$ ]] || ! [[ $2 =~ ^-?[0-9]+.?[0-9]*$ ]]
then
    echo needs exactly two numerical arguments 1>&2
    exit 1
fi

d=$(awk -v x=$1 -v y=$2 'BEGIN{print ((x*x) + (y*y))}')

if (( $(awk -v x=$d -v y=100 'BEGIN {print  (x>y)}') == 1 ))
then
    echo 0
    exit
fi

if (( $(awk -v x=$d -v y=25 'BEGIN {print  (x>y)}') == 1 ))
then
    echo 1
    exit
fi

if (( $(awk -v x=$d -v y=1 'BEGIN {print  (x>y)}') == 1 ))
then
    echo 5
    exit
fi

echo 10
