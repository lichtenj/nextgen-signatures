use strict;

my $maindir = shift or die "perl SBT.pl MAINDIR CELLDIR PARTITIONDIR FILTERDIR SEQUENCEDIR ORGANISM EXPERIMENT_ID EXPRESSIONDIR FRACTION(yes|no) PREPARATION(yes|no) PEAKLISTS(yes|no) GENELISTS(yes|no) CHROMOSOMES(yes|no) ASSEMBLY(yes|no) DEMOGRAPHICS(yes|no) FUNCTIONALANALYSIS(yes|no) BINDINGSITE(yes|no) SIGNATURE(yes|no)";
my $cells = shift or die "perl SBT.pl MAINDIR CELLDIR PARTITIONDIR FILTERDIR SEQUENCEDIR ORGANISM EXPERIMENT_ID EXPRESSIONDIR FRACTION(yes|no) PREPARATION(yes|no) PEAKLISTS(yes|no) GENELISTS(yes|no) CHROMOSOMES(yes|no) ASSEMBLY(yes|no) DEMOGRAPHICS(yes|no) FUNCTIONALANALYSIS(yes|no) BINDINGSITE(yes|no) SIGNATURE(yes|no)";
my $partitions = shift or die "perl SBT.pl MAINDIR CELLDIR PARTITIONDIR FILTERDIR SEQUENCEDIR ORGANISM EXPERIMENT_ID EXPRESSIONDIR FRACTION(yes|no) PREPARATION(yes|no) PEAKLISTS(yes|no) GENELISTS(yes|no) CHROMOSOMES(yes|no) ASSEMBLY(yes|no) DEMOGRAPHICS(yes|no) FUNCTIONALANALYSIS(yes|no) BINDINGSITE(yes|no) SIGNATURE(yes|no)";
my $filters = shift or die "perl SBT.pl MAINDIR CELLDIR PARTITIONDIR FILTERDIR SEQUENCEDIR ORGANISM EXPERIMENT_ID EXPRESSIONDIR FRACTION(yes|no) PREPARATION(yes|no) PEAKLISTS(yes|no) GENELISTS(yes|no) CHROMOSOMES(yes|no) ASSEMBLY(yes|no) DEMOGRAPHICS(yes|no) FUNCTIONALANALYSIS(yes|no) BINDINGSITE(yes|no) SIGNATURE(yes|no)";
my $sequences = shift or die "perl SBT.pl MAINDIR CELLDIR PARTITIONDIR FILTERDIR SEQUENCEDIR ORGANISM EXPERIMENT_ID EXPRESSIONDIR FRACTION(yes|no) PREPARATION(yes|no) PEAKLISTS(yes|no) GENELISTS(yes|no) CHROMOSOMES(yes|no) ASSEMBLY(yes|no) DEMOGRAPHICS(yes|no) FUNCTIONALANALYSIS(yes|no) BINDINGSITE(yes|no) SIGNATURE(yes|no)";
my $org = shift or die "perl SBT.pl MAINDIR CELLDIR PARTITIONDIR FILTERDIR SEQUENCEDIR ORGANISM EXPERIMENT_ID EXPRESSIONDIR FRACTION(yes|no) PREPARATION(yes|no) PEAKLISTS(yes|no) GENELISTS(yes|no) CHROMOSOMES(yes|no) ASSEMBLY(yes|no) DEMOGRAPHICS(yes|no) FUNCTIONALANALYSIS(yes|no) BINDINGSITE(yes|no) SIGNATURE(yes|no)";
my $experiment_id = shift or die "perl SBT.pl MAINDIR CELLDIR PARTITIONDIR FILTERDIR SEQUENCEDIR ORGANISM EXPERIMENT_ID EXPRESSIONDIR FRACTION(yes|no) PREPARATION(yes|no) PEAKLISTS(yes|no) GENELISTS(yes|no) CHROMOSOMES(yes|no) ASSEMBLY(yes|no) DEMOGRAPHICS(yes|no) FUNCTIONALANALYSIS(yes|no) BINDINGSITE(yes|no) SIGNATURE(yes|no)";
my $expressiondir = shift or die "perl SBT.pl MAINDIR CELLDIR PARTITIONDIR FILTERDIR SEQUENCEDIR ORGANISM EXPERIMENT_ID EXPRESSIONDIR FRACTION(yes|no) PREPARATION(yes|no) PEAKLISTS(yes|no) GENELISTS(yes|no) CHROMOSOMES(yes|no) ASSEMBLY(yes|no) DEMOGRAPHICS(yes|no) FUNCTIONALANALYSIS(yes|no) BINDINGSITE(yes|no) SIGNATURE(yes|no)";
my $fraction = shift or die "perl SBT.pl MAINDIR CELLDIR PARTITIONDIR FILTERDIR SEQUENCEDIR ORGANISM EXPERIMENT_ID EXPRESSIONDIR FRACTION(yes|no) PREPARATION(yes|no) PEAKLISTS(yes|no) GENELISTS(yes|no) CHROMOSOMES(yes|no) ASSEMBLY(yes|no) DEMOGRAPHICS(yes|no) FUNCTIONALANALYSIS(yes|no) BINDINGSITE(yes|no) SIGNATURE(yes|no)";

