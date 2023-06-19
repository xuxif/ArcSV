#ac=Vindija;cat ~/hgdp_SV_vcf/sample.info |tail --lines=+2|cut -f1,7,8|grep "HGDP" |while read sample subpop pop;do bash ../generate_AF_share_getGT.sh $sample $ac $subpop $pop;echo $sample;done ;ac=dan;cat ~/hgdp_SV_vcf/sample.info |tail --lines=+2|cut -f1,7,8|grep "HGDP" |while read sample subpop pop;do bash ../generate_AF_share_getGT.sh $sample $ac $subpop $pop;echo $sample;done ;ac=Altai;cat ~/hgdp_SV_vcf/sample.info |tail --lines=+2|cut -f1,7,8|grep "HGDP" |while read sample subpop pop;do bash ../generate_AF_share_getGT.sh $sample $ac $subpop $pop;echo $sample;done

echo -ne "dan\nAltai\nVindija\n"|while read arc;do
	cat ~/hgdp_SV_vcf/sample.info |tail --lines=+2|cut -f1,7,8|grep "HGDP" |perl -npe "s/^(.*?\t)/\1$arc\t/"|xargs -n 4 -P 40  bash ../generate_AF_share_getGT.sh 
done

echo -ne "dan\nAltai\nVindija\n"|while read arc;do
	bcftools merge -0 -i `cat head.vcf |grep "INFO"|perl -npe "s/.*ID=//;s/,.*//"|sort |uniq |grep -E "AC$|AN$"|grep -Ev "^AC$|^AN$"|perl -npe "s/$/:sum/" |perl -npe "s/\n/,/"|perl -npe "s/$/evidence_mod:max,evidence_arc:max\n/"` `ls HGDP*_${arc}_hg38.vcf.gz|perl -npe "s/\n/ /"|perl -npe "s/$/\n/" ` |perl -npe "s/\t(\w+_AC=\d+;)/\t;\1/" |perl -npe "`cat <(cat ~/hgdp_SV_vcf/sample.info |tail --lines=+2|cut -f1,7,8 |cut -f2,3|sort |uniq -c|perl -npe "s/^ +//;s/ +/\t/g"|while read count subpop pop ;do echo -ne "s/;(${subpop}_AC=\d+);/;${pop}_\1;${pop}_${subpop}_AN=$count;/g;";done ) <(cat ~/hgdp_SV_vcf/sample.info |tail --lines=+2|cut -f1,7,8 |cut -f2,3|perl -npe "s/\t/\n/g"|sort |uniq -c|perl -npe "s/^ +//;s/ +/\t/g"|while read count pop ;do echo -ne "s/;(${pop}_AC=\d+);/;\1;${pop}_AN=$count;/g;";done ) |perl -npe "s/\n$//" |perl -npe "s/$/\n/;"`"|perl -npe "s/\t;(\w+_AC=)/\t\1/" |perl -F'\t' -alne '$info=$F[7];$info=~s/(\w+AC=\d+);\w+AN=/\1:/g;$info=~s/;A[CN]=\d+//g;@field=split(/;/,$info);$out="";foreach $i (@field) {$ac=$i;$ac=~s/(.*)_AC=(\d+):.*/$2/;$name=$i;$name=~s/_AC.*//;$an=$i;$an=~s/.*://;$an=$an*2;$af=0;if($an>0) {$af=$ac/$an;} $out=$out."${name}_AC=$ac;${name}_AN=$an;${name}_AF=$af;";};$F[7]=$out;print join("\t",@F) ' |perl -npe "s/(;evidence_arc=\d+)+/\1/g;s/(;evidence_mod=\d+)+/\1/g;"|bcftools view -Oz >../share_HGDP_${arc}_pop_count.vcf.gz &
done
wait
echo -ne "dan\nAltai\nVindija\n"|while read arc;do
	bcftools index ../share_HGDP_${arc}_pop_count.vcf.gz &
done

