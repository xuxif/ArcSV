sample=dan
sample=Altai
sample=Vindija
bcftools view  -i '(AFRICA_BantuKenya_AF="." | AFRICA_BantuKenya_AF<0.1) & (AFRICA_BantuSouthAfrica_AF="." | AFRICA_BantuSouthAfrica_AF<0.1) & (AFRICA_Biaka_AF="." | AFRICA_Biaka_AF<0.1) & (AFRICA_Mandenka_AF="." | AFRICA_Mandenka_AF<0.1) & (AFRICA_Mbuti_AF="." | AFRICA_Mbuti_AF<0.1) & (AFRICA_San_AF="." | AFRICA_San_AF<0.1) & (AFRICA_Yoruba_AF="." | AFRICA_Yoruba_AF<0.1) & (AFRICA_AF="." | AFRICA_AF<0.1)' share_${sample}_pop_count.vcf|bcftools view -H -i 'AMERICA_Colombian_AF>0.3 | AMERICA_Karitiana_AF>0.3 | AMERICA_Maya_AF>0.3 | AMERICA_Pima_AF>0.3 | AMERICA_Surui_AF>0.3 | CENTRAL_SOUTH_ASIA_Balochi_AF>0.3 | CENTRAL_SOUTH_ASIA_Brahui_AF>0.3 | CENTRAL_SOUTH_ASIA_Burusho_AF>0.3 | CENTRAL_SOUTH_ASIA_Hazara_AF>0.3 | CENTRAL_SOUTH_ASIA_Kalash_AF>0.3 | CENTRAL_SOUTH_ASIA_Makrani_AF>0.3 | CENTRAL_SOUTH_ASIA_Pathan_AF>0.3 | CENTRAL_SOUTH_ASIA_Sindhi_AF>0.3 | CENTRAL_SOUTH_ASIA_Uygur_AF>0.3 | EAST_ASIA_Cambodian_AF>0.3 | EAST_ASIA_Dai_AF>0.3 | EAST_ASIA_Daur_AF>0.3 | EAST_ASIA_Han_AF>0.3 | EAST_ASIA_Hezhen_AF>0.3 | EAST_ASIA_Japanese_AF>0.3 | EAST_ASIA_Lahu_AF>0.3 | EAST_ASIA_Miao_AF>0.3 | EAST_ASIA_Mongolian_AF>0.3 | EAST_ASIA_Naxi_AF>0.3 | EAST_ASIA_NorthernHan_AF>0.3 | EAST_ASIA_Oroqen_AF>0.3 | EAST_ASIA_She_AF>0.3 | EAST_ASIA_Tu_AF>0.3 | EAST_ASIA_Tujia_AF>0.3 | EAST_ASIA_Xibo_AF>0.3 | EAST_ASIA_Yakut_AF>0.3 | EAST_ASIA_Yi_AF>0.3 | EUROPE_Adygei_AF>0.3 | EUROPE_Basque_AF>0.3 | EUROPE_BergamoItalian_AF>0.3 | EUROPE_French_AF>0.3 | EUROPE_Orcadian_AF>0.3 | EUROPE_Russian_AF>0.3 | EUROPE_Sardinian_AF>0.3 | EUROPE_Tuscan_AF>0.3 | MIDDLE_EAST_Bedouin_AF>0.3 | MIDDLE_EAST_Druze_AF>0.3 | MIDDLE_EAST_Mozabite_AF>0.3 | MIDDLE_EAST_Palestinian_AF>0.3 | OCEANIA_Bougainville_AF>0.3 | OCEANIA_PapuanHighlands_AF>0.3 | OCEANIA_PapuanSepik_AF>0.3 | Adygei_AF>0.3 | AMERICA_AF>0.3 | Balochi_AF>0.3 | BantuKenya_AF>0.3 | BantuSouthAfrica_AF>0.3 | Basque_AF>0.3 | Bedouin_AF>0.3 | BergamoItalian_AF>0.3 | Biaka_AF>0.3 | Bougainville_AF>0.3 | Brahui_AF>0.3 | Burusho_AF>0.3 | Cambodian_AF>0.3 | CENTRAL_SOUTH_ASIA_AF>0.3 | Colombian_AF>0.3 | Dai_AF>0.3 | Daur_AF>0.3 | Druze_AF>0.3 | EAST_ASIA_AF>0.3 | EUROPE_AF>0.3 | French_AF>0.3 | Han_AF>0.3 | Hazara_AF>0.3 | Hezhen_AF>0.3 | Japanese_AF>0.3 | Kalash_AF>0.3 | Karitiana_AF>0.3 | Lahu_AF>0.3 | Makrani_AF>0.3 | Mandenka_AF>0.3 | Maya_AF>0.3 | Mbuti_AF>0.3 | Miao_AF>0.3 | MIDDLE_EAST_AF>0.3 | Mongolian_AF>0.3 | Mozabite_AF>0.3 | Naxi_AF>0.3 | NorthernHan_AF>0.3 | OCEANIA_AF>0.3 | Orcadian_AF>0.3 | Oroqen_AF>0.3 | Palestinian_AF>0.3 | PapuanHighlands_AF>0.3 | PapuanSepik_AF>0.3 | Pathan_AF>0.3 | Pima_AF>0.3 | Russian_AF>0.3 | San_AF>0.3 | Sardinian_AF>0.3 | She_AF>0.3 | Sindhi_AF>0.3 | Surui_AF>0.3 | Tu_AF>0.3 | Tujia_AF>0.3 | Tuscan_AF>0.3 | Uygur_AF>0.3 | Xibo_AF>0.3 | Yakut_AF>0.3 | Yi_AF>0.3 | Yoruba_AF>0.3' |cut -f1,2,8|while read chr pos info;do echo $info|perl -npe "s/;/\n/g"|grep "_AF="|perl -npe "s/_AF=/\t/"|sort -k2,2nr|grep -n "" |perl -npe "s/^/$chr\t$pos\t/";done
