input=/NAS/DeepMEI/DeepMEI_output/HG02818.final.cram/trans_HG02818.bed
input=$1
cat $input |perl -F'\t' -alne 'print "$F[0]\t$F[1]\n$F[0]\t$F[2]";' 
