use strict;

my $file = shift or die;
my $transfac = shift or die;
my $output = shift or die;

open(IN, $file);
open(TF, $transfac);
open (OUT, ">$output");

my @TF = <TF>;
my $header = <IN>;

print OUT "TF_ID, BS, ".$header;

my $hash;

while(my $record = <IN>)
{
	chomp($record);
	my ($word) = split(/\,/,$record);
	$word =~ s/[\'\"]//g;
	foreach my $tfline (@TF)
	{
#		print $tfline;
		chomp($tfline);
		my ($id,$bs) = split(/\,/,$tfline);
		if($bs =~ m/$word/i || $word =~ m/$bs/i)
		{
			$hash->{$id.",".$bs.",".$record."\n"} = 1;
		}
	}
}

foreach my $result (keys %$hash)
{
	print OUT $result;
#	print $result;
}
