sample=$1
bedtools intersect -a <(cat ~/1kGP_SV_vcf/1kGP_AFR_AF.bed|perl -F'\t' -alne 'print "$F[0]\t$F[1]\t$F[3]\n$F[0]\t$F[2]\t$F[3]";'|pos2bed 2) -b <(cat BKsArcInBAM/${sample}_dan_hg38.tsv|pos2bed ) -wa -wb |perl -F'\t' -alne 'if($F[3] ==0){print "$_";}' >BKsArcInBAM_nonAFR/${sample}_dan.bed
bedtools intersect -a <(cat ~/1kGP_SV_vcf/1kGP_AFR_AF.bed|perl -F'\t' -alne 'print "$F[0]\t$F[1]\t$F[3]\n$F[0]\t$F[2]\t$F[3]";'|pos2bed 2) -b <(cat BKsArcInBAM/${sample}_Altai_hg38.tsv|pos2bed ) -wa -wb |perl -F'\t' -alne 'if($F[3] ==0){print "$_";}' >BKsArcInBAM_nonAFR/${sample}_Altai.bed
bedtools intersect -a <(cat ~/1kGP_SV_vcf/1kGP_AFR_AF.bed|perl -F'\t' -alne 'print "$F[0]\t$F[1]\t$F[3]\n$F[0]\t$F[2]\t$F[3]";'|pos2bed 2) -b <(cat BKsArcInBAM/${sample}_Vindija_hg38.tsv|pos2bed ) -wa -wb |perl -F'\t' -alne 'if($F[3] ==0){print "$_";}' >BKsArcInBAM_nonAFR/${sample}_Vindija.bed

