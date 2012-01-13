my $dir = shift or die;
my $blooddir = shift or die;
my $allgenes = shift or die;
my $org = shift or die;
my $onondir = shift or die;	#	Expressed	- 	Methylation
my $onoffdir = shift or die; 	#	Expressed  	- No 	Methylation
my $offondir = shift or die; 	# Not 	Expressed  	- 	Methylation
my $offoffdir = shift or die; 	# Not 	Expressed  	- No 	Methylation

print "Cell Type\tPartition\tFilter\tExpressed_Methylated\tExpressed_NotMethylated\tNotExpressed_Methylated\tNotExpressed_Methylated\n";

opendir(DIR, $dir);
while(my $file = readdir DIR)
{
	if($file =~ /^\./){next;}

	my @tmp = split(/\./, $file);
	system("perl new_bloodex.pl ".$dir.'/'.$file.' '.$blooddir.'/'.$tmp[0].'.bed '.$allgenes.' '.$org.' '.$onondir.'/'.$file.'.tsv '.$onoffdir.'/'.$file.'.tsv '.$offondir.'/'.$file.'.tsv '.$offoffdir.'/'.$file.'.tsv');
}
