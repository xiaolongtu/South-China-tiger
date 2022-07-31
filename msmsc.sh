cd /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr
for i in {A1,C1,B1,A2,C2,B2,B3,B4,A3,D1,D4,D3,D2,F2,F1,E2,E1,E3}
do echo -e "iTools Fatools getSP -InFa /gpfs/home/tuxl/project/20201101_tiger_WGS/01_ref/Tiger_VersionChr.genome.fa -GetID $i -OutPut /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.fa
gunzip /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.fa.gz
/gpfs/home/tuxl/software/pip/popev/14.msmc/splitfa /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.fa 35 > /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.fa.kmer
~/software/bwa-0.7.17/bwa index /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.fa
~/software/bwa-0.7.17/bwa aln -O 3 -E 3 -t 10 /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.fa /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.fa.kmer > /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.sai
~/software/bwa-0.7.17/bwa samse -f /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.sam /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.fa /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.sai /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.fa.kmer
/gpfs/home/tuxl/software/pip/popev/14.msmc/gen_raw_mask.pl /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.sam > /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.rawMask_35.fa
/gpfs/home/tuxl/software/pip/popev/14.msmc/gen_mask -l 35 -r 0.5 /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.rawMask_35.fa > /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.mask_35_50.fa
python3 /gpfs/home/tuxl/software/pip/popev/14.msmc/makeMappabilityMask.py /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.mask_35_50.fa /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i
rm /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.fa.kmer /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.sam /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.rawMask_35.fa /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.mask_35_50.fa
">> chr.sh ; done
sh chr.sh 

for i in {A1,C1,B1,A2,C2,B2,B3,B4,A3,D1,D4,D3,D2,F2,F1,E2,E1,E3}
do echo -e "
###########vcf mask.bed
cd /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/hap2/ptal_1/$i
depth=\`~/software/samtools-0.1.19/samtools depth -r $i /gpfs/home/tuxl/project/20201101_tiger_WGS/01.BWA/bwa/ptal_1.rmdup.bam | awk '{sum += \$3} END {print sum / NR}'\`
~/software/samtools-0.1.19/samtools mpileup -q 20 -Q 20 -C 50 -u -r $i -f /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.fa /gpfs/home/tuxl/project/20201101_tiger_WGS/01.BWA/bwa/ptal_1.rmdup.bam | /gpfs/home/tuxl/software/samtools-0.1.19/bcftools/bcftools view -cgI - | python3 /gpfs/home/tuxl/software/msmc-tools-master/bamCaller.py $depth ptal_1-A1_mask.bed.gz |gzip -c  > ptal_1-A1.vcf.gz
###########input file
python3 /gpfs/home/tuxl/software/msmc-tools-master/generate_multihetsep.py --mask=ptal_1-A1_mask.bed.gz  --mask=/gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/chrA1.mask.bed.gz ptal_1-$i.vcf.gz > ptal_1-$i.input
" >> ptal_1.sh;done
sh ptal_1.sh

for i in {A1,C1,B1,A2,C2,B2,B3,B4,A3,D1,D4,D3,D2,F2,F1,E2,E1,E3}
do echo -e "
###########vcf mask.bed
cd /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/hap2/ptam_4/$i
depth=\`~/software/samtools-0.1.19/samtools depth -r $i /gpfs/home/tuxl/project/20201101_tiger_WGS/01.BWA/bwa/ptam_4.rmdup.bam | awk '{sum += \$3} END {print sum / NR}'\`
~/software/samtools-0.1.19/samtools mpileup -q 20 -Q 20 -C 50 -u -r $i -f /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/$i.fa /gpfs/home/tuxl/project/20201101_tiger_WGS/01.BWA/bwa/ptam_4.rmdup.bam | /gpfs/home/tuxl/software/samtools-0.1.19/bcftools/bcftools view -cgI - | python3 /gpfs/home/tuxl/software/msmc-tools-master/bamCaller.py $depth ptam_4-A1_mask.bed.gz |gzip -c  > ptam_4-A1.vcf.gz
###########input file
python3 /gpfs/home/tuxl/software/msmc-tools-master/generate_multihetsep.py --mask=ptam_4-A1_mask.bed.gz  --mask=/gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/chrA1.mask.bed.gz ptam_4-$i.vcf.gz > ptam_4-$i.input
" >> ptam_4.sh;done
sh ptam_4.sh

for i in {A1,C1,B1,A2,C2,B2,B3,B4,A3,D1,D4,D3,D2,F2,F1,E2,E1,E3}
do echo -e "
cd /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/hap8
python3 /gpfs/home/tuxl/software/msmc-tools-master/generate_multihetsep.py  --mask=/gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/hap2/ptal_1/$i/ptal_1-$i\_mask.bed.gz --mask=/gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/hap2/ptam_4/$i/ptam_4-$i\_mask.bed.gz --mask=/gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/chr/chr$i.mask.bed.gz  /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/hap2/ptal_1/$i/ptal_1-$i.vcf.gz  /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/hap2/ptam_4/$i/ptam_4-$i.vcf.gz  > /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/hap8/chr$i.input.txt
" >> multihetsep.sh;done
sh multihetsep.sh

cd /gpfs/home/tuxl/project/20201101_tiger_WGS/10.msmc/ptam-ptal/popsplit
/gpfs/home/tuxl/software/msmc2-master/build/release/msmc2 -I 0-1 -o ptal_1.msmc2_within1 chrA1.input.txt chrC1.input.txt chrB1.input.txt chrA2.input.txt chrC2.input.txt chrB2.input.txt chrB3.input.txt chrB4.input.txt chrA3.input.txt chrD1.input.txt chrD4.input.txt chrD3.input.txt chrD2.input.txt chrF2.input.txt chrF1.input.txt chrE2.input.txt chrE1.input.txt chrE3.input.txt
/gpfs/home/tuxl/software/msmc2-master/build/release/msmc2 -I 2-3 -o ptam_4.msmc2_within2 chrA1.input.txt chrC1.input.txt chrB1.input.txt chrA2.input.txt chrC2.input.txt chrB2.input.txt chrB3.input.txt chrB4.input.txt chrA3.input.txt chrD1.input.txt chrD4.input.txt chrD3.input.txt chrD2.input.txt chrF2.input.txt chrF1.input.txt chrE2.input.txt chrE1.input.txt chrE3.input.txt
/gpfs/home/tuxl/software/msmc2-master/build/release/msmc2 -I 0-2,0-3,1-2,1-3 -o ptal_1-ptam_4.msmc2_across chrA1.input.txt chrC1.input.txt chrB1.input.txt chrA2.input.txt chrC2.input.txt chrB2.input.txt chrB3.input.txt chrB4.input.txt chrA3.input.txt chrD1.input.txt chrD4.input.txt chrD3.input.txt chrD2.input.txt chrF2.input.txt chrF1.input.txt chrE2.input.txt chrE1.input.txt chrE3.input.txt
/gpfs/home/tuxl/software/msmc-tools-master/combineCrossCoal.py ptal_1-ptam_4.msmc2_across.final.txt ptal_1.msmc2_within1.final.txt ptam_4.msmc2_within2.final.txt  > combined12_msmc.final.txt

Rscript msmc.popsplit.R