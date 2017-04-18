#!/bin/bash                                                                     
#!/bin/bash                                                                     

fdir=$1"*"

for f in $fdir
do
    (
 for i in 1 2
 do

sort $f | uniq -d | grep ^@  > "$f".txt

    while read in; do
        rname=$in
        i=1
        echo $rname
        while grep -q "$rname" $f; do
            replace=${rname/0:0/$i:0}
            sed -i.bu "0,/$rname/s/$rname/$replace/" "$f"
            let "i+=1"
	    echo $i
        done

    done < "$f".txt



rm "$f".txt

done
echo done'\n' >> progress.txt

)&

 background=( $(jobs -p) )
    if (( ${#background[@]} ==40)); then
	wait -n
     fi
done
