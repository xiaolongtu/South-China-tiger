#!/usr/bin/perl

my ($indir,$outfile)=@ARGV;
die "perl $0 <indir> <outfile>\n" unless(@ARGV==2);
my @set = glob "$indir/*.out";
my %hash;
open OUT, ">$outfile";
foreach my $file (@set){
  open IN,"$file";
  while(<IN>)
  {
    chomp;
    next if(/type/);
    my @set=split/\s+/,$_;
    $hash{$set[0]}.="$set[1]\n";
  }
}
foreach my $key (keys %hash){
print OUT "$key\n$hash{$key}";
}
close IN;
close OUT;
