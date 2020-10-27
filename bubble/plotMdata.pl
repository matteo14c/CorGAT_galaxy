$ofile=shift;
$plot1=shift;
$plot2=shift;
@genomes=();
foreach $var_file (@ARGV)
{
	open(IN,$var_file);
	$genome="genome";
	while(<IN>)
	{
		($pos,$ref,$alt,$gen)=(split(/\s+/))[1,2,3,-1];
		next unless $ref=~/[ACTG]/ && $alt=~/[ACTG]/;
		#print $pos $ref $alt\n;
		if ($genome eq "genome")
		{
			push(@genomes,$gen);
			$genome=$gen;
		}
		$is_present{"$pos\_$ref|$alt"}{$genome}=1;
	}
}

@test=qw(241_C|T 514_T|C 1059_C|T 1397_G|A 1440_G|A 1605_ATG|... 2416_C|T 2480_A|G 2558_C|T 2891_G|A 3037_C|T 8782_C|T 9477_T|A 10097_G|A 11083_G|T 11916_C|T 14408_C|T 14805_C|T 15324_C|T 17247_T|C 17747_C|T 17858_A|G 18060_C|T 18877_C|T 18998_C|T 20268_A|G 23403_A|G 23731_C|T 24034_C|T 25429_G|T 25563_G|T 25979_G|T 26144_G|T 27046_C|T 27964_C|T 28144_T|C 28311_C|T 28657_C|T 28688_T|C 28851_G|T 28854_C|T 28863_C|T 28881_GGG|AAC 29540_G|A 29553_G|A 29742_G|T);

open(OUT,">$ofile");
print OUT " @test\n";

foreach $genome (@genomes)
{
	$ostring="$genome ";
	foreach $t (@test)
	{
		$val=$is_present{$t}{$genome} ? 1 : 0;
		$ostring.="$val ";
	}
	chop($ostring);
	print OUT "$ostring\n";
}
system("Rscript --vanilla bubbleplot.R $ofile $plot1 $plot2")==0||die("no plot");
