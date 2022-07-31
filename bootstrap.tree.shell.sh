for i in {1..100}; do echo ~/software/VCF2Dis-master/bin/VCF2Dis -InPut tiger.snp.onlyGT.vcf.gz -OutPut p_dis_$i.mat -Rand 0.25 >> step1.sh;done
sh step1.sh
for i in {1..100}; do echo -e "sed '1d' p_dis_$i.mat > p_dis_$i.mat.bak\nRscript tree.r p_dis_$i.mat.bak p_dis_$i.mat.tre" >> step2.ape.sh;done
sh step2.ape.sh
cat *.tre >   ALLtree_merge.tre
PHYLIPNEW-3.69.650/bin/fconsense   -intreefile   ALLtree_merge.tre  -outfile out  -treeprint Y
perl VCF2Dis-master/bin/percentageboostrapTree.pl alltree_merge.treefile 100 boostrap.tre
