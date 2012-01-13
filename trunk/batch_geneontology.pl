use strict;
use Parallel::ForkManager;

my $dir = shift or die;
my $outdir = shift or die;
my $pm = new Parallel::ForkManager(20);

opendir(DIR, $dir);
while(my $file = readdir DIR)
{
	if($file =~ /^\./){next;}
	my $pid = $pm->start and next;
	system('perl geneontology.pl '.$dir.'/'.$file.' ~/Downloads/gene_association.mgi > '.$outdir.'/'.$file);
	$pm->finish;
}
