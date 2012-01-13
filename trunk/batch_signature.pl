use strict;

my $dir = shift or die;
my $sigout = shift or die;
my $seqdir = shift or die;
my $org = shift or die;
my $sig_profile = shift or die;
my $exclude = shift;
my $pretty_order = shift;

my $exclusion;
if($exclude)
{
	open(EX, $exclude);
	while(my $rec = <EX>)
	{
		chomp($rec);
		$exclusion->{$rec} = 1;
	}
	close EX;
}

my @order;
my $cell_include;
if($pretty_order)
{
	open(PO, $pretty_order);
	while(my $rec = <PO>)
	{
		chomp($rec);
		push(@order, $rec);
		$cell_include->{$rec} = 1;
	}
	close PO;
}

my $cells;
my $partitions;
my $filters;
my $signatures;

if (! -d $sigout.'/Cell'){system('mkdir '.$sigout.'/Cell');}
if (! -d $sigout.'/Partition'){system('mkdir '.$sigout.'/Partition');}
if (! -d $sigout.'/Filter'){system('mkdir '.$sigout.'/Filter');}

my $maximum = 0;
opendir(DIR, $dir);
while(my $filename = readdir(DIR))
{
	if($filename !~ m/^\./)
	{
		$filename =~ /([\w]+)\.bed/;
		my $cell = $1;

		if(! $cell_include->{$cell}){next;}

		$filename =~ /\.bed\_([\w]+)\.bed\.bed/;
		my $part = $1;
		if($part eq $cell){$part = 'none';}
		if($part !~ /^$org/){$part = 'none';}
		if(!$part){$part = 'none';}

		$filename =~ /\.bed\.bed\_([\w]+)\.bed\.bed\_FILTERED/;
		my $filter = $1;
		if($filter eq $part){$filter = 'none';}
		if($filter eq $cell){$filter = 'none';}
		if(!$filter){$filter = 'none';}

		$partitions->{$part} = 1;
		$filters->{$filter} = 1;
		$cells->{$cell} = 1;

		open(IN, $dir.'/'.$filename);
		my $header = <IN>;
		while(my $rec = <IN>)
		{
			chomp($rec);
			my @tf = split(/\,/, $rec);
			if(!$exclude || ($exclude && ! $exclusion->{$tf[0]}))
			{
#				print $tf[0]."\t".$filename."\t".$cell."\t".$part."\t".$filter."\n";
				$signatures->{$tf[0]}->{$cell}->{$part}->{$filter} = 1;
#				$signatures->{$tf[0]}->{$cell}->{$part}->{$filter} = $tf[9];
#				if($maximum < $tf[9]){$maximum = $tf[9];}
			}
		}
		close IN;
	}
}
closedir DH;

#Cell Type Specific
foreach my $filter (keys %$filters)
{
	foreach my $part (keys %$partitions)
	{
		open(OUT, ">TMP.tsv");
		
		print OUT "Cells\t";
		foreach my $tf (sort keys %$signatures)
		{
			print OUT $tf."\t";
		}
		print OUT "\n";
		my @cell_order;
		if(@order)
		{
			@cell_order = @order;
		}
		else
		{
			@cell_order = sort keys %$cells;
		}

		foreach my $cell (@cell_order)
		{
			print OUT $cell."\t";
			foreach my $tf (sort keys %$signatures)
			{
				if($signatures->{$tf}->{$cell}->{$part}->{$filter})
				{
					#print OUT ($signatures->{$tf}->{$cell}->{$part}->{$filter} / $maximum)."\t";
					#print OUT $signatures->{$tf}->{$cell}->{$part}->{$filter}."\t";
					my $count = 0;
					foreach my $cell_count (keys %{$signatures->{$tf}})
					{
						if($signatures->{$tf}->{$cell_count}->{$part}->{$filter})
						{
							$count++;
						}
					}
#					if($tf =~ /GABPALPHA/)
#					{
#						print $tf."\t".$cell."\t".$part."\t".$filter."\t".$count."\n";
#					}
					print OUT (scalar(keys %$cells) / $count)."\t";
				}
				else
				{
					print OUT "\t";
				}
			}
			print OUT "\n";
		}
		#system('matrix2png -data TMP.tsv -range 0:1 -size 10:10 -s -d -r -c -title "'.$part.' ('.$filter.')" > '.$sigout.'/Cell/'.$filter.'_'.$part.'.png');
		#system('matrix2png -data TMP.tsv -size 10:10 -s -d -r -c -title "'.$part.' ('.$filter.')" > '.$sigout.'/Cell/'.$filter.'_'.$part.'.png');
		#system('matrix2png -data TMP.tsv -range 1:'.(scalar(keys %$cells)).' -size 10:10 -s -d -r -c -title "'.$part.' ('.$filter.')" > '.$sigout.'/Cell/'.$filter.'_'.$part.'.png');
		system('matrix2png -data TMP.tsv -mincolor blue -maxcolor red -midcolor green -range 1:'.(scalar(keys %$cells)).' -size 10:10 -s -d -r -c -title "'.$part.' ('.$filter.')" > '.$sigout.'/Cell/'.$filter.'_'.$part.'.png');
	}
}

