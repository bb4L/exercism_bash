#!/usr/bin/env bash

number_of_args=$#
sum=0
index=0
frame_count=0
bonus=0
frame_type="new"

for i in "$@"
do
    if (( $i < 0 ))
    then
        echo "Negative roll is invalid"
        exit 1
    fi

    if (( $i > 10 ))
    then
        echo "Pin count exceeds pins on the lane"
        exit 1
    fi
    
    sum=$(( $sum + $i ))

    case $frame_type in
        "new")
            if (( $i == 10 ))
            then
                frame_count=$(( $frame_count + 1 ))

                if (( $frame_count == 10))
                then 
                    bonus=2
                    k=$(( $index + 2))
                    v=$(( $index + 3))
                    if (($number_of_args == $v)) && (( ${!k} + ${!v} > 10)) && ((${!k} != 10))
                    then
                        echo "Pin count exceeds pins on the lane"
                        exit 1
                    fi
                fi

                if (( $number_of_args - $index >1 )) && (( $frame_count < 10 ))
                then
                    k=$(( $index + 2))
                    sum=$(( $sum + ${!k} ))

                    if (( $number_of_args - $index >2))
                    then
                    k=$(( $index + 3))
                    sum=$(( $sum + ${!k} ))
                    fi

                fi
            else
                if (( $frame_count >= 10))
                then
                    frame_count=$(( $frame_count + 1 ))
                else
                    frame_type="spare"
                fi

            fi
            ;;
        
        "spare")
            if (( $i + ${!index} > 10 ))
            then
            echo "Pin count exceeds pins on the lane"
            exit 1
            fi
            
            if (( $i + ${!index} == 10 ))
            then
                if (( $frame_count == 9 ))
                then
                    bonus=1
                fi
                if (( $number_of_args - $index > 1 )) && (($frame_count < 9 ))
                then
                    k=$(( $index + 2 ))
                    sum=$(( $sum + ${!k} ))
                fi
            fi

            frame_count=$(( $frame_count + 1 ))
            frame_type="new"

            ;;
    esac

    index=$(( $index + 1 ))

done

if [[ $frame_type == "spare" ]]
then
    frame_count=$(( $frame_count + 1))
fi

if (( $frame_count > 10 + $bonus))
then
    echo "Cannot roll after game is over"
    exit 1
fi
if (( $frame_count < 10 + $bonus))
then
    echo "Score cannot be taken until the end of the game"
    exit 1
fi

echo $sum