#paste <(seq 1 320 9560) <(seq 320 320 9610) |while read n1 n2;do cat sbatch_generate_AF.sh |perl -npe "s/N1/$n1/g;s/N2/$n2/g" >jobs_script/order_${n1}.sh;done
ls jobs_script/order*.sh|while read file;do sbatch $file;done 
#ac=dan;    cat ../sample_info_1kGP.txt |perl -F'\t' -alne 'print "$F[0]\t$F[2]\t$F[1]";'|grep -v "HGDP" |while read sample subpop pop;do bash ../generate_AF_share_getGT_1kGP.sh $sample $ac $subpop $pop;echo $sample;done 

echo -ne "dan\nAltai\nVindija\n"|while read arc;do
	cat ../sample_info_1kGP.txt |perl -F'\t' -alne 'print "$F[0]\t$F[2]\t$F[1]";'|grep -v "HGDP" |perl -npe "s/^(.*?\t)/\1$arc\t/"|xargs -n 4 -P 40  bash ../generate_AF_share_getGT_1kGP.sh 
done
#ac=dan;    cat ../sample_info_1kGP.txt |perl -F'\t' -alne 'print "$F[0]\t$F[2]\t$F[1]";'|grep -v "HGDP" |while read sample subpop pop;do bash ../generate_AF_share_getGT_1kGP.sh $sample $ac $subpop $pop;echo $sample;done 
#ac=Altai;  cat ../sample_info_1kGP.txt |perl -F'\t' -alne 'print "$F[0]\t$F[2]\t$F[1]";'|grep -v "HGDP" |while read sample subpop pop;do bash ../generate_AF_share_getGT_1kGP.sh $sample $ac $subpop $pop;echo $sample;done

echo -ne "dan\nAltai\nVindija\n"|while read arc;do
	bcftools merge -0 -i `cat head.vcf |grep "INFO"|perl -npe "s/.*ID=//;s/,.*//"|sort |uniq |grep -E "AC$|AN$"|grep -Ev "^AC$|^AN$"|perl -npe "s/$/:sum/" |perl -npe "s/\n/,/"|perl -npe "s/$/evidenceMod:max,evidenceArc:max\n/"` `ls |grep -v "HGDP"|grep "_${arc}_hg38.vcf.gz$" |perl -npe "s/\n/ /"|perl -npe "s/$/\n/" ` |perl -npe "s/\t(\w+_AC=\d+;)/\t;\1/" |perl -npe "`cat <(cat ../sample_info_1kGP.txt |perl -F'\t' -alne 'print "$F[0]\t$F[2]\t$F[1]";' |cut -f2,3|sort |uniq -c|perl -npe "s/^ +//;s/ +/\t/g"|while read count subpop pop ;do echo -ne "s/;(${subpop}_AC=\d+);/;${pop}_\1;${pop}_${subpop}_AN=$count;/g;";done ) <(cat ../sample_info_1kGP.txt |perl -F'\t' -alne 'print "$F[0]\t$F[2]\t$F[1]";' |cut -f2,3|perl -npe "s/\t/\n/g"|sort |uniq -c|perl -npe "s/^ +//;s/ +/\t/g"|while read count pop ;do echo -ne "s/;(${pop}_AC=\d+);/;\1;${pop}_AN=$count;/g;";done ) |perl -npe "s/\n$//" |perl -npe "s/$/\n/;"`"|perl -npe "s/\t;(\w+_AC=)/\t\1/" |perl -F'\t' -alne '$info=$F[7];$info=~s/(\w+AC=\d+);\w+AN=/\1:/g;$info=~s/;A[CN]=\d+//g;@field=split(/;/,$info);$out="";foreach $i (@field) {$ac=$i;$ac=~s/(.*)_AC=(\d+):.*/$2/;$name=$i;$name=~s/_AC.*//;$an=$i;$an=~s/.*://;$an=$an*2;$af=0;if($an>0) {$af=$ac/$an;};$out=$out."${name}_AC=$ac;${name}_AN=$an;${name}_AF=$af;";};$F[7]=$out;print join("\t",@F) '|perl -npe "s/(;evidenceArc=\d+)+/\1/g;s/(;evidenceMod=\d+)+/\1/g;"  |bcftools view -Oz >../share_1kGP_${arc}_pop_count.vcf.gz &
done
wait
echo -ne "dan\nAltai\nVindija\n"|while read arc;do
	bcftools index ../share_1kGP_${arc}_pop_count.vcf.gz &
done
