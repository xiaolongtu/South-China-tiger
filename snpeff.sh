perl  ~/software/pip/popev/13.annovar/convert2annovar.pl -format vcf4 -snpqual 0 tiger_nocat.snp.onlyGT.vcf > tiger_nocat.snp.onlyGT.vcf.avinput
perl  ~/software/pip/popev/13.annovar/annotate_variation.pl -buildver tiger -geneanno  tiger_nocat.snp.onlyGT.vcf.avinput ~/project/20201101_tiger_WGS/01_ref/
grep 'exonic' tiger_nocat.snp.onlyGT.vcf.avinput.variant_function > tiger_nocat.snp.onlyGT.vcf.avinput.variant_function.exonic
perl /gpfs/home/tuxl/software/pip/popev/13.annovar/getvcf4exonic_variant_function.pl tiger_nocat.snp.onlyGT.vcf tiger_nocat.snp.onlyGT.vcf.avinput.variant_function.exonic tiger_nocat.snp.onlyGT.vcf.avinput.variant_function.exonic.vcf
java -jar ~/software/snpEff/snpEff.jar  -c ~/software/snpEff/snpEff.config -ud 1  tiger tiger_nocat.snp.onlyGT.vcf.avinput.variant_function.exonic.vcf > tiger_nocat.snp.onlyGT.eff.vcf
