vcftools --vcf ~/project/20201101_tiger_WGS/13.Dsta/tiger.snp.onlyGT.noscaff.newname.recode.vcf --keep list --non-ref-ac 1 --recode --recode-INFO-all --out sub1
####f4-ratio
/gpfs/home/tuxl/software/Dsuite/Build/Dsuite Dtrios  sub1.recode.vcf  ind_map.txt -t tree.txt -o species
####f-branch estimate
/gpfs/home/tuxl/software/Dsuite/Build/Dsuite Fbranch -Z species.zmatrix tree.txt species__tree.txt  >  species.zbmatrix.txt
####plot picture
~/software/Dsuite/utils/dtools.py species.zbmatrix.txt tree.txt --outgroup Outgroup -n  species.fbmatrix
