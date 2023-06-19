sample=$1
arc=$2
subpop=$3
pop=$4
##CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT
cat <(cat head.vcf|perl -npe "s/\tFORMAT.*/\tFORMAT\t$sample/") <(bedtools intersect -b <(cat ${sample}_${arc}_hg38.tsv |perl -F'\t' -alne 'if($F[5]>5){print $_;}') -a <(grep "$sample" ~/1kGP_SV_vcf/1kGP.bed |perl -F'\t' -alne 'print "$F[0]\t$F[1]\t$_\n$F[0]\t$F[2]\t$_";'|pos2bed 50 ) -wa  -wb|cut -f4-|sort |uniq |pos2bed 1 |sort -k1,1 -k2,2n |bedtools merge -c 5,6,8,10,11,12 -o distinct,distinct,distinct,distinct,sum,max |perl -npe "s/\t(0\/1)/\t${subpop}_AC=1;${pop}_AC=1\t\1/;s/\t(1\/1)/\t${subpop}_AC=2;${pop}_AC=2\t\1/"|bed2pos |perl -F'\t' -alne '$pos=$F[5];$pos=~s/,.*//;$pos++;$F[3]=~s/,.*//;print "$F[0]\t$pos\t\.\tN\t<INS>\t\.\t\.\t$F[2];BkArc=$F[5];evidenceArc=$F[7];evidenceMod=$F[8]\tGT\t$F[3]";' ) |bcftools sort -Oz >${sample}_${arc}_hg38.vcf.gz


bcftools index ${sample}_${arc}_hg38.vcf.gz
