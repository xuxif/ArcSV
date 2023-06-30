bam_file=$1
out_file=`echo $bam_file|perl -npe "s/.*\///"`
samtools view -h $bam_file |grep "^@SQ"|head -n 25|perl -npe "s/.*SN://;s/LN:/1\t/"|bedtools makewindows -b /dev/stdin -w 50000000 |perl -npe "s/\t/:/;s/\t/-/" |xargs -n 1 -P 20 -I{} bash generateBKSinArc_each.sh $bam_file {}

cat `samtools view -h $bam_file |grep "^@SQ"|head -n 25|perl -npe "s/.*SN://;s/LN:/1\t/"|bedtools makewindows -b /dev/stdin -w 50000000 |perl -npe "s/\t/:/;s/\t/-/" |perl -npe "s/^/tmp_/;s/$/\.txt/;s/\n/ /"|perl -npe "s/$/\n/"` |perl -F'\t' -alne '$i++;$name="read_$i";print "$_\t$name";' > ${out_file}.tsv
sort -k1,1 -k2,2n ${out_file}.tsv >arcBKS/${out_file}.tsv
rm `samtools view -h $bam_file |grep "^@SQ"|head -n 25|perl -npe "s/.*SN://;s/LN:/1\t/"|bedtools makewindows -b /dev/stdin -w 50000000 |perl -npe "s/\t/:/;s/\t/-/" |perl -npe "s/^/tmp_/;s/$/\.txt/;s/\n/ /"|perl -npe "s/$/\n/"` ${out_file}.tsv
