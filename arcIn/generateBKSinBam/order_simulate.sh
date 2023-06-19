bam_file=$1
record=$2
ref=~/reference/Homo_sapiens_assembly38.fasta
bedtools intersect -b <(samtools view -h -T $ref $bam_file $record |bedtools bamtobed 2>/dev/null  ) -a <(python getSoftclippedAndNearbySeq.py $bam_file $record $ref |bwa mem -t 10 -k 19 -r 1.5 -c 100000 -m 50 -T 20 -h 10000 -a -Y -M $ref /dev/stdin 2>/dev/null  |bedtools bamtobed  -cigar 2>/dev/null|perl -F'\t' -alne 'if($F[6]=~/S/) {print $_;}' ) -wa -u |cut -f4|wc -l |perl -npe "s/\n/\t/"
samtools view  -T $ref $bam_file $record|cut -f6 |grep "S"|wc -l