my $preparing = shift or die "perl SBT.pl MAINDIR CELLDIR PARTITIONDIR FILTERDIR SEQUENCEDIR ORGANISM EXPERIMENT_ID EXPRESSIONDIR FRACTION(yes|no) PREPARATION(yes|no) PEAKLISTS(yes|no) GENELISTS(yes|no) CHROMOSOMES(yes|no) ASSEMBLY(yes|no) DEMOGRAPHICS(yes|no) FUNCTIONALANALYSIS(yes|no) BINDINGSITE(yes|no) SIGNATURE(yes|no)";
my $peaklists = shift or die "perl SBT.pl MAINDIR CELLDIR PARTITIONDIR FILTERDIR SEQUENCEDIR ORGANISM EXPERIMENT_ID EXPRESSIONDIR FRACTION(yes|no) PREPARATION(yes|no) PEAKLISTS(yes|no) GENELISTS(yes|no) CHROMOSOMES(yes|no) ASSEMBLY(yes|no) DEMOGRAPHICS(yes|no) FUNCTIONALANALYSIS(yes|no) BINDINGSITE(yes|no) SIGNATURE(yes|no)";
my $genelists = shift or die "perl SBT.pl MAINDIR CELLDIR PARTITIONDIR FILTERDIR SEQUENCEDIR ORGANISM EXPERIMENT_ID EXPRESSIONDIR FRACTION(yes|no) PREPARATION(yes|no) PEAKLISTS(yes|no) GENELISTS(yes|no) CHROMOSOMES(yes|no) ASSEMBLY(yes|no) DEMOGRAPHICS(yes|no) FUNCTIONALANALYSIS(yes|no) BINDINGSITE(yes|no) SIGNATURE(yes|no)";
my $chromosomes = shift or die "perl SBT.pl MAINDIR CELLDIR PARTITIONDIR FILTERDIR SEQUENCEDIR ORGANISM EXPERIMENT_ID EXPRESSIONDIR FRACTION(yes|no) PREPARATION(yes|no) PEAKLISTS(yes|no) GENELISTS(yes|no) CHROMOSOMES(yes|no) ASSEMBLY(yes|no) DEMOGRAPHICS(yes|no) FUNCTIONALANALYSIS(yes|no) BINDINGSITE(yes|no) SIGNATURE(yes|no)";
my $assembly = shift or die "perl SBT.pl MAINDIR CELLDIR PARTITIONDIR FILTERDIR SEQUENCEDIR ORGANISM EXPERIMENT_ID EXPRESSIONDIR FRACTION(yes|no) PREPARATION(yes|no) PEAKLISTS(yes|no) GENELISTS(yes|no) CHROMOSOMES(yes|no) ASSEMBLY(yes|no) DEMOGRAPHICS(yes|no) FUNCTIONALANALYSIS(yes|no) BINDINGSITE(yes|no) SIGNATURE(yes|no)";
my $demographics = shift or die "perl SBT.pl MAINDIR CELLDIR PARTITIONDIR FILTERDIR SEQUENCEDIR ORGANISM EXPERIMENT_ID EXPRESSIONDIR FRACTION(yes|no) PREPARATION(yes|no) PEAKLISTS(yes|no) GENELISTS(yes|no) CHROMOSOMES(yes|no) ASSEMBLY(yes|no) DEMOGRAPHICS(yes|no) FUNCTIONALANALYSIS(yes|no) BINDINGSITE(yes|no) SIGNATURE(yes|no)";
my $functionalanalysis = shift or die "perl SBT.pl MAINDIR CELLDIR PARTITIONDIR FILTERDIR SEQUENCEDIR ORGANISM EXPERIMENT_ID EXPRESSIONDIR FRACTION(yes|no) PREPARATION(yes|no) PEAKLISTS(yes|no) GENELISTS(yes|no) CHROMOSOMES(yes|no) ASSEMBLY(yes|no) DEMOGRAPHICS(yes|no) FUNCTIONALANALYSIS(yes|no) BINDINGSITE(yes|no) SIGNATURE(yes|no)";
my $bindingsite = shift or die "perl SBT.pl MAINDIR CELLDIR PARTITIONDIR FILTERDIR SEQUENCEDIR ORGANISM EXPERIMENT_ID EXPRESSIONDIR FRACTION(yes|no) PREPARATION(yes|no) PEAKLISTS(yes|no) GENELISTS(yes|no) CHROMOSOMES(yes|no) ASSEMBLY(yes|no) DEMOGRAPHICS(yes|no) FUNCTIONALANALYSIS(yes|no) BINDINGSITE(yes|no) SIGNATURE(yes|no)";
my $signature = shift or die "perl SBT.pl MAINDIR CELLDIR PARTITIONDIR FILTERDIR SEQUENCEDIR ORGANISM EXPERIMENT_ID EXPRESSIONDIR FRACTION(yes|no) PREPARATION(yes|no) PEAKLISTS(yes|no) GENELISTS(yes|no) CHROMOSOMES(yes|no) ASSEMBLY(yes|no) DEMOGRAPHICS(yes|no) FUNCTIONALANALYSIS(yes|no) BINDINGSITE(yes|no) SIGNATURE(yes|no)";

