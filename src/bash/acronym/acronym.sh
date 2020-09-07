#!/usr/bin/env bash

result=""
replacement=" "
string=${1^^}
string=${string/\'/"A"} 
string=${string//[^[:alnum:]]/$replacement} 

for word in $string
do
    result+=${word:0:1}
done

echo $result
