my $genelist = shift or die;
my $allgenes = shift or die;
my $org = shift or die;

my $hash;
open(IN, $allgenes) or die "Cannot open $allgenes";
while(my $rec = <IN>)
{
	chomp($rec);
	my @fields = split(/\t/,$rec);
	$hash->{$fields[0]} = $fields[2];
}
close IN;

my $chrs;
open(IN, $genelist) or die "Cannot open $genelist";
while(my $rec = <IN>)
{
	chomp($rec);
	if(!$hash->{$rec}){next;}
	$chrs->{$hash->{$rec}}->{$rec} = 1;
}
close IN;

my @chrom;

if($org eq 'hg18')
{
	@chrom = ("chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10","chr11","chr12","chr13","chr14","chr15","chr16","chr17","chr18","chr19","chr20", "chr21","chrX","chrY");
}
elsif($org eq 'mm9')
{
	@chrom = ("chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10","chr11","chr12","chr13","chr14","chr15","chr16","chr17","chr18","chr19","chrX","chrY");
}
else
{
	print "Unsupported Organism in Chromosomal Breakdown\n";
	exit;
}

$genelist =~ s/\.bed\.bed/\.bed/g;
my @info = split(/\.bed/, $genelist);
$info[0] =~ s/\w*\///g;

print $info[0]."\t".$info[1]."\t".$info[2]."\t";

foreach my $chr (@chrom)
{
	print scalar(keys %{$chrs->{$chr}})."\t";
}
print "\n";