if($preparing eq "yes")
{
	print "Preparing ".$experiment_id." Experiment Folder\n";
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment');
}
if($peaklists eq "yes")
{
	print "Building Peaklists\n";
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Peaklists 2> '.$maindir.'/'.$experiment_id.'_Experiment/error.log');
		if($fraction eq "yes")
		{
			system('perl batch_partitioning.pl '.$cells.'/'.$experiment_id.' '.$partitions.'/'.$org.' '.$maindir.'/'.$experiment_id.'_Experiment/Peaklists fraction 2> '.$maindir.'/'.$experiment_id.'_Experiment/error.log');
		}
		else
		{
			system('perl batch_partitioning.pl '.$cells.'/'.$experiment_id.' '.$partitions.'/'.$org.' '.$maindir.'/'.$experiment_id.'_Experiment/Peaklists 2> '.$maindir.'/'.$experiment_id.'_Experiment/error.log');
		}
		system('cp '.$cells.'/'.$experiment_id.'/* '.$maindir.'/'.$experiment_id.'_Experiment/Peaklists/');
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Filtered_Peaklists 2> '.$maindir.'/'.$experiment_id.'_Experiment/error.log');
		if($fraction eq "yes")
		{
			system('perl batch_partitioning.pl '.$maindir.'/'.$experiment_id.'_Experiment/Peaklists '.$filters.'/'.$org.' '.$maindir.'/'.$experiment_id.'_Experiment/Filtered_Peaklists fraction 2> '.$maindir.'/'.$experiment_id.'_Experiment/error.log');
		}
		else
		{
			system('perl batch_partitioning.pl '.$maindir.'/'.$experiment_id.'_Experiment/Peaklists '.$filters.'/'.$org.' '.$maindir.'/'.$experiment_id.'_Experiment/Filtered_Peaklists 2> '.$maindir.'/'.$experiment_id.'_Experiment/error.log');
		}

		#Silent move for large directories...
		opendir(DIR, $maindir.'/'.$experiment_id.'_Experiment/Filtered_Peaklists');
		while(my $file = readdir DIR)
		{
			if($file =~ /^\./){next;}
			system('mv '.$maindir.'/'.$experiment_id.'_Experiment/Filtered_Peaklists/'.$file.' '.$maindir.'/'.$experiment_id.'_Experiment/Peaklists/');
		}
		system('rm -rf '.$maindir.'/'.$experiment_id.'_Experiment/Filtered_Peaklists');

	print "Characterizing Peaklist Overlaps\n";
		system('perl batch_partition_overlap.pl '.$maindir.'/'.$experiment_id.'_Experiment/Peaklists '.$org.' > '.$maindir.'/'.$experiment_id.'_Experiment/Peaklist_Overlaps.tsv');
}
if($genelists eq "yes")
{
	print "Building Genelists\n";
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Genelists');
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Genelists_Autosomes');
		system('perl genelist.pl '.$maindir.'/'.$experiment_id.'_Experiment/Peaklists '.$partitions.'/'.$org.' '.$maindir.'/'.$experiment_id.'_Experiment/Genelists');
		system('perl genelist.pl '.$maindir.'/'.$experiment_id.'_Experiment/Peaklists '.$partitions.'/'.$org.' '.$maindir.'/'.$experiment_id.'_Experiment/Genelists_Autosomes -autosomes');
}
if($chromosomes eq "yes")
{
	print "Characterizing Chromosomes\n";
		my $chr = 0;
		if($org eq "mm9"){$chr = 19};
		if($org eq "hg18"){$chr = 22};
		
		my @chrom;
		for(my $i = 1; $i <= $chr; $i++)
		{
			push(@chrom, "chr".$i);
		}
		push(@chrom, "chrX");
		push(@chrom, "chrY");
	
		open(CHRG, ">".$maindir."/".$experiment_id."_Experiment/Chromosomal_Breakdown_By_Genes.tsv");
		open(CHRGA, ">".$maindir."/".$experiment_id."_Experiment/Chromosomal_Breakdown_By_Autosomal_Genes.tsv");
		open(CHRP, ">".$maindir."/".$experiment_id."_Experiment/Chromosomal_Breakdown_By_Peaks.tsv");
	
		print CHRG "Set\tPartition\tFilter\t";
		print CHRGA "Set\tPartition\tFilter\t";
		print CHRP "Set\tPartition\tFilter\t";
	
		foreach my $chr (@chrom)
		{
			print CHRG $chr."\t";
			print CHRGA $chr."\t";
			print CHRP $chr."\t";
		}	
	
		print CHRG "\n";
		print CHRGA "\n";
		print CHRP "\n";
	
		close CHRG;
		close CHRGA;
		close CHRP;
	
		system('perl batch_chromosome_breakdown_genes.pl '.$maindir.'/'.$experiment_id.'_Experiment/Genelists '.$maindir.'/mm9_refFlat.txt >> '.$maindir.'/'.$experiment_id.'_Experiment/Chromosomal_Breakdown_By_Genes.tsv '.$org);
		system('perl batch_chromosome_breakdown_genes.pl '.$maindir.'/'.$experiment_id.'_Experiment/Genelists_Autosomes '.$maindir.'/mm9_refFlat.txt >> '.$maindir.'/'.$experiment_id.'_Experiment/Chromosomal_Breakdown_By_Autosomal_Genes.tsv '.$org);
		system('perl batch_chromosome_breakdown_peaks.pl '.$maindir.'/'.$experiment_id.'_Experiment/Peaklists >> '.$maindir.'/'.$experiment_id.'_Experiment/Chromosomal_Breakdown_By_Peaks.tsv '.$org);
}
if($assembly eq "yes")
{
	print "Sequence Assembly and InSilico Validation\n";

		print "\tAssembly\n";
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Sequences');
		system('perl batch_extract.pl '.$maindir.'/'.$experiment_id.'_Experiment/Peaklists '.$sequences.' '.$org.' '.$maindir.'/'.$experiment_id.'_Experiment/Sequences');

		print "\tValidation\n";
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/InSilico_Validation');
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/InSilico_Validation/Sites');
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/InSilico_Validation/Lengths');
		system('perl batch_sites.pl '.$maindir.'/'.$experiment_id.'_Experiment/Sequences 60 '.$maindir.'/'.$experiment_id.'_Experiment/InSilico_Validation/Sites');
		system('perl batch_length.pl '.$maindir.'/'.$experiment_id.'_Experiment/Sequences '.$maindir.'/'.$experiment_id.'_Experiment/InSilico_Validation/Lengths');
}
if($demographics eq "yes")
{
	print "Generating Demographics and Validations\n";
		system('perl demographics.pl '.$maindir.'/'.$experiment_id.'_Experiment/Peaklists/ '.$org.' > '.$maindir.'/'.$experiment_id.'_Experiment/Peak_Demographics.tsv');
		system('perl demographics.pl '.$maindir.'/'.$experiment_id.'_Experiment/Genelists/ '.$org.' > '.$maindir.'/'.$experiment_id.'_Experiment/Gene_Demographics.tsv');
		system('perl demographics.pl '.$maindir.'/'.$experiment_id.'_Experiment/Genelists_Autosomes/ '.$org.' > '.$maindir.'/'.$experiment_id.'_Experiment/Gene_Autosomes_Demographics.tsv');
}
if($functionalanalysis eq "yes")
{
	print "Functional Analysis: Expression Analysis\n";
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Expression');
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Expression/Expressed_Methylated');
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Expression/Expressed_NotMethylated');
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Expression/NotExpressed_Methylated');
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Expression/NotExpressed_NotMethylated');
		system('perl batch_new_bloodex.pl '.$maindir.'/'.$experiment_id.'_Experiment/Genelists '.$expressiondir.'/'.$experiment_id.' '.$maindir.'/'.$org.'_genelist.txt '.$org.' '.$maindir.'/'.$experiment_id.'_Experiment/Expression/Expressed_Methylated '.$maindir.'/'.$experiment_id.'_Experiment/Expression/Expressed_NotMethylated '.$maindir.'/'.$experiment_id.'_Experiment/Expression/NotExpressed_Methylated '.$maindir.'/'.$experiment_id.'_Experiment/Expression/NotExpressed_NotMethylated > '.$maindir.'/'.$experiment_id.'_Experiment/Expression_Analysis.tsv');

	print "Functional Analysis: Pathway Analysis\n";
		print "\tPreparation\n";
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Pathways');
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Pathways/Expressed_Methylated');
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Pathways/Expressed_NotMethylated');
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Pathways/NotExpressed_Methylated');
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Pathways/NotExpressed_NotMethylated');

		print "\tDiscovery\n";
		system('perl batch_kegg.pl '.$maindir.'/'.$experiment_id.'_Experiment/Expression/Expressed_Methylated '.$org.' ~/Downloads/kegg_ko.txt ~/Downloads/kegg_pathway_list.txt '.$maindir.'/'.$experiment_id.'_Experiment/Pathways/Expressed_Methylated');
		system('perl batch_kegg.pl '.$maindir.'/'.$experiment_id.'_Experiment/Expression/Expressed_NotMethylated '.$org.' ~/Downloads/kegg_ko.txt ~/Downloads/kegg_pathway_list.txt '.$maindir.'/'.$experiment_id.'_Experiment/Pathways/Expressed_NotMethylated');
		system('perl batch_kegg.pl '.$maindir.'/'.$experiment_id.'_Experiment/Expression/NotExpressed_Methylated '.$org.' ~/Downloads/kegg_ko.txt ~/Downloads/kegg_pathway_list.txt '.$maindir.'/'.$experiment_id.'_Experiment/Pathways/NotExpressed_Methylated');
		system('perl batch_kegg.pl '.$maindir.'/'.$experiment_id.'_Experiment/Expression/NotExpressed_NotMethylated '.$org.' ~/Downloads/kegg_ko.txt ~/Downloads/kegg_pathway_list.txt '.$maindir.'/'.$experiment_id.'_Experiment/Pathways/NotExpressed_NotMethylated');

		print "\tStatistical Analysis\n";
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/TMP');
		system('perl batch_add_pathway_statistics.pl '.$maindir.'/'.$experiment_id.'_Experiment/Pathways/Expressed_Methylated '.$maindir.'/'.$experiment_id.'_Experiment/Genelists '.$maindir.'/'.$experiment_id.'_Experiment/TMP');
		system('rm -rf '.$maindir.'/'.$experiment_id.'_Experiment/Pathways/Expressed_Methylated');
		system('mv '.$maindir.'/'.$experiment_id.'_Experiment/TMP '.$maindir.'/'.$experiment_id.'_Experiment/Pathways/Expressed_Methylated');

		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/TMP');
		system('perl batch_add_pathway_statistics.pl '.$maindir.'/'.$experiment_id.'_Experiment/Pathways/Expressed_NotMethylated '.$maindir.'/'.$experiment_id.'_Experiment/Genelists '.$maindir.'/'.$experiment_id.'_Experiment/TMP');
		system('rm -rf '.$maindir.'/'.$experiment_id.'_Experiment/Pathways/Expressed_NotMethylated');
		system('mv '.$maindir.'/'.$experiment_id.'_Experiment/TMP '.$maindir.'/'.$experiment_id.'_Experiment/Pathways/Expressed_NotMethylated');

		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/TMP');
		system('perl batch_add_pathway_statistics.pl '.$maindir.'/'.$experiment_id.'_Experiment/Pathways/NotExpressed_Methylated '.$maindir.'/'.$experiment_id.'_Experiment/Genelists '.$maindir.'/'.$experiment_id.'_Experiment/TMP');
		system('rm -rf '.$maindir.'/'.$experiment_id.'_Experiment/Pathways/NotExpressed_Methylated');
		system('mv '.$maindir.'/'.$experiment_id.'_Experiment/TMP '.$maindir.'/'.$experiment_id.'_Experiment/Pathways/NotExpressed_Methylated');

		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/TMP');
		system('perl batch_add_pathway_statistics.pl '.$maindir.'/'.$experiment_id.'_Experiment/Pathways/NotExpressed_NotMethylated '.$maindir.'/'.$experiment_id.'_Experiment/Genelists '.$maindir.'/'.$experiment_id.'_Experiment/TMP');
		system('rm -rf '.$maindir.'/'.$experiment_id.'_Experiment/Pathways/NotExpressed_NotMethylated');
		system('mv '.$maindir.'/'.$experiment_id.'_Experiment/TMP '.$maindir.'/'.$experiment_id.'_Experiment/Pathways/NotExpressed_NotMethylated');

	print "Functional Analysis: Gene Ontology Analysis\n";
		print "\tPreparation\n";
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Ontologies');
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Ontologies/Expressed_Methylated');
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Ontologies/Expressed_NotMethylated');
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Ontologies/NotExpressed_Methylated');
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Ontologies/NotExpressed_NotMethylated');
	
		print "\tDiscovery\n";
		system('perl batch_geneontology.pl /Volumes/Mac_HD_RAID/MBD2_Experiment/Expression/Expressed_Methylated /Volumes/Mac_HD_RAID/MBD2_Experiment/Ontologies/Expressed_Methylated');
		system('perl batch_geneontology.pl /Volumes/Mac_HD_RAID/MBD2_Experiment/Expression/Expressed_NotMethylated /Volumes/Mac_HD_RAID/MBD2_Experiment/Ontologies/Expressed_NotMethylated');
		system('perl batch_geneontology.pl /Volumes/Mac_HD_RAID/MBD2_Experiment/Expression/NotExpressed_Methylated /Volumes/Mac_HD_RAID/MBD2_Experiment/Ontologies/NotExpressed_Methylated');
		system('perl batch_geneontology.pl /Volumes/Mac_HD_RAID/MBD2_Experiment/Expression/NotExpressed_NotMethylated /Volumes/Mac_HD_RAID/MBD2_Experiment/Ontologies/NotExpressed_NotMethylated');
}
if($bindingsite eq "yes")
{
	print "Regulatory Binding Site Discovery\n";
		print "\tPreparation\n";
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/TFBS');
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/TFBS_Lookups');
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/TFBS_Filtered');

		print "\tDiscovery\n";
		system('perl batch_tfbs_discovery_forwardsort.pl '.$experiment_id.' '.$maindir.'/'.$experiment_id.'_Experiment/Sequences '.$maindir.'/'.$experiment_id.'_Experiment/TFBS');
		system('perl batch_tfbs_discovery_reversesort.pl '.$experiment_id.' '.$maindir.'/'.$experiment_id.'_Experiment/Sequences '.$maindir.'/'.$experiment_id.'_Experiment/TFBS');

		print "\tAnalysis\n";
		system('perl batch_analysis_tfbs.pl '.$maindir.'/'.$experiment_id.'_Experiment/TFBS 25 '.$maindir.'/'.$experiment_id.'_Experiment/TFBS_Filtered');
		system('perl batch_lookup.pl '.$maindir.'/'.$experiment_id.'_Experiment/TFBS_Filtered '.$maindir.'/'.$experiment_id.'_Experiment/Sequences '.$maindir.'/'.$experiment_id.'_Experiment/TFBS_Lookups');
}
if($signature eq "yes")
{
	print "Signature Discovery\n";
		print "\tPreparation\n";
		system('mkdir '.$maindir.'/'.$experiment_id.'_Experiment/Signatures');

		print "\tDiscovery\n";
		system('perl batch_signature.pl '.$maindir.'/'.$experiment_id.'_Experiment/TFBS_Lookups '.$maindir.'/'.$experiment_id.'_Experiment/Signatures '.$maindir.'/'.$experiment_id.'_Experiment/Sequences '.$org.' '.$maindir.'/Signature_Profiles/MBD2_Signature_Profiles.txt');

#		print "\tAnimation\n";
#		system('export MAGICK_HOME="$HOME/Downloads/ImageMagick-6.6.7"');
#		system('export PATH="$MAGICK_HOME/bin:$PATH"');
#		system('export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib/"');
#		system('convert -delay 100 '.$maindir.'/'.$experiment_id.'_Experiment/Signatures/Cell/*.png -loop 0 '.$maindir.'/'.$experiment_id.'_Experiment/Signatures/Cell_Signatures.gif');
#		system('convert -delay 100 '.$maindir.'/'.$experiment_id.'_Experiment/Signatures/Partition/*.png -loop 0 '.$maindir.'/'.$experiment_id.'_Experiment/Signatures/Partition_Signatures.gif');
#		system('convert -delay 100 '.$maindir.'/'.$experiment_id.'_Experiment/Signatures/Filter/*.png -loop 0 '.$maindir.'/'.$experiment_id.'_Experiment/Signatures/Filter_Signatures.gif');
}
