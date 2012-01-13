use strict;

my $dir = shift or die;
my $seqdir = shift or die;
my $org = shift or die;
my $outdir = shift or die;

opendir(DH, $dir) || die "Cannot open $dir";
while(my $filename = readdir(DH)) 
{
	if($filename =~ m/^\./){next;}

	system('perl extract.pl '.$dir.'/'.$filename.' '.$seqdir.' '.$org.' '.$outdir.'/'.$filename.'.fa');
}
closedir DH;
