#!/usr/bin/perl -w
use strict;

my($vcf,$out)=@ARGV;
die "perl $0 <vcf> <out>\n" unless (@ARGV==2);
open OUT, ">$out.plink.sh";

if($vcf =~/\.gz$/){
	print OUT "vcftools --gzvcf $vcf --plink --out $out\n";
	print OUT "plink  --file $out --make-bed --out $out --allow-no-sex --allow-extra-chr\n";
	print OUT "plink --bfile $out --pca\n";
}
else{
	print OUT "vcftools --vcf $vcf --plink --out $out\n";
	print OUT "plink  --file $out --make-bed --out $out --allow-no-sex --allow-extra-chr\n";
	print OUT "plink  --bfile $out --pca\n";
}
close OUT;
