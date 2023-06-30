bam_file=$1
bam_file_pre=`echo $bam_file|perl -npe "s/.*\///" |perl -npe "s/\..*//"`
ran_num=$2
input_gt=$3
REF=$4
over_len=$5
if [[  -d "regions_$ran_num" ]]
then
	rm -rf regions_$ran_num split_softclipped_$ran_num split_softclipped_sort_$ran_num head_$ran_num.sam
fi

mkdir regions_$ran_num split_softclipped_$ran_num split_softclipped_sort_$ran_num
samtools view -T $REF -H $bam_file  >head_$ran_num.sam

cat $input_gt|perl -F'\t' -alne '$start=$F[1]-50;$start2=$F[1]-100;;$end=$F[1]+50;$end2=$F[1]+100;print "$F[0]:$start-$end\t$F[4]";' |xargs -I{} -P 40 perl generateBKSinBam.pl {} $ran_num $bam_file $REF >vsoft_pos/$bam_file_pre_${ran_num}_vsoft.bed 
echo "generate record finished!"
ls split_softclipped_$ran_num |grep "_mapClip"|while read file;do ./extractSoftclipped -l 7 <(cat head_${ran_num}.sam split_softclipped_$ran_num/$file ) |perl ../fastqToBKS.pl;done >BKSinBAM_oneBP/${bam_file_pre}.tsv
echo "Breakpoint detected finished!!"

ls ../arcBKS/*|xargs -n 1 -P 10 -I{} bash generateBKSinBam_each.sh {} $bam_file_pre $over_len

rm -rf split_softclipped_$ran_num split_softclipped_sort_$ran_num head_$ran_num.sam regions_$ran_num

