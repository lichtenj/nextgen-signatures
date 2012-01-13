my $dir = shift or die;
my $gdir = shift or die;
my $outdir = shift or die;

opendir(DIR, $dir);

while(my $file = readdir DIR)
{
	if($file =~ /^\./){next;}
	my $genelist = $file;
	$genelist =~ s/\.tsv$//;
	system('perl add_pathway_statistics.pl '.$dir.'/'.$file.' '.$gdir.'/'.$genelist.' > '.$outdir.'/'.$file);
}
