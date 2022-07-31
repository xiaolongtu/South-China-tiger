vcftools  --gzvcf tiger_nocat.snp.onlyGT.vcf.gz --plink  --out tiger
plink --noweb --file tiger  --recode12 --allow-no-sex --allow-extra-chr
admixture --cv   plink.ped 1 &
admixture --cv   plink.ped 2 &
admixture --cv   plink.ped 3 &
admixture --cv   plink.ped 4 &
admixture --cv   plink.ped 5 &
admixture --cv   plink.ped 6 &
wait
