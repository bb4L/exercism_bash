#!/usr/bin/env bash

set -o noglob

declare -A mapping
mapping=([")"]="(" ["]"]="[" ["}"]="{")

openings="[{("
closings="]})"

declare -A opened

opened=""

for (( i=0; i<=${#1}; i++))
do
    actual_value=${1:$i:1}
    if [[ "$openings" == *"$actual_value"* ]]
    then
        opened+=$actual_value
    else
        if [[ "$closings" == *"$actual_value"* ]]
        then
            if [[ -z $opened || $opened != *"${mapping[$actual_value]}" ]]
            then
                echo "false"
                exit 0
            else
                opened=${opened%?}
            fi
        fi
    fi
done

[[ -z $opened ]] && echo "true" || echo "false"
