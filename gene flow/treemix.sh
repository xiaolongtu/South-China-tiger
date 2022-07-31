#####build ML tree
vcftools  --gzvcf /gpfs/home/tuxl/project/20201101_tiger_WGS/00.vcf/tiger.snp.onlyGT.vcf.gz  --plink  --out  tiger
plink  --noweb --file tiger -make-bed --out tiger.step2
plink --bfile  tiger.step2 --freq   --within  clust.file
gzip plink.frq.strat
python /gpfs/home/tuxl/software/pip/popev/08.geneflow/treemix/plink2treemix.py  plink.frq.strat.gz  treemix.inputfile.gz
/gpfs/home/tuxl/software/pip/popev/08.geneflow/treemix/treemix -i treemix.inputfile.gz  -k 10000  -bootstrap -o out

######estimate gene flow 
cd ~/project/20201101_tiger_WGS/14.treemix/sub1
vcftools  --gzvcf /gpfs/home/tuxl/project/20201101_tiger_WGS/00.vcf/tiger.snp.onlyGT.vcf.gz --keep sub1.list --non-ref-ac 1 --recode --recode-INFO-all --out sub1
vcftools  --vcf /gpfs/home/tuxl/project/20201101_tiger_WGS/14.treemix/sub1/sub1.recode.vcf  --plink  --out  tiger
plink  --noweb --file tiger -make-bed --out tiger.step2
plink --bfile  tiger.step2 --freq   --within  sub1.clust.file
gzip plink.frq.strat
python /gpfs/home/tuxl/software/pip/popev/08.geneflow/treemix/plink2treemix.py  plink.frq.strat.gz  treemix.inputfile.gz
/gpfs/home/tuxl/software/pip/popev/08.geneflow/treemix/treemix -i treemix.inputfile.gz -k 10000  -o m1 -bootstrap -m 1  -g out.vertices.gz out.edges.gz  -tf tree.fig   -se  -root cat
/gpfs/home/tuxl/software/pip/popev/08.geneflow/treemix/treemix -i treemix.inputfile.gz -k 10000  -o m2 -bootstrap -m 2  -g out.vertices.gz out.edges.gz  -tf tree.fig   -se  -root cat
/gpfs/home/tuxl/software/pip/popev/08.geneflow/treemix/treemix -i treemix.inputfile.gz -k 10000  -o m3 -bootstrap -m 3  -g out.vertices.gz out.edges.gz  -tf tree.fig   -se  -root cat
/gpfs/home/tuxl/software/pip/popev/08.geneflow/treemix/treemix -i treemix.inputfile.gz -k 10000  -o m4 -bootstrap -m 4  -g out.vertices.gz out.edges.gz  -tf tree.fig   -se  -root cat
/gpfs/home/tuxl/software/pip/popev/08.geneflow/treemix/treemix -i treemix.inputfile.gz -k 10000  -o m5 -bootstrap -m 5  -g out.vertices.gz out.edges.gz  -tf tree.fig   -se  -root cat
