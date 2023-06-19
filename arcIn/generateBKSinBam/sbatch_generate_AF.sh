#!/bin/bash
#SBATCH -J N1
#SBATCH -N 1
#SBATCH -n 32
#SBATCH -e log_err_N1.1txt
#SBATCH -o log_out_N1.txt
#SBATCH -p normal
cd /public/home/xuxf/arcIn/generateBKSinBam/BKsArcInBAM
#ls ~/1kGP/HGDP*.cram|sed -n 'N1,N2p' |xargs -n 1 -P 6 -I{} bash order.sh {}
echo -ne "dan\nAltai\nVindija\n"|while read arc;do
	cat ../sample_info_1kGP.txt |perl -F'\t' -alne 'print "$F[0]\t$F[2]\t$F[1]";'|grep -v "HGDP" |perl -npe "s/^(.*?\t)/\1$arc\t/"
done |sed -n 'N1,N2p' |xargs -n 1 -P 20  bash ../generate_AF_share_getGT_1kGP.sh
#ls 1kGP_bam/*.cram|grep -v "HGDP" |sed -n 'N1,N2p' |xargs -n 1 -P 4 -I{} bash order.sh {}
#ls 1kGP_bam/*.cram|grep -v "HGDP" |sed -n 'N1,N2p' |xargs -n 1 -P 4 -I{} bash order.sh {}
#comm -23 <(ls  /public/share/wchirdzhq2022/20230130/1kGP_0731/*.cram|perl -npe "s/.*\///;s/\..*//"|sort ) <(ls BKSinBAM/|perl -npe "s/\.tsv//"|sort) |perl -npe "s/^/\/public\/share\/wchirdzhq2022\/20230130\/1kGP_0731\//;s/$/\.final\.cram/"|sed -n 'N1,N2p' |xargs -n 1 -P 2 -I{} bash order.sh {}
#cat fail_list.txt |sort |uniq |perl -npe "s/^/\/public\/share\/wchirdzhq2022\/20230130\/1kGP_0731\//;s/$/\.final\.cram/"|sed -n 'N1,N2p' |xargs -n 1 -P 2 -I{} bash order.sh {}
#cat tmp.txt |perl -npe "s/.*\///"|grep "HGDP"|perl -npe "s/_.*//"|sort |uniq |while read id;do ls ~/1kGP/*$id*.cram;done |sed -n 'N1p' |xargs -n 1 -P 1 -I{} bash order.sh {}
#ls ~/region_bam_sort/*|grep "bam$" |sed -n 'N1p' |xargs -n 1 -P 1 -I{} bash order.sh {}
