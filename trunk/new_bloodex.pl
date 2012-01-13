use strict;

#Input Files
my $file 	= shift or die;
my $bloodex 	= shift or die;
my $allgenes 	= shift or die;
my $org		= shift or die;
#Output Files
my $onon 	= shift or die;
my $onoff 	= shift or die;
my $offon 	= shift or die;
my $offoff 	= shift or die;

my $genes;

open(IN, $allgenes);
while(my $rec = <IN>)
{
	chomp($rec);
	$genes->{$rec}->{'Methylated'} = "0";
	$genes->{$rec}->{'Expressed'} = "0";
}
close IN;

open(IN, $file);
while(my $rec = <IN>)
{
	chomp($rec);
	$genes->{$rec}->{'Methylated'} = "1";
}
close IN;

open(IN, $bloodex);
while(my $rec = <IN>)
{
	chomp($rec);
	$genes->{$rec}->{'Expressed'} = "1";
}
close IN;

open(ONON, ">$onon");
open(ONOFF, ">$onoff");
open(OFFON, ">$offon");
open(OFFOFF, ">$offoff");

my $count_onon   = 0;
my $count_onoff  = 0;
my $count_offon  = 0;
my $count_offoff = 0;

foreach my $gene (keys %$genes)
{
	#ONON or OFFON
	if($genes->{$gene}->{'Methylated'} == 1)
	{
		#ONON
		if($genes->{$gene}->{'Expressed'} == 1)
		{
			$count_onon++;
			print ONON $gene."\n";
		}
		#OFFON
		else
		{
			$count_offon++;
			print OFFON $gene."\n";
		}
	}
	#ONOFF or OFFOFF
	else
	{
		#ONOFF
		if($genes->{$gene}->{'Expressed'} == 1)
		{
			$count_onoff++;
			print ONOFF $gene."\n";
		}
		#OFFOFF
		else
		{
			$count_offoff++;
			print OFFOFF $gene."\n";
		}
	}
}

close ONON;
close ONOFF;
close OFFON;
close OFFOFF;

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
$fields[0] =~ /\/(\w+)$/;
$fields[0] = $1;
$fields[1] =~ s/^\_//;
$fields[2] =~ s/^\_//;
print $fields[0]."\t".$fields[1]."\t".$fields[2]."\t".$count_onon."\t".$count_onoff."\t".$count_offon."\t".$count_offoff."\n";
