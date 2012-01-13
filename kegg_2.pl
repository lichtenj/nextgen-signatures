my $genelist = shift or die;
my $kegg_genes = shift or die;
my $kegg_pathways = shift or die;
my $org = shift or die;

if($org eq "mm9"){$org = "MMU"};
if($org eq "hg18"){$org = "HSA"};

my $gl;
my $pl;

my $db_pathway;
open(IN, $kegg_pathways);
while(my $rec = <IN>)
{
	chomp($rec);
	my @db = split(/\t/,$rec);
	$db[0] =~ s/path\://;
	if($db_pathway->{$db[0]})
	{
		$db_pathway->{$db[0]}++;
	}
	else
	{
		$db_pathway->{$db[0]} = 1;
	}
}
close IN;

open(IN, $genelist);
while(my $rec = <IN>)
{
	chomp($rec);
	$gl->{$rec} = 1;
}
close IN;

open(IN, $kegg_genes);
my @db_kegg = <IN>;
my $db = join("",@db_kegg);
@db_kegg = split(/\/\/\//, $db);
foreach my $entry (@db_kegg)
{
	if($entry =~ /$org/)
	{
		$entry =~ /($org\:\ [\w\_\(\)\ \-\t]+)\n/;
		my $gene = $1;
		foreach my $query (keys %$gl)
		{
			if($gene =~ /$query/)
			{
				my @tmp = ($entry =~ /(ko\d+[\w\ ]+)\n/);
				foreach my $pathway (@tmp)
				{
					$pathway =~ /(\w+)/;
					if($pl->{$1})
					{
						$pl->{$1}->{'Count'}++;
					}
					else
					{
						$pl->{$1}->{'Desc'} = $pathway;
						$pl->{$1}->{'Count'} = 1;
					}
				}
			}
		}
	}
}
close IN;

foreach my $pw (keys %$pl)
{
	print $pw."\t".$pl->{$pw}->{'Desc'}."\t".$org."\t".$pl->{$pw}->{'Count'}."\t".$db_pathway->{$pw}."\t".($pl->{$pw}->{'Count'} / $db_pathway->{$pw})."\n";
}
