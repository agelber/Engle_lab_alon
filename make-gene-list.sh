#!/bin/bash
#create a gene id,gene name csv from gtf file
while read in; do
    (gid=$in
    gname=$in
    pref=`echo '*gene_id "'`
    suf=`echo '"; gene_version*'`
    gid=${gid##$pref}
    gid=${gid%%$suf}
    pref=`echo '*gene_name "'`
    suf=`echo '"; gene_source*'`
    gname=${gname##$pref}
    gname=${gname%%$suf}
    addto=$gid,$gname
    echo $addto >> geneListrep.csv)&
done < $1

wait

sort -u geneListrep.csv >> geneList.csv
rm geneListrep.csv

