#cd BKsArcInBAM/
#cat ../../sample_info_1kGP_HGDP.tsv |grep  AFR|grep -v "HGDP"|while read sample pop;do cat ${sample}_Altai_hg38.tsv |perl -npe "s/$/\t$pop/";done  >../tmp_afr_1kg_Altai.bed &
#cat ../../sample_info_1kGP_HGDP.tsv |grep -v AFR|grep -v "HGDP"|while read sample pop;do cat ${sample}_Altai_hg38.tsv |perl -npe "s/$/\t$pop/";done  >../tmp_nonafr_1kg_Altai.bed &
#cat ../../sample_info_1kGP_HGDP.tsv |grep  AFR|grep -v "HGDP"|while read sample pop;do cat ${sample}_dan_hg38.tsv |perl -npe "s/$/\t$pop/";done  >../tmp_afr_1kg_dan.bed &
#cat ../../sample_info_1kGP_HGDP.tsv |grep -v AFR|grep -v "HGDP"|while read sample pop;do cat ${sample}_dan_hg38.tsv |perl -npe "s/$/\t$pop/";done  >../tmp_nonafr_1kg_dan.bed &
#cat ../../sample_info_1kGP_HGDP.tsv |grep  AFR|grep -v "HGDP"|while read sample pop;do cat ${sample}_Vindija_hg38.tsv |perl -npe "s/$/\t$pop/";done  >../tmp_afr_1kg_Vindija.bed &
#cat ../../sample_info_1kGP_HGDP.tsv |grep -v AFR|grep -v "HGDP"|while read sample pop;do cat ${sample}_Vindija_hg38.tsv |perl -npe "s/$/\t$pop/";done  >../tmp_nonafr_1kg_Vindija.bed &
#
#wait
#
#bedtools intersect -b <(sort -k1,1 -k2,2n tmp_afr_1kg_dan.bed |pos2bed 50 |bedtools merge ) -a <(sort -k1,1 -k2,2n tmp_nonafr_1kg_dan.bed |pos2bed 50 |bedtools merge -c 6,6,6,6 -o count,count_distinct,distinct,collapse ) -v  >tmp_intersectV_dan.bed
#bedtools intersect -b <(sort -k1,1 -k2,2n tmp_afr_1kg_Altai.bed|pos2bed 50 |bedtools merge ) -a <(sort -k1,1 -k2,2n tmp_nonafr_1kg_Altai.bed|pos2bed 50 |bedtools merge -c 6,6,6,6 -o count,count_distinct,distinct,collapse ) -v  >tmp_intersectV_Altai.bed
#bedtools intersect -b <(sort -k1,1 -k2,2n tmp_afr_1kg_Vindija.bed|pos2bed 50 |bedtools merge ) -a <(sort -k1,1 -k2,2n tmp_nonafr_1kg_Vindija.bed |pos2bed 50 |bedtools merge -c 6,6,6,6 -o count,count_distinct,distinct,collapse ) -v  >tmp_intersectV_Vindija.bed

cd BKsArcInBAM/
#cat ../sample_info_1kGP.txt|grep "AFR"|while read sample pop;do cat ${sample}_Altai_hg38.tsv |perl -npe "s/$/\t$pop/";done  >../tmp_afr_1kg_Altai.bed &
#cat ../sample_info_1kGP.txt|grep "AFR"|while read sample pop;do cat ${sample}_dan_hg38.tsv |perl -npe "s/$/\t$pop/";done  >../tmp_afr_1kg_dan.bed &
#cat ../sample_info_1kGP.txt|grep "AFR"|while read sample pop;do cat ${sample}_Vindija_hg38.tsv |perl -npe "s/$/\t$pop/";done  >../tmp_afr_1kg_Vindija.bed &
#
#cat ../sample_info_1kGP.txt|grep -v "AFR"|while read sample pop;do cat ${sample}_Altai_hg38.tsv |perl -npe "s/$/\t$pop/";done  >../tmp_nonafr_1kg_Altai.bed &
#cat ../sample_info_1kGP.txt|grep -v "AFR"|while read sample pop;do cat ${sample}_dan_hg38.tsv |perl -npe "s/$/\t$pop/";done  >../tmp_nonafr_1kg_dan.bed &
#cat ../sample_info_1kGP.txt|grep -v "AFR"|while read sample pop;do cat ${sample}_Vindija_hg38.tsv |perl -npe "s/$/\t$pop/";done  >../tmp_nonafr_1kg_Vindija.bed &
#
#wait
#echo "intersect"
#cd ..
#bedtools intersect -b <(sort -k1,1 -k2,2n tmp_afr_1kg_dan.bed |pos2bed 50 |bedtools merge ) -a <(sort -k1,1 -k2,2n tmp_nonafr_1kg_dan.bed |pos2bed 50 |bedtools merge -c 6,6,6,6,7,7,7,7 -o count,count_distinct,distinct,collapse,count,count_distinct,distinct,collapse ) -v  >tmp_intersectV_dan.bed &
#bedtools intersect -b <(sort -k1,1 -k2,2n tmp_afr_1kg_Altai.bed|pos2bed 50 |bedtools merge ) -a <(sort -k1,1 -k2,2n tmp_nonafr_1kg_Altai.bed|pos2bed 50 |bedtools merge -c 6,6,6,6,7,7,7,7 -o count,count_distinct,distinct,collapse,count,count_distinct,distinct,collapse ) -v  >tmp_intersectV_Altai.bed &
#bedtools intersect -b <(sort -k1,1 -k2,2n tmp_afr_1kg_Vindija.bed|pos2bed 50 |bedtools merge ) -a <(sort -k1,1 -k2,2n tmp_nonafr_1kg_Vindija.bed |pos2bed 50 |bedtools merge -c 6,6,6,6,7,7,7,7 -o count,count_distinct,distinct,collapse,count,count_distinct,distinct,collapse ) -v  >tmp_intersectV_Vindija.bed &
#


