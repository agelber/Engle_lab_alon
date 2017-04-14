#!/bin/bash                                                                     

f=$1
sort $f | uniq -d | grep "@"  > temp.txt

    while read in; do
        rname=$in
        i=1
        echo $rname
        while grep -q "$rname" $f; do
            replace=${rname/0:0/$i:0}
            sed -i.bu "0,/$rname/s/$rname/$replace/" "$f"
            i=$i+1
        done

    done < temp.txt


#!/bin/bash                                                                     

fdir=$1"/*"

for f in $fdir
do
    sort $f | uniq -d | grep "@"  > temp.txt

    while read in; do
        rname=$in
        i=1
        rname=${rname%" "*}
        while grep -q "$rname" $f; do
            replace=${rname/0:0/$i:0}
            sed '0,/$rname/{s/$rname/$replace/}' $f
            i=$i+1
        done

    done < temp.txt


done
