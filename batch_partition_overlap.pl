use strict;

my $dir = shift or die;
my $org = shift or die;

my $hash;
my $partitions;
my $filters;
my $cells;

opendir(DIR, $dir);
while(my $file = readdir DIR)
{
	if($file =~ /^\./){next;}
	my $info = $file;
	$info =~ s/\.bed\.bed/\.bed/g;
	my @fields = split(/\.bed/,$info);
	if(!$fields[1])
	{
		$fields[1] = "complete";
	}
	if($fields[1] !~ /$org/)
	{
		$fields[2] = $fields[1];
		$fields[1] = "complete";
	}
	if(!$fields[2])
	{
		$fields[2] = "complete";
	}
	$cells->{$fields[0]} = 1;
	$partitions->{$fields[1]} = 1;
	$filters->{$fields[2]} = 1;

	$hash->{$fields[0]}->{$fields[1]}->{$fields[2]} = $dir.'/'.$file;
}
closedir DIR;

my $peakhash;
my $cdshash;
foreach my $cell (keys %$cells)
{
	foreach my $partition1 (keys %$partitions)
	{
		foreach my $partition2 (keys %$partitions)
		{
			if($partition1 ne $partition2 && $partition1 ne "complete" && $partition2 ne "complete")
			{
				#print $cell."\t".$partition1."\t".$partition2."\n";

				my $cmd = 'intersectBed -a '.$hash->{$cell}->{$partition1}->{'complete'}.' -b '.$hash->{$cell}->{$partition2}->{'complete'};
				my $res = `$cmd`;
				my @peaks = split(/\n/, $res);
				foreach my $peak (@peaks)
				{
					if($peakhash->{$cell}->{$peak} && $partition1 =~ /(10kb_to_1kb_upstream|10kb_downstream|1kbup_to_50bdown|RefSeq)/ && $partition2 =~ /(10kb_to_1kb_upstream|10kb_downstream|1kbup_to_50bdown|RefSeq)/)
					{
						$peakhash->{$cell}->{$peak}++;
					}
					else
					{
						if($partition1 =~ /(10kb_to_1kb_upstream|10kb_downstream|1kbup_to_50bdown|RefSeq)/ && $partition2 =~ /(10kb_to_1kb_upstream|10kb_downstream|1kbup_to_50bdown|RefSeq)/)
						{
							$peakhash->{$cell}->{$peak} = 1;
						}
					}

					if($cdshash->{$cell}->{$peak} && $partition1 =~ /(EXONS|INTRONS|3UTR|5UTR)/ && $partition2 =~ /(EXONS|INTRONS|3UTR|5UTR)/)
					{
						$cdshash->{$cell}->{$peak}++;
					}
					else
					{
						if($partition1 =~ /(EXONS|INTRONS|3UTR|5UTR)/ && $partition2 =~ /(EXONS|INTRONS|3UTR|5UTR)/)
						{
							$cdshash->{$cell}->{$peak} = 1;
						}
					}
				}
			}
		}
	}
}

print "Cell Type\tGeneral Overlap\tCDS Overlap\n";
foreach my $cell (keys %$peakhash)
{
	print $cell."\t".scalar(keys %{$peakhash->{$cell}})."\t".scalar(keys %{$cdshash->{$cell}})."\n";
}
