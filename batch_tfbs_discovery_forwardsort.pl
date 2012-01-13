use strict;

my $id = shift or die;
my $dir = shift or die;
my $outdir = shift or die;

opendir(DH, $dir) || die "Cannot open $dir";
my @files = readdir(DH);
closedir DH;

foreach my $filename (sort {$a cmp $b} @files) 
{
	if($filename !~ m/^\./)
	{
		my $input = $dir."/".$filename;

		if(-s $input)
		{
			$filename =~ /^([\w\_\.]+)\.fa/;
			
			for(my $length = 5; $length <= 10; $length++)
			{
				for(my $order = 0; $order <= $length - 2; $order++)
				{
					my $outputmd = $outdir.'/'.$1.'_MD_'.$length.'_'.$order.'_scored.csv';
					if(! -e $outputmd)
					{
						system('perl wordseeker.pl '.$input.' '.$length.' 1 1 false false '.$order.' 1 25 s e 1 '.$id.' '.$outputmd);
					}
				}
			}
		}
	}
}
