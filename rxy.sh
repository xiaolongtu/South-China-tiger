for i in {1..100}; do sort -R ptam.list  |head -n7 > $i.ptam;done
for i in {1..100}; do echo " perl get.Rxy.from.vcf.pl --vcf tiger_nocat.snp.onlyGT.eff.vcf.out --pop $i.ptam,ptsu.list --out $i.ptam-ptsu.out" >> run.sh;done
perl rxy.stal.pl ~/project/20201101_tiger_WGS/22.Rxy/ptam-ptsu rxy.xls