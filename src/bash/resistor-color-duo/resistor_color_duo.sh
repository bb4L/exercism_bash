#!/usr/bin/env bash

count=1
result=""
for i in "$@"
do
  case $i in
      "black" )
        result=$result"0";;
      "brown" )
        result=$result"1";;
      "red" )
        result=$result"2";;
      "orange" )
        result=$result"3";;
      "yellow" )
        result=$result"4";;
      "green" )
        result=$result"5";;
      "blue" )
        result=$result"6";;
      "violet" )
        result=$result"7";;
      "grey" )
        result=$result"8";;
      "white" )
        result=$result"9";;
      * )
        echo invalid color
        exit 1
  esac

  if (( $count == 2 ))
    then
      break
  fi
  count=$count+1
done

echo $result