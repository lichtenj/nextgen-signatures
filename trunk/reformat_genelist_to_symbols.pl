use strict;

my $file = shift or die;
my $autosomes = shift;

my $hash;
open(IN, $file);
while(my $rec = <IN>)
{
	chomp($rec);
	my @field = split(/\t/,$rec);

	if($field[0] =~ /chr[XY]/ && $autosomes eq "-autosomes")
	{
		next;
	}

	my @gene = split(/\:/,$field[6]);
	if($gene[0] !~ /mir\d+/i)
	{
		$hash->{$gene[0]} = 1;
	}
}
close IN;

open(OUT, ">$file");
foreach my $gene (keys %$hash)
{
	print OUT $gene."\n";
}
close OUT;
