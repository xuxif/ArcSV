bam_file=$1
bam_file_pre=`echo $bam_file|perl -npe "s/.*\///" |perl -npe "s/\..*//"`
ran_num=666666
input_gt=$2
REF=~/reference/Homo_sapiens_assembly38.fasta
if [[  -d "regions_$ran_num" ]]
then
	rm -rf regions_$ran_num split_softclipped_$ran_num split_softclipped_sort_$ran_num head_$ran_num.sam
fi

mkdir regions_$ran_num split_softclipped_$ran_num split_softclipped_sort_$ran_num
samtools view -T $REF -H $bam_file  >head_$ran_num.sam

cat $input_gt|perl -F'\t' -alne 'if($F[2]*$F[3]>0){$start=$F[1]-50;$start2=$F[1]-100;;$end=$F[1]+50;$end2=$F[1]+100;print "$F[0]:$start-$end\t$F[4]";}' |xargs -I{} -P 40 perl generateBKSinBam.pl {} $ran_num $bam_file $REF  >/dev/null
