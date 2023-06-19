ac=$1
arc_name=`echo $1 |perl -npe "s/.*\///"|perl -npe "s/\..*//"`
bam_file_pre=$2
over_len=$3
if [ -z "$var" ]
then
        over_len=50
fi

#bedtools intersect -b <( cat BKSinBAM/${bam_file_pre}.tsv|pos2bed 1|grep -v "\-") -a <(cat $ac|pos2bed 1|grep -v "\-") -wa -wb | perl BKinCheck.pl|pos2bed 1|sort -k1,1 -k2,2n -k4,4 |uniq |perl -F'\t' -alne 'print "$F[4]\t$F[0]\t$F[1]\t$F[2]\t$F[3]";'|uniq -c -f 1 |perl -npe "s/^ +(\d+) +(\w+)\t(.*)/\3\t\1/"|bedtools merge -d $over_len -c 4,5 -o collapse |perl -F'\t' -alne '$SUM{"left"}=0;$SUM{"right"}=0;@dir=split(/,/,$F[3]);@count=split(/,/,$F[4]);for($i=0;$i<=$#dir;$i++){ $SUM{"$dir[$i]"}+=$count[$i];} ;print "$F[0]\t$F[1]\t".$SUM{"left"}."\t".$SUM{"right"};'|grep -Ev $'\t'"0"$'\t'"0" >BKsArcInBAM/${bam_file_pre}_${arc_name}.tsv
bedtools intersect -b <( cat BKSinBAM_oneBP/${bam_file_pre}.tsv|pos2bed 1|grep -v "\-") -a <(cat ~/arcIn/arcBKS/$ac|pos2bed 1|grep -v "\-") -wa -wb | perl BKinCheck_len.pl|pos2bed 1 |sort -k1,1 -k2,2n |cut -f1-5,7 >BKsArcInBAM_oneBP/${bam_file_pre}_$arc_name.tsv
echo "$bam_file_pre $arc_name finished!"