cat ../../sample_info_HGDP.tsv ../../sgdp_HGDP_sample.txt|grep "HGDP"|grep "AFR"|while read sample pop;do cat ${sample}_Altai_hg38.tsv |perl -npe "s/$/\t$pop/";done |perl -F'\t' -alne '$start=$F[1]-50;$end=$F[1]+50;print "$F[0]\t$start\t$end";'|sort -k1,1 -k2,2n|bedtools merge -c 3 -o count  >../tmp_afr_1kg_Altai_hgdp.bed &
cat ../../sample_info_HGDP.tsv ../../sgdp_HGDP_sample.txt|grep "HGDP"|grep "AFR"|while read sample pop;do cat ${sample}_dan_hg38.tsv |perl -npe "s/$/\t$pop/";done  |perl -F'\t' -alne '$start=$F[1]-50;$end=$F[1]+50;print "$F[0]\t$start\t$end";'|sort -k1,1 -k2,2n|bedtools merge -c 3 -o count >../tmp_afr_1kg_dan_hgdp.bed &
cat ../../sample_info_HGDP.tsv ../../sgdp_HGDP_sample.txt|grep "HGDP"|grep "AFR"|while read sample pop;do cat ${sample}_Vindija_hg38.tsv |perl -npe "s/$/\t$pop/";done |perl -F'\t' -alne '$start=$F[1]-50;$end=$F[1]+50;print "$F[0]\t$start\t$end";'|sort -k1,1 -k2,2n|bedtools merge -c 3 -o count  >../tmp_afr_1kg_Vindija_hgdp.bed &
wait

cat ../../sample_info_HGDP.tsv ../../sgdp_HGDP_sample.txt|grep "HGDP"|grep -v "AFR"|while read sample pop;do cat ${sample}_Altai_hg38.tsv |perl -npe "s/$/\t$pop/";done  >../tmp_nonafr_1kg_Altai_hgdp.bed &
cat ../../sample_info_HGDP.tsv ../../sgdp_HGDP_sample.txt|grep "HGDP"|grep -v "AFR"|while read sample pop;do cat ${sample}_dan_hg38.tsv |perl -npe "s/$/\t$pop/";done  >../tmp_nonafr_1kg_dan_hgdp.bed &
cat ../../sample_info_HGDP.tsv  ../../sgdp_HGDP_sample.txt|grep "HGDP"|grep -v "AFR"|while read sample pop;do cat ${sample}_Vindija_hg38.tsv |perl -npe "s/$/\t$pop/";done  >../tmp_nonafr_1kg_Vindija_hgdp.bed &
wait
echo "intersect"
cd ..
bedtools intersect -b <(sort -k1,1 -k2,2n tmp_afr_1kg_dan_hgdp.bed |pos2bed 50 |bedtools merge -c 2 -o count) -a <(sort -k1,1 -k2,2n tmp_nonafr_1kg_dan_hgdp.bed |pos2bed 50 |bedtools merge -c 6,6,7, -o count,distinct,distinct) -wa -wb |cut -f1-6,10  >tmp_intersectV_dan_hgdp.bed &
bedtools intersect -b <(sort -k1,1 -k2,2n tmp_afr_1kg_Altai_hgdp.bed|pos2bed 50 |bedtools merge ) -a <(sort -k1,1 -k2,2n tmp_nonafr_1kg_Altai_hgdp.bed|pos2bed 50 |bedtools merge -c 6,6,6,6,7,7,7,7 -o count,count_distinct,distinct,collapse,count,count_distinct,distinct,collapse ) -v  >tmp_intersectV_Altai_hgdp.bed &
bedtools intersect -b <(sort -k1,1 -k2,2n tmp_afr_1kg_Vindija_hgdp.bed|pos2bed 50 |bedtools merge ) -a <(sort -k1,1 -k2,2n tmp_nonafr_1kg_Vindija_hgdp.bed |pos2bed 50 |bedtools merge -c 6,6,6,6,7,7,7,7 -o count,count_distinct,distinct,collapse,count,count_distinct,distinct,collapse ) -v  >tmp_intersectV_Vindija_hgdp.bed &
bedtools intersect -b <(sort -k1,1 -k2,2n tmp_afr_1kg_dan_hgdp.bed |pos2bed 50 |bedtools merge -c 2 -o count) -a <(sort -k1,1 -k2,2n tmp_nonafr_1kg_dan_hgdp.bed |pos2bed 50 |bedtools merge -c 6,6,7, -o count,distinct,distinct) -wa -wb |cut -f1-6,10  >tmp_intersectV_dan_hgdp.bed &
bedtools intersect -b <(sort -k1,1 -k2,2n tmp_afr_1kg_Altai_hgdp.bed|pos2bed 50 |bedtools merge ) -a <(sort -k1,1 -k2,2n tmp_nonafr_1kg_Altai_hgdp.bed|pos2bed 50 |bedtools merge -c 6,6,6,6,7,7,7,7 -o count,count_distinct,distinct,collapse,count,count_distinct,distinct,collapse ) -v  >tmp_intersectV_Altai_hgdp.bed &
bedtools intersect -b <(sort -k1,1 -k2,2n tmp_afr_1kg_Vindija_hgdp.bed|pos2bed 50 |bedtools merge ) -a <(sort -k1,1 -k2,2n tmp_nonafr_1kg_Vindija_hgdp.bed |pos2bed 50 |bedtools merge -c 6,6,6,6,7,7,7,7 -o count,count_distinct,distinct,collapse,count,count_distinct,distinct,collapse ) -v  >tmp_intersectV_Vindija_hgdp.bed &