#Partition Specific
foreach my $filter (keys %$filters)
{
	foreach my $cell (keys %$cells)
	{
		open(OUT, ">TMP.tsv");
		
		print OUT "Partitions\t";
		foreach my $tf (keys %$signatures)
		{
			print OUT $tf."\t";
		}
		print OUT "\n";
		foreach my $part (sort keys %$partitions)
		{
			print OUT $part."\t";
			foreach my $tf (sort keys %$signatures)
			{
				if($signatures->{$tf}->{$cell}->{$part}->{$filter})
				{
					#print OUT ($signatures->{$tf}->{$cell}->{$part}->{$filter} / $maximum)."\t";
					#print OUT $signatures->{$tf}->{$cell}->{$part}->{$filter}."\t";
					my $count = 0;
					foreach my $part_count (keys %{$signatures->{$tf}->{$cell}})
					{
						if($signatures->{$tf}->{$cell}->{$part_count}->{$filter})
						{
							$count++;
						}
					}
					print OUT (scalar(keys %$partitions) / $count)."\t";
				}
				else
				{
					print OUT "\t";
				}
			}
			print OUT "\n";
		}
		#system('matrix2png -data TMP.tsv -range 0:1 -size 10:10 -s -d -r -c -title "'.$cell.' ('.$filter.')" > '.$sigout.'/Partition/'.$filter.'_'.$cell.'.png');
		#system('matrix2png -data TMP.tsv -size 10:10 -s -d -r -c -title "'.$cell.' ('.$filter.')" > '.$sigout.'/Partition/'.$filter.'_'.$cell.'.png');
		#system('matrix2png -data TMP.tsv -range 1:'.(scalar(keys %$partitions)).' -size 10:10 -s -d -r -c -title "'.$cell.' ('.$filter.')" > '.$sigout.'/Partition/'.$filter.'_'.$cell.'.png');
		system('matrix2png -data TMP.tsv -mincolor blue -maxcolor red -midcolor green -range 1:'.(scalar(keys %$partitions)).' -size 10:10 -s -d -r -c -title "'.$cell.' ('.$filter.')" > '.$sigout.'/Partition/'.$filter.'_'.$cell.'.png');
	}
}

#Filter Specific
foreach my $part (keys %$partitions)
{
	foreach my $cell (keys %$cells)
	{
		open(OUT, ">TMP.tsv");
		
		print OUT "Filters\t";
		foreach my $tf (keys %$signatures)
		{
			print OUT $tf."\t";
		}
		print OUT "\n";
		foreach my $filter (sort keys %$filters)
		{
			print OUT $filter."\t";
			foreach my $tf (sort keys %$signatures)
			{
				if($signatures->{$tf}->{$cell}->{$part}->{$filter})
				{
					#print OUT ($signatures->{$tf}->{$cell}->{$part}->{$filter} / $maximum)."\t";
					#print OUT $signatures->{$tf}->{$cell}->{$part}->{$filter}."\t";
					my $count = 0;
					foreach my $filter_count (keys %{$signatures->{$tf}->{$cell}->{$part}})
					{
						if($signatures->{$tf}->{$cell}->{$part}->{$filter_count})
						{
							$count++;
						}
					}
					print OUT (scalar(keys %$filters) / $count)."\t";
				}
				else
				{
					print OUT "\t";
				}
			}
			print OUT "\n";
		}
		#system('matrix2png -data TMP.tsv -range 0:1 -size 10:10 -s -d -r -c -title "'.$cell.' ('.$part.')" > '.$sigout.'/Filter/'.$part.'_'.$cell.'.png');
		#system('matrix2png -data TMP.tsv -size 10:10 -s -d -r -c -title "'.$cell.' ('.$part.')" > '.$sigout.'/Filter/'.$part.'_'.$cell.'.png');
		#system('matrix2png -data TMP.tsv -range 1:'.(scalar(keys %$filters)).' -size 10:10 -s -d -r -c -title "'.$cell.' ('.$part.')" > '.$sigout.'/Filter/'.$part.'_'.$cell.'.png');
		system('matrix2png -data TMP.tsv -mincolor blue -maxcolor red -midcolor green -range 1:'.(scalar(keys %$filters)).' -size 10:10 -s -d -r -c -title "'.$cell.' ('.$part.')" > '.$sigout.'/Filter/'.$part.'_'.$cell.'.png');
	}
}

#Cell Type Specific
my $allowed_sigs;
open(SIG, $sig_profile);
while(my $sig = <SIG>)
{
	chomp($sig);
	$allowed_sigs->{$sig} = 1;
}
close SIG;

my $final_signatures;
foreach my $filter (keys %$filters)
{
	foreach my $part (keys %$partitions)
	{
		foreach my $tf (keys %$signatures)
		{
			my $bool = 0;
			my $header = $filter."\t".$part."\t".$tf."\t";
			my $signature = "";
			foreach my $cell (sort keys %{$signatures->{$tf}})
			{
				if($signatures->{$tf}->{$cell}->{$part}->{$filter})
				{
					$bool = 1;
					$signature .= $cell."\t";
				}
			}
			if($bool == 1)
			{
				$signature =~ s/\t$//;
				if($allowed_sigs->{$signature})
				{
					#print $header.$signature."\n";
					$final_signatures->{$signature}->{$part}->{$filter}->{$tf} = 1;
				}
			}
		}
	}
}

open(OUT, ">".$sigout.'/Signatures.tsv');
foreach my $sig (keys %$final_signatures)
{
	foreach my $part (keys %{$final_signatures->{$sig}})
	{
		foreach my $filter (keys %{$final_signatures->{$sig}->{$part}})
		{
			my $pretty = $sig;
			$pretty =~ s/\t/\ /g;
			my $tfs = "";
			foreach my $tf (keys %{$final_signatures->{$sig}->{$part}->{$filter}})
			{
				$tfs .= $tf."\t";
			}
			$tfs =~ s/\t$//;
			print OUT $pretty."\t".$part."\t".$filter."\t".$tfs."\n";
		}
	}
}
close OUT;
