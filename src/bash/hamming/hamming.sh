#!/usr/bin/env bash

if (( $# != 2 ))
then
    echo "Usage: hamming.sh <string1> <string2>" >&2
    exit 1
fi 
# echo bla ${#1} ${#2}
if (( ${#1} != ${#2} ))
then
    echo left and right strands must be of equal length >&2
    exit 1
fi 

distance=0

for (( i=0; i<${#1}; i++))
do
    if [ ${1:i:1} != ${2:i:1} ]
    then
        (( distance++ ))
    fi
done

echo "$distance"