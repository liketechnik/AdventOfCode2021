#!/usr/bin/env bash

function search_number() {
    numbers=$(cat $1)
    
    linelength=$(($(head -n1 $1 | wc -c) - 1))
    for (( index = 1; index <= $linelength; index++ ))
    do
        zeroes=$(echo -e "$numbers" | grep -c -E "^[0-9]{$(($index - 1))}0{1}[0-9]*")
        ones=$(echo -e "$numbers" | grep -c -E "^[0-9]{$(($index - 1))}1{1}[0-9]*")
    
        if [[ ($2 == oxygen && $zeroes -gt $ones) || ($2 == co2 && $zeroes -le $ones) ]] # more zeroes (in oxygen case)
        then
            numbers=$(echo -e "$numbers" | grep -E "^[0-9]{$(($index - 1))}0{1}[0-9]*") 
        else  # more ones or equal
            numbers=$(echo -e "$numbers" | grep -E "^[0-9]{$(($index - 1))}1{1}[0-9]*") 
        fi
    
        lines=$(echo -e "$numbers" | wc -l)
        if [[ $lines -eq 1 ]]
        then
            echo "$((2#$numbers))"
            return 0
        fi
    done
    
    echo "No solution found :(" >&2
    exit 2
}

oxygen="$(search_number $1 oxygen)"
co2="$(search_number $1 co2)"
echo "Oxygen: $oxygen, Co2: $co2, Result: $(($oxygen * $co2))"
