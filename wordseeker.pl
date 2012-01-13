#!/usr/bin/perl -w

#inputs
my $file 		= $ARGV[0];

my $length 		= $ARGV[1];
my $min_seqs		= $ARGV[2];
my $min_o		= $ARGV[3];

my $ancestral_filter	= $ARGV[4];
my $N_filter		= $ARGV[5];

my $order		= $ARGV[6];
my $pthresh		= $ARGV[7];
my $word_seeds		= $ARGV[8];
my $sort_col		= $ARGV[9];
my $cluster_method	= $ARGV[10];
my $distance		= $ARGV[11];
my $jid			= $ARGV[12];


my $score_output	= $ARGV[13];
my $cluster_output	= $ARGV[14];

#number of top words to find
#my $word_seeds =power(4,$length);
sub power {
  local($i,$t);
  local($n, $p) = @_;
  $t = $n;
  for($i = 1; $i < $p; $i++) {
    $t = $t * $n;
  }
  return $t;
}
#$word_seeds = 50;
#word distribution parameters 
#my $word_dist='true';
#my $dist_num=4; 
#my $normalize='fasle';

#set do_clustering true to always do clustering
#my $do_clustering ="true";
#Various settings
my $command = "";
my $resultsPath;
#my $galaxyPath = $ENV{'HOME'}."/galaxy/";
my $cpcmd;
my $timestamp = time;
$jid = $jid."_".$timestamp;

$command .= './OWEFexec';

#Word Enumeration
	$command .= ' --count -i '.$file.' -l '.$length.' -ms '.$min_seqs.' -mo '.$min_o;

#Filtering
	if($ancestral_filter eq "true")
	{
		$command .= ' -a ';
	}

	if($N_filter eq "true")
	{
		$command .= ' -n ';
	}

#Scoring
	$command .= ' --score -o '.$order.' -p -pt '.$pthresh;

#Clustering
#	$command .= ' --cluster -s '.$word_seeds.' -c '.$sort_col;
#	$command .= ' -t '.$cluster_method.' -d '.$distance;

=comment
#' -ml '.$min_length

my $missing="false";
if($missing eq "true"){
    $command=$command.' -m ';
}
my $enumerate="false";
if($enumerate eq "true"){
    $command=$command.' -e ';
}

my $revcomp="true";
if($revcomp eq "true"){
    $command=$command.' -r ';
}

my $motif_logo="true";
my $pwm="true";
my $logos="true";
my $reg_ex="true";
my $k =0;

if($do_clustering eq "true"){
#     if( $motif_logo eq "true"){
#         $command=$command.' -sm';
#     }
    #if ($k ==2){
    if($pwm eq "true"){
      $command=$command.' -pwm';
    }
    if($logos eq "true"){
      $command=$command.' -logos';
    }
    if($reg_ex eq "true"){
      $command=$command.' -regex';
    }
    #}#k
}

my $seq_cluster="false";
if($seq_cluster eq "true"){
  $command=$command.' --sequence';
}
my $scatter_plot="true";
if($scatter_plot eq "true"){
  $command=$command.' --scatter ';
}

#if($run_parallel eq "true"){
#  $command=$command.' --parallel';
#}

if($word_dist eq "true"){   
  $command=$command.' --distribution -dc '.$dist_num;
  if($normalize eq "true"){ 
    $command=$command.' -dn ';
  }
}
          
=cut

$command .= '  --prefix '.$jid.' > /dev/null 2> /dev/null';

system($command);

system('mv ./'.$jid.'_'.$length.'_'.$order.'/'.$jid.'_'.$length.'_'.$order.'.csv '.$score_output);
#system('mv ./'.$jid.'_'.$length.'_'.$order.'/'.$jid.'_'.$length.'_'.$order.'_clusters.csv '.$cluster_output);

system('rm -rf ./'.$jid.'*');
