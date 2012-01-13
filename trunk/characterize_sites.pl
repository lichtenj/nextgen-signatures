use strict;
use Bio::SeqIO;
use Math::Round;

my $file = shift or die;
my $cutoff = shift or die;
my $output = shift or die;

my $site_hash;
my $in  = Bio::SeqIO->new(-file => $file , -format => 'Fasta');

my $max = 0;
my $avg = 0;
my $cases = 0;
my $min = 0;

while (my $seq = $in->next_seq())
{
	my @sites = ($seq->seq() =~ /(CG)/gi);
	my $no_sites = scalar(@sites);
	#print $seq->id()."\t".$no_sites."\n";
	if($no_sites > 0)
	{
		if($site_hash->{$no_sites})
		{
			$site_hash->{$no_sites}++;
		}
		else
		{
			$site_hash->{$no_sites} = 1;
		}
	
		$min = $no_sites;
		$cases++;
		$avg += $no_sites;
	}
	if($no_sites > $max)
	{
		$max = $no_sites;
	}
}

$avg = $avg / $cases;

open(OUT, ">".$output."temp_distro");
foreach my $site (sort {$b <=> $a} keys %$site_hash)
{
	if($min > $site)
	{
		$min = $site;
	}
	if($site <= $cutoff)
	{
		print OUT $site."\t".$site_hash->{$site}."\n";
	}
}
close OUT;

print $cases."\t".$max."\t".$min."\t".$avg."\n";

system('sh bargraph.sh '.$output.'temp_distro '.$output.'.png');
