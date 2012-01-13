my $genelist = shift or die;
my $ontologies = shift or die;

my $genes;

open(IN, $genelist);
while(my $rec = <IN>)
{
	chomp($rec);
	$genes->{$rec} = 1;
}
close IN;

my $ontology;
open(IN, $ontologies);
while(my $rec = <IN>)
{
	chomp($rec);
	my @fields = split(/\t/, $rec);
	if($genes->{$fields[2]})
	{
			$ontology->{$fields[4]}->{$fields[2]} = 1;
	}
}
close IN;

foreach my $onto (sort {$ontology->{$b} / scalar(keys %$genes) <=> $ontology->{$a} / scalar(keys %$genes)} keys %$ontology)
{
	print $onto."\t";
	print scalar(keys %{$ontology->{$onto}})."\t";
	print scalar(keys %$genes)."\t";
	print (scalar(keys %{$ontology->{$onto}}) / scalar(keys %$genes));
	print "\n";
}
