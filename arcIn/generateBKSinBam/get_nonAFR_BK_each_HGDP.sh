sample=$1
bedtools intersect -b <(cat tmp_afr_1kg_dan_hgdp.bed ) -a <(cat BKsArcInBAM/${sample}_dan_hg38.tsv|pos2bed 2 ) -v  >BKsArcInBAM_nonAFR/${sample}_dan.bed
bedtools intersect -b <(cat tmp_afr_1kg_Altai_hgdp.bed ) -a <(cat BKsArcInBAM/${sample}_Altai_hg38.tsv|pos2bed 2) -v  >BKsArcInBAM_nonAFR/${sample}_Altai.bed
bedtools intersect -b <(cat tmp_afr_1kg_Vindija_hgdp.bed ) -a <(cat BKsArcInBAM/${sample}_Vindija_hg38.tsv|pos2bed 2) -v  >BKsArcInBAM_nonAFR/${sample}_Vindija.bed

