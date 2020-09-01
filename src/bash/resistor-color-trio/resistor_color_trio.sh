#!/usr/bin/env bash

declare -A mapping
mapping=(["black"]=0 ["brown"]=1 ["red"]=2 ["orange"]=3 ["yellow"]=4 ["green"]=5 ["blue"]=6 ["violet"]=7 ["grey"]=8 ["white"]=9)
prefix=(kilo mega giga)

check_value () {
    if ! [[ -v "mapping[$1]" ]]
        then
            echo invalid color
            exit 1
        fi
    return ${mapping[$1]}
}

color_count=1
result=""

for (( i=1; ((i<=$#)) && ((i<3)) ; i++))
do
    check_value ${!i}
    mapped_value=${mapping[${!i}]}

        if !(( (( $i == 1 )) && (( $mapped_value == 0 )) ))
        then
            result=$result${mapped_value}
        fi
done


additional_string=""
zeros=""

if (($# >= 3 )) 
then
    check_value $3
    mapped_value=${mapping[$3]}

    if (( $mapped_value > 0 )) 
    then

        zeros=$(printf %${mapped_value}s |tr " " "0")
        result=$result$zeros
        prefix_counter=-1
        
        while [[ $result > 1000 ]] && [[ $(( $result % 1000 )) == 0 ]]
        do
            prefix_counter=$(( $prefix_counter + 1 ))
            result=$(( $result / 1000 ))
        done
                    
        if (( $prefix_counter != -1 ))
        then
            additional_string=${prefix[$prefix_counter]}
        fi
    fi
fi

echo $result" "$additional_string"ohms"