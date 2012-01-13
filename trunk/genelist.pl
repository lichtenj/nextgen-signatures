use strict;
use Parallel::Forkmanager;

my $dir = shift or die;
my $partsdir = shift or die;
my $outdir = shift or die;
my $autosome = shift;

my $pm = new Parallel::ForkManager(20);

opendir(DH, $dir) || die "Cannot open $dir";
while(my $filename = readdir(DH)) 
{
	if($filename !~ m/^\./)
	{
		my $pid = $pm->start and next;

		$filename =~ /\.bed\_([\w\_]+\.bed)\.bed/;
		my $partfile = $1;
		if(-e $partsdir.'/'.$partfile && $partfile && $partfile !~ /intergenic/)
		{
			system('intersectBed -wb -a '.$dir.'/'.$filename.' -b '.$partsdir.'/'.$partfile.' > '.$outdir.'/'.$filename);
		}
		else
		{
			opendir(DP, $partsdir);
			while(my $partfile = readdir DP)
			{
				if($partfile =~ /^\./ || $partfile =~ /intergenic/){next;}
				system('intersectBed -wb -a '.$dir.'/'.$filename.' -b '.$partsdir.'/'.$partfile.' >> '.$outdir.'/'.$filename);
			}
			closedir DP;
		}
		system('perl reformat_genelist_to_symbols.pl '.$outdir.'/'.$filename.' '.$autosome);

		$pm->finish; # Terminates the child process
	}
}
closedir DH;

