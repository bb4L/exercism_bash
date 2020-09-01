#!/usr/bin/env bash

declare -A mapping
mapping=(["black"]=0 ["brown"]=1 ["red"]=2 ["orange"]=3 ["yellow"]=4 ["green"]=5 ["blue"]=6 ["violet"]=7 ["grey"]=8 ["white"]=9)

check_value () {
    if ! [[ -v "mapping[$1]" ]]
        then
            echo invalid color
            exit 1
        fi
}

count=1
result=""
for i in "$@"
do
  check_value $i
  result=$result${mapping[$i]}
 
  if (( $count == 2 ))
    then
      break
  fi
  
  ((count++))
done

echo $result