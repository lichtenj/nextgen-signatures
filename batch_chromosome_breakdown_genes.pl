my $dir = shift or die;
my $allgenes = shift or die;
my $org = shift or die;

opendir(DIR, $dir);
while(my $file = readdir DIR)
{
	if($file =~ /^\./){next;}
	system('perl chromosome_breakdown_genes.pl '.$dir.'/'.$file.' '.$allgenes.' '.$org);
}
