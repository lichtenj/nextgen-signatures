use strict;
use Bio::SeqIO;
use Math::Round;

my $file = shift or die;
my $output = shift or die;

my $length_hash;
my $in  = Bio::SeqIO->new(-file => $file , -format => 'Fasta');

open(SEQ, ">adjusted.fasta");

my $min = 100000;
my $max = 0;
my $avg = 0;
my $cases = 0;
while (my $seq = $in->next_seq())
{
	if($length_hash->{nearest(25, length($seq->seq()))})
	{
		$length_hash->{nearest(25, length($seq->seq()))}++;
	}
	else
	{
		$length_hash->{nearest(25, length($seq->seq()))} = 1;
	}

	if(length($seq->seq()) >= 8)
	{
		print SEQ ">".$seq->seq()."\n";
		print SEQ $seq->seq()."\n";
		$avg += length($seq->seq());

		if($min > length($seq->seq()))
		{
			$min = length($seq->seq());
		}

		if($max < length($seq->seq()))
		{
			$max = length($seq->seq());
		}
		$cases++;
	}
}
close SEQ;

open(OUT, ">".$file."temp_distro");
foreach my $length (sort {$b <=> $a} keys %$length_hash)
{
	if($length <= 3000)
	{
		print OUT $length."\t".$length_hash->{$length}."\n";
	}
}
close OUT;

print $cases."\t".$max."\t".$min."\t".($avg / $cases)."\n";

system('sh bargraph.sh '.$file.'temp_distro '.$output);
