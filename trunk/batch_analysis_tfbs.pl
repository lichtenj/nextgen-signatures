use strict;

my $dir = shift or die;
my $cutoff = shift or die;
my $outdir = shift or die;

my $hash;

print "Compiling\n";

opendir(DH, $dir) || die "Cannot open $dir";
while(my $filename = readdir(DH)) 
{
	if($filename =~ m/\_MD\_/)
	{
		$filename =~ /([\_\w\.]+)\_MD\_/;
		print $filename."\t".$1."\n";
		$hash->{$1}->{$filename} = 1;
	}
}
closedir DH;

print "Analysis\n";

foreach my $entry (sort keys %$hash)
{
	print $entry."\n";

	my $statement = "cat ";
	foreach my $file (keys %{$hash->{$entry}})
	{
		$statement .= $dir.'/'.$file." ";
	}
	$statement .= '> '.$outdir.'/'.$entry.'_MD.csv';

	system($statement);

	my $sorting = 'sort -gr -t, -k8 '.$outdir.'/'.$entry.'_MD.csv > '.$outdir.'/'.$entry.'_SORTED.csv';
	system($sorting);

	system('rm '.$outdir.'/'.$entry.'_MD.csv');

	open(IN, $outdir.'/'.$entry.'_SORTED.csv') or die "Cannot open\n";
	open(OUT, '>'.$outdir.'/'.$entry.'_FILTERED.csv');
	my $words;
	print OUT "Word, S, ES, O, EO, OE, OlnOEO, SlnSES, P\n";
	while(my $record = <IN>)
	{
		$record =~ /^(\w+)\,/;
		my @tmp = split(/\,/, $record);
		if($tmp[7] eq "inf")
		{
			next;
		}
		my $check = $1;
		my $skip = 0;
		foreach my $word (keys %$words)
		{
			#print $word." vs ".$check."\n";
			if($word =~ /$check/)
			{
				$skip = 1;
				#print "Skipped: ".$record."\n";
				last;
			}
		}
		if($skip == 0)
		{
			$words->{$check} = $record;
			if($cutoff >= scalar(keys %$words))
			{
				print OUT $record;
			}
			else
			{
				last;
			}
		}
	}
	close OUT;
	close IN;

	system('rm '.$outdir.'/'.$entry.'_SORTED.csv');
#	system('cp '.$outdir.'/'.$entry.'_FILTERED.csv ~/Dropbox/MBD2_MD_Results/'.$entry.'_FILTERED.csv');
}
