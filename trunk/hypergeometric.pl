#!/usr/bin/perl -w
use strict;
my $n = shift or die;
my $m = shift or die;
my $N = shift or die;
my $i = shift or die;

sub logfact {
   return gammln(shift(@_) + 1.0);
}

sub hypergeom {
   # There are m "bad" and n "good" balls in an urn.
   # Pick N of them. The probability of i or more successful selections:
   # (m!n!N!(m+n-N)!)/(i!(n-i)!(m+i-N)!(N-i)!(m+n)!)
   my ($n, $m, $N, $i) = @_;

   my $loghyp1 = logfact($m)+logfact($n)+logfact($N)+logfact($m+$n-$N);
   my $loghyp2 = logfact($i)+logfact($n-$i)+logfact($m+$i-$N)+logfact($N-$i)+logfact($m+$n);
   return exp($loghyp1 - $loghyp2);
}

sub gammln {
  my $xx = shift;
  my @cof = (76.18009172947146, -86.50532032941677,
             24.01409824083091, -1.231739572450155,
             0.12086509738661e-2, -0.5395239384953e-5);
  my $y = my $x = $xx;
  my $tmp = $x + 5.5;
  $tmp -= ($x + .5) * log($tmp);
  my $ser = 1.000000000190015;
  for my $j (0..5) {
     $ser += $cof[$j]/++$y;
  }
  -$tmp + log(2.5066282746310005*$ser/$x);
}

my $sum = 0;
for(my $c = 0; $c <= $i; $c++)
{
	$sum += hypergeom($n,$m-$n,$N,$c);
}

my $pdf = (1 - hypergeom($n,$m-$n,$N,$i));
my $cdf = (1 - $sum);

print $pdf."\t".$cdf."\n";
