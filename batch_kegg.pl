use Parallel::Forkmanager;

my $dir = shift or die;
my $org = shift or die;
my $kegg_genes = shift or die;
my $kegg_pathways = shift or die;
my $outdir = shift or die;

my $manager = new Parallel::ForkManager( 4 );

opendir(DIR, $dir);
while(my $file = readdir DIR)
{
	if($file =~ /^\./){next;}
	$manager->start and next;
	system('perl kegg_2.pl '.$dir.'/'.$file.' '.$kegg_genes.' '.$kegg_pathways.' '.$org.' > '.$outdir.'/'.$file);
	$manager->finish;
}
closedir DIR;
