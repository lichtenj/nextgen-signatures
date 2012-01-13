use Parallel::ForkManager;

my $dir = shift or die;
my $seq = shift or die;
my $outdir = shift or die;

opendir(my $dh, $dir);

my @files = readdir $dh;
my $pm = Parallel::ForkManager->new(8);


foreach my $file (@files)
{
	$pm->start;

	if($file !~ /^\./)
	{
		my $sequence = $file;
		$sequence =~ s/\_FILTERED\.csv/\.fa/;

		#print $file."\t".$sequence."\n";

		#system("perl transfac_lookup.pl ".$dir."/".$file." Transfac_Binding_Sites_2010.3.csv tftemp".$file.".csv");
		system("perl transfac_lookup.pl ".$dir."/".$file." Transfac_Binding_Sites_2010.3_HumanMouse_Filtered.csv tftemp".$file.".csv");

		open(IN, "tftemp".$file.".csv") or die "Cannot open tftemp".$file.".csv";
		open(OUT, ">".$outdir."/".$file) or die "Cannot open ".$outdir."/".$file;

		while(my $record = <IN>)
		{
			if($record !~ /word/i)
			{
				my @tmp = split(/\,/, $record);
				my $cmd = 'grep -c '.$tmp[1].' '.$seq.'/'.$sequence;
				my $count = `$cmd`;
				if($count > 0)
				{
					print OUT $record;
				}
			}
			else
			{
				print OUT $record;
			}
		}
		close IN;
		close OUT;
	}
	$pm->finish;
}
closedir $dh;

$pm->wait_all_children;
