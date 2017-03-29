#!/usr/bin/env bash
for d in */; do
    a=$d*L001_R1*
    echo $a
    a=`echo $a`
    suf="*/"
    a=${a#$suf}
    NAME1=${a/L001_R1_001/R1}
    NAME2=${a/L001_R1_001/R2}
    
 find "$d" -name *R1.fastq -prune -o -name '*R1*.fastq' -exec cat '{}' + >"$d/$NAME1"
 find "$d" -name *R2.fastq -prune -o -name '*R2*.fastq' -exec cat '{}' + >"$d/$NAME2"
done
