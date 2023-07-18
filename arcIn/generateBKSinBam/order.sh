#/public/share/wchirdzhq2022/20230129/hgdp_3/HGDP00606.alt_bwamem_GRCh38DH.20181023.Druze.cram
bam_file=$1
sample=`echo $bam_file|perl -npe "s/.*\///"|perl -npe "s/\..*//"`
while getopts i:r:m:b:q:v:w:o:c:j:d:h option
do
   case "${option}"  in
                i) bam_file=${OPTARG};;
                r) REF=${OPTARG};;
                b) input_bed=${OPTARG};;
                h) usage;;
                ?) usage;;
   esac

done

if [[ ! -n "$REF" ]]
then
		echo "-r reference.fa is required"
		exit
fi
if [[ ! -f $bam_file ]] && [[ ! -f "$PWD/$bam_file" ]]
then
	echo "-r $bam_file is not existed!"
	exit
fi
if [[ ! -f $input_bed ]] && [[ ! -f "$PWD/$input_bed" ]]
then
	echo "-r $input_bed is not existed!"
	exit
fi

#cat /public/home/xuxf/hgdp_SV_vcf/hgdp_ins_manta_BKs.bed |grep "$sample"|cut -f1,2  >${sample}_input.bed
#cat /public/home/xuxf/1kGP_SV_vcf/1kGP.bed |grep "$sample"|perl -F'\t' -alne 'print "$F[0]\t$F[1]\n$F[0]\t$F[2]";'  >${sample}_input.bed
ran=$((RANDOM*RANDOM))
while [[  -d "regions_$ran" ]]
do
	ran=$((RANDOM*RANDOM))
done
bash generateBKSinBam.sh  $bam_file $ran $input_bed $REF
#rm ${sample}_input.bed
