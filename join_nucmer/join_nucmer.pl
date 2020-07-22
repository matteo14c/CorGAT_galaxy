@genomes=();
$ofile=shift;
open(OUT,">$ofile");
foreach $f (@ARGV)
{
	open(IN,$f);
	%ldata=();
	$genome="";
	while(<IN>)
	{
		chomp();
		($pos,$b1,$b2,$gen)=(split(/\s+/))[1,2,3,-1];
	        next unless $b1=~/[ACTG]/ && $b2=~/[ACTG]/;
       	 	$ldata{$pos}=[$b1,$b2];
       	 	if ($genome eq "")
       	 	{
       	 		$genome=$gen;
       	 		push(@genomes,$genome);
       	 	}
	}
	$prev_pos=0;
	$prev_ref="na";
	$prev_alt="na";
	foreach $pos (sort{$a<=>$b} keys %ldata)
	{
		$dist=$pos-$prev_pos;
	        if ($dist>1)
	        {
	     		$pos_append=$prev_pos-length($prev_alt)+1;
	                $dat_final{"$pos_append\_$prev_ref|$prev_alt"}{$genome}=1 unless $prev_ref eq "na";
	                $prev_ref=$ldata{$pos}[0];
	                $prev_alt=$ldata{$pos}[1];
	        }else{
	         	$prev_ref.=$ldata{$pos}[0];
	                $prev_alt.=$ldata{$pos}[1];
	        }
	        $prev_pos=$pos;
	}
	$pos_append=$prev_pos-length($prev_alt)+1;
        $dat_final{"$pos_append\_$prev_ref|$prev_alt"}{$genome}=1 if $prev_ref ne "na";

}

print OUT " @genomes\n";
foreach $pos (sort{$a<=>$b} keys %dat_final)
{
        $line="$pos ";
        foreach $g (@genomes)
        {
                $val=$dat_final{$pos}{$g} ? 1 : 0;
                $line.="$val ";
        }
        chop($line);
        print OUT "$line\n";
}
