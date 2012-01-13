my $dir = shift or die;
my $org = shift or die;

my $hash;

opendir(DIR, $dir);
while(my $filename = readdir(DIR))
{
	if($filename !~ m/^\./)
	{
#		print $filename."\t";
		$filename =~ /([\w]+)\.bed/;

		my $cell = $1;
#		print $cell."\t";

		$filename =~ /\.bed\_([\w]+)\.bed\.bed/;
		my $part = $1;
		if($part eq $cell){$part = 'blank';}
		if($part !~ /^$org/){$part = 'blank';}
#		print $part."\t";

		$filename =~ /\.bed\.bed\_([\w]+)\.bed\.bed/;
		my $filter = $1;
		if($filter eq $part){$filter = 'blank';}
		if($filter eq $cell){$filter = 'blank';}
#		print $filter."\n";
		
#		system("grep -c \'>\' ".$dir.$filename);
		my $tmp = "wc -l ".$dir.$filename;
		my $res = `$tmp`;

		$res =~ s/^\s+//;
		$res =~ s/\s+/\t/g;

		my @fields = split(/\t/, $res);		

		$hash->{$cell}->{$part}->{$filter}->{'Value'} = $fields[0];
	}
}
closedir DIR;

#foreach my $cell (sort {$a cmp $b} keys %$hash)
#{
#	print "Cell Type\t";
#	foreach my $part (sort {$a cmp $b} keys %{$hash->{$cell}})
#	{
#		print "Partition\t";
#		foreach my $filter (sort {$a cmp $b} keys %{$hash->{$cell}->{$part}})
#		{
#			print $filter."\t";
#		}
#		print "\n";
#		last;
#	}
#	last;
#}

foreach my $cell (sort {$a cmp $b} keys %$hash)
{
	foreach my $part (sort {$a cmp $b} keys %{$hash->{$cell}})
	{
		foreach my $filter (sort {$a cmp $b} keys %{$hash->{$cell}->{$part}})
		{
			print $cell."\t".$part."\t".$filter."\t".$hash->{$cell}->{$part}->{$filter}->{'Value'}."\n";
		}
	}
}
