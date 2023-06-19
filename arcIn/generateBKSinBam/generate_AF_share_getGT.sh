sample=$1
arc=$2
subpop=$3
pop=$4
##CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT
cat <(cat head.vcf|perl -npe "s/\tFORMAT.*/\tFORMAT\t$sample/") <(bedtools intersect -b <(cat ${sample}_${arc}_hg38.tsv|pos2bed) -a <(grep "$sample" ~/hgdp_SV_vcf/hgdp_ins_manta_BKs.bed |cut -f1-2,4-|pos2bed ) -wa  -wb |cut -f1,2,4,5,11,13 |pos2bed 1|bedtools merge -c 4,5,6,7 -o distinct,distinct,max,max |perl -npe "s/,.*?\t/\t/g" |cut -f1-4,6,7 |bed2pos  |perl -npe "s/\t(0\/1)/\t${subpop}_AC=1;${pop}_AC=1\t\1/;s/\t(1\/1)/\t${subpop}_AC=2;${pop}_AC=2\t\1/"|perl -F'\t' -alne 'print "$F[0]\t$F[1]\t\.\tN\t<INS>\t\.\t\.\t$F[2];evidence_arc=$F[4];evidence_mod=$F[5]\tGT\t$F[3]";' ) |bcftools sort -Oz >${sample}_${arc}_hg38.vcf.gz

#cat <(cat head.vcf|perl -npe "s/\tFORMAT.*/\tFORMAT\t$sample/") <(bedtools intersect -b <(cat ${sample}_${arc}_hg38.tsv|pos2bed) -a <(grep "$sample" ~/1kGP_SV_vcf/1kGP.bed |perl -F'\t' -alne 'if($F[1]>$F[2]) {$tmp=$F[1];$F[1]=$F[2];$F[2]=$tmp;} print "$F[0]\t$F[1]\t$F[3]\t$F[4]\n$F[0]\t$F[2]\t$F[3]\t$F[4]";'|pos2bed 50 ) -wa  -wb|perl -F'\t' -alne '$F[1]=$F[1]+50;$F[2]=$F[2]-50;print join("\t",@F);' |cut -f1,2,4,5,11,13|pos2bed 1|bedtools merge -c 4,5,6,7 -o distinct,distinct,max,max |perl -npe "s/,.*?\t/\t/g" |cut -f1-4,6,7 |bed2pos  |perl -npe "s/\t(0\/1)/\t${subpop}_AC=1;${pop}_AC=1\t\1/;s/\t(1\/1)/\t${subpop}_AC=2;${pop}_AC=2\t\1/"|perl -F'\t' -alne 'print "$F[0]\t$F[1]\t\.\tN\t<INS>\t\.\t\.\t$F[2];evidence_arc=$F[4];evidence_mod=$F[5]\tGT\t$F[3]";' ) |bcftools sort -Oz >${sample}_${arc}_hg38.vcf.gz
bcftools index ${sample}_${arc}_hg38.vcf.gz
