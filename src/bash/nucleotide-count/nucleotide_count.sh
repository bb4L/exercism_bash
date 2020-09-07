#!/usr/bin/env bash

declare -A nucleotides=(["A"]=0 ["C"]=0 ["G"]=0 ['T']=0)

if (( $# == 1 )) && (( ${#1} > 0 ))
then
    for (( i=0; i<${#1}; i++ ))
    do
        c="${1:i:1}"
        case $c in
        A | C | G | T)
            (( nucleotides["$c"]++ )) ;;
        *)
            echo "Invalid nucleotide in strand" >&2
            exit 1 ;;
        esac
    done
fi

for nucleotide in A C G T
do
        echo "$nucleotide: ${nucleotides["$nucleotide"]}"
done