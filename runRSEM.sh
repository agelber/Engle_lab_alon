#!/bin/bash
#argument is base directory containing all fastq directories e.g A1, A2, A3...
#if using powerful computer, add ampersand on line before done to speed up

folder=$1
add="/*/"
dir=$folder$add
for d in `echo $dir`; do
    echo $d
    cd $d
    a=$d*R1_001.fastq
    a=`echo $a`
    pref="_R1_001.fastq"
    a=${a%$pref}
    a=${a#$d}
    echo $a
    ~/Desktop/RSEM-master/rsem-calculate-expression --paired-end --star --star-path ~/STAR-2.5.3a/bin/Linux_x86_64_static --paired-end -p 48 $d*R1_001.fastq $d*R2_001.fastq ~/Desktop/RSEMIndex/mm10_ens $a


done
