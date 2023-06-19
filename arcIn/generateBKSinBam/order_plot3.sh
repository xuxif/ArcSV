#/public/share/wchirdzhq2022/20230129/hgdp_3/HGDP00606.alt_bwamem_GRCh38DH.20181023.Druze.cram
bam_file=$1
sample=`echo $bam_file|perl -npe "s/.*\///"|perl -npe "s/\..*//"`
ran=$RANDOM
ref=/public/home/xuxf/reference/Homo_sapiens_assembly38.fasta
cat /public/home/xuxf/hgdp_SV_vcf/hgdp_ins_manta_BKs.bed |grep "$sample"|cut -f1,2  >${sample}_input.bed
#cat /public/home/xuxf/1kGP_SV_vcf/1kGP.bed |grep "$sample"|perl -F'\t' -alne 'print "$F[0]\t$F[1]\n$F[0]\t$F[2]";'  >${sample}_input.bed
bash generateBKSinBam.sh  $bam_file $ran ${sample}_input.bed $ref
rm ${sample}_input.bed
