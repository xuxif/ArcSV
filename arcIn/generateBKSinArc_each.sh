bam=$1
region=$2
ran=$RANDOM
extractSoftclipped -l 2 <(samtools view -h $bam $region |perl -F'\t' -alne 'if($_=~/^@/) {print "$_";} else{$F[1]=0;print join("\t",@F);}' ) |perl fastqToBKS.pl  >tmp_$region.txt
