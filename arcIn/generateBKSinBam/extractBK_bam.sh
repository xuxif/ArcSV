sample=$1
samtools view -T ~/reference/Homo_sapiens_assembly38.fasta ~/1kGP/${sample}.final.cram -O bam -o ${sample}_region.bam `grep "$sample" ~/1kGP_SV_vcf/1kGP.bed |perl -F'\t' -alne 'print "$F[0]\t$F[1]\n$F[0]\t$F[2]";'|pos2bed |perl -npe "s/\t/:/;s/\t/-/;s/\n/ /"|perl -npe "s/$/\n/"`
