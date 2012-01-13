use strict;

my $filename = shift or die;
my $seqdir = shift or die;
my $org = shift or die;
my $output = shift or die;

open(IN, $filename) or die "Cannot open ".$filename."\n";
open(OUT, ">$output");

$filename =~ /\/([\w\.]+)$/;
my $file = $1.'.fa';

while(my $record = <IN>)
{
	chomp($record);
	if($record !~ /chr/)
	{next;}

	my @tmp = split(/\t/,$record);
	my $cmd = 'nibFrag '.$seqdir.'/'.$org.'/'.$tmp[0].'.nib '.$tmp[1].' '.$tmp[2].' + '.$file;
	system($cmd);
	if(-e $file)
	{
		open(FA, $file);
		while(my $fasta = <FA>)
		{
			print OUT $fasta;
		}
	}
	system('rm '.$file);
}
close IN;
close OUT;
