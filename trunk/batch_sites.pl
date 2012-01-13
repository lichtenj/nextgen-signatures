my $seq = shift or die;
my $cutoff = shift or die;
my $outdir = shift or die;

opendir ( DIR, $seq ) || die "Error in opening dir $dirname\n";

while( my $filename = readdir(DIR))
{
	if($filename !~ /^\./)
	{
		print $filename."\t";
		system("perl characterize_sites.pl ".$seq.'/'.$filename." ".$cutoff." ".$outdir.'/'.$filename.'.png 2> error');
		system('rm '.$seq.'/'.$filename.'temp_distro');
	}
}
closedir(DIR);

