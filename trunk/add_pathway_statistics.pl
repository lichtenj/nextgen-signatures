my $file = shift or die;
my $genelist = shift or die;

my $genes = `wc -l $genelist`;
$genes =~ s/^\s*(\d+)//;
my $n = $1;

open(IN, $file);
while(my $rec = <IN>)
{
	chomp($rec);
	my @fields = split(/\t/,$rec);
	my $x = $fields[3];
	my $M = $fields[4];
	my $N = 28404;

	if($x > 0 && $M > 0)
	{
		my $cmd = 'perl hypergeometric.pl '.$M.' '.$N.' '.$n.' '.$x;
		my $probs = `$cmd`;
		chomp($probs);
		print $rec."\t".$probs."\n";
	}
	else
	{
		print $rec."\t\t\n";
	}
}
close IN;
