my $seq = shift or die;
my $outdir = shift or die;

opendir ( DIR, $seq ) || die "Error in opening dir $dirname\n";

while( my $filename = readdir(DIR))
{
	if($filename !~ /^\./)
	{
		print $filename."\t";
		system('perl characterize_length.pl '.$seq.'/'.$filename.' '.$outdir.'/'.$filename.'.png 2> error');
		system('rm '.$seq.'/'.$filename.'temp_distro');
	}
}
closedir(DIR);

