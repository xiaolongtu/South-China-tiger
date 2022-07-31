#!/usr/bin/perl
use warnings;
my($vcf,$anno,$out)=@ARGV;
die"perl $0 vcf  anno  out\n" unless($vcf && $anno && $out);

if($vcf=~/gz$/)
{
	open VCF, "zcat $vcf|" || die $!;
}
else{
	open VCF, "$vcf"||die"$!";
}
open GENE," $anno" or die"$!\n";
open OUT,">$out" or die"$!\n";
my (%anno,%vcf);
while(<GENE>)
{
	chomp;
	my @arry=split/\s+/,$_;
	my $id=join("-",$arry[4],$arry[5]);
	$anno{$id}=$_;
}
while(<VCF>)
{
	chomp;
	next if(/^##/);
	if(/^#CH/)
	{
		print OUT "$_\n" ;
		next;
	}
  	my @set=split/\s+/,$_;
	my $id=join("-",$set[0],$set[1]);
	if(exists $anno{$id}){
		print OUT $_."\n";
	}
}
	
close VCF;
close GENE;
close OUT;
