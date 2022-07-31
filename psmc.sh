samtools mpileup -q 1 -C 50 -S -D -m 2 -F 0.002 -uf /gpfs/home/tuxl/project/20201101_tiger_WGS/01_ref/Tiger_VersionChr.genome.fa /gpfs/home/tuxl/project/20201101_tiger_WGS/05_psmc/bam/ptam_4.rmdup.bam | /gpfs/home/tuxl/software/samtools-0.1.19/bcftools/bcftools view -c - | /gpfs/home/tuxl/software/samtools-0.1.19/bcftools/vcfutils.pl  vcf2fq -d 4 -D 50 -Q 20 - > /gpfs/home/tuxl/project/20201101_tiger_WGS/05_psmc/v2/raw/ptam_4.psmc.fq; echo This-Work-is-Completed!
/gpfs/home/tuxl/software/psmc-master/utils/fq2psmcfa -q10 -s 100 /gpfs/home/tuxl/project/20201101_tiger_WGS/05_psmc/v2/raw/ptam_4.psmc.fq > /gpfs/home/tuxl/project/20201101_tiger_WGS/05_psmc/v2/raw/ptam_4.psmc.fa; echo This-Work-is-Completed!
####chr.list contain the autosome id with > at beginning, each one per line.
perl get_fasta.pl --i1 chr.list --i2 ptam_4.psmc.fa --o ptam_4.psmc.autosome.fa
/gpfs/home/tuxl/software/psmc-master/psmc -N30 -t15 -r5 -p 4+25*2+4+6 -o /gpfs/home/tuxl/project/20201101_tiger_WGS/05_psmc/v2/raw/ptam_4.psmc /gpfs/home/tuxl/project/20201101_tiger_WGS/05_psmc/v2/raw/ptam_4.psmc.autosome.fa; echo This-Work-is-Completed!
cd ~/project/20201101_tiger_WGS/05_psmc/v2/raw
#/gpfs/home/tuxl/software/psmc-master/utils/splitfa ptam_4.psmc.autosome.fa > split.ptam_4.psmc.fa
seq 100 | xargs -i echo /gpfs/home/tuxl/software/psmc-master/psmc -N30 -t15 -r5 -b -p "4+25*2+4+6" -o round-{}.ptam_4.psmc split.ptam_4.psmc.fa | sh
cat ptam_4.psmc round-*.ptam_4.psmc > combined.ptam_4.psmc
perl /gpfs/home/tuxl/software/psmc-master/utils/psmc_plot.pl -g 5 -u 3.5e-9 -p -M ptam_4  -T "PSMC Plot" ptam_4 combined.ptam_4.psmc