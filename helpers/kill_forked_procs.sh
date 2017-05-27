#!/bin/bash

# kill all forked ocelot proc that lost their original parent

proclist=$( ps -f --ppid 1 -o pid,command | grep ocelot )
echo -en "$proclist\nkill? [y] "
read answer

if [[ "$answer" == "y" ]] ; then
    sleep 1
    proclist=$( echo "$proclist" | tr -s ' ' )
    i=1
    for proc in $proclist ; do
        tproc=$( echo "$proc" | xargs )
        if [[ "$i" -eq 1 ]] ; then
            echo "$tproc"
            kill "$tproc"
        fi
        if [[ "$i" -eq 3 ]] ; then
            i=0
        fi
        i=$(( i+1 ))
    done
    echo "done"
else
    echo "aborted"
fi
