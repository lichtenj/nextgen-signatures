use strict;

my $dir = shift or die;
my $partsdir = shift or die;
my $outdir = shift or die;
my $fraction = shift;

opendir(DH, $dir) || die "Cannot open $dir";
while(my $filename = readdir(DH)) 
{
	if($filename !~ m/^\./)
	{
		opendir(DP, $partsdir) || die "Cannot open $partsdir";
		while(my $partfile = readdir(DP)) 
		{
			if($partfile !~ m/^\./)
			{
				#print $partfile."\n";
				if($fraction)
				{
					system('intersectBed -u -wa -a '.$dir.'/'.$filename.' -b '.$partsdir.'/'.$partfile.' -f 0.50 > '.$outdir.'/'.$filename.'_'.$partfile.'.bed');
				}
				else
				{
					system('intersectBed -u -wa -a '.$dir.'/'.$filename.' -b '.$partsdir.'/'.$partfile.' > '.$outdir.'/'.$filename.'_'.$partfile.'.bed');
				}
			}
		}
		closedir DP;
	}
}
closedir DH;

