my $dir = shift or die;
my $org = shift or die;

opendir(DIR, $dir);
while(my $file = readdir DIR)
{
	if($file =~ /^\./){next;}
	system('perl chromosome_breakdown_peaks.pl '.$dir.'/'.$file.' '.$org);
}
