#!/usr/bin/env bash

set -u

declare -r mapping=([3]="Pling" [5]="Plang" [7]="Plong")
declare result=""

if (( $# != 1 ))
then
    echo Needs exactly one argument 1>&2
    exit 1
fi

for i in "${!mapping[@]}"
do
    if (( $1 % i == 0 ))
    then
        result=$result${mapping[i]}
    fi
done

[[ $result == "" ]] && echo $1 || echo $result