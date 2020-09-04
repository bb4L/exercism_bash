#!/usr/bin/env bash

declare -A mapping
mapping=([3]="Pling" [5]="Plang" [7]="Plong")

result=""

if (( $# != 1 ))
then
    echo Needs exactly one argument
    exit 1
fi

for i in "${!mapping[@]}"
do
    if (( $1 % $i == 0 ))
    then
        result=${mapping[$i]}$result
    fi
done

if [[ $result == "" ]]
then
    result=$1
fi

echo $result
