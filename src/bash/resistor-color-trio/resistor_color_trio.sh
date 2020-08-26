#!/usr/bin/env bash

declare -A mapping
mapping=(["black"]=0 ["brown"]=1 ["red"]=2 ["orange"]=3 ["yellow"]=4 ["green"]=5 ["blue"]=6 ["violet"]=7 ["grey"]=8 ["white"]=9)
prefix=(kilo mega giga)

color_count=1
result=""
for i in "$@"
do
    if (( $color_count < 3 ))
    then

        if [[ -v "mapping[$i]" ]]
        then
    
            if !(( (( $color_count == 1 )) && (( ${mapping[$i]} == 0 )) ))
            then
                result=$result${mapping[$i]}
            fi

        else
            echo invalid color
            exit 1
        fi
    
    else
    
        if [[ -v "mapping[$i]" ]]
        then
            mapped_value=${mapping[$i]}
            additional_string=""
            zeros=""

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

            result=$result" "$additional_string"ohms"

        else
            echo invalid color
            exit 1
        fi
    fi
    
    if (( $color_count == 3 ))
    then
      break
    fi
    
    color_count=$(( $color_count + 1 ))
    
done

echo $result