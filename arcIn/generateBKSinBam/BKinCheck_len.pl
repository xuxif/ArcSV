#chr1    1993735 1993739 65M4S   right   ACAT    read_23177      chr1    1993735 1993739 141M9S  right   ACATGGGAG	read_name
%CHECK;
$first_line=1;
@arc_len=();
$count_arc=0;
@modern_len=();
$count_modern=0;
while(<STDIN>)
{
	$sig=0;
	chomp();
	@line=split(/\t/,$_);
	if($line[0] eq $last_line[0] and $line[1] eq $last_line[1] and $line[4] eq $last_line[4])
	{
		$sig=0;
	}
	else
	{
		$sig=1;
	}
	if($sig==1 or eof())
	{
		if($first_line==0 and $count_arc >0 and $count_modern>0)
		{
			print "$last_line[0]\t$pos\t$last_line[4]\t$count_arc\t".join(",",@arc_len)."\t$count_modern\t".join(",",@modern_len)."\n";
		}
		@arc_len=();
		$count_arc=0;
		@modern_len=();
		$count_modern=0;
		$sig=0;
	}
	$first_line=0;
	$line[3]=~/(\d+)S/;
	$len_arc=$1;
	$line[10]=~/(\d+)S/;
	$len_modern=$1;
	$pos=($line[1]+$line[2])/2;
#1	  2	   3	   4      5 	  6  	  7		  8	  9	   10 	   11  	   12	  13	         14
#chr1    1993735 1993739 65M4S   right   ACAT    read_23177      chr1    1993735 1993739 141M9S  right   ACATGGGAG	read_name
	if("$line[4]" eq "$line[11]")
	{
		if("$line[4]" eq "left" and $line[12]=~/$line[5]$/)
		{
			if($CHECK{"$line[6]"}!=1)
			{
				push(@arc_len,$len_arc);
				$CHECK{"$line[6]"}=1;
				$count_arc++;
			}
			if($CHECK{"$line[1]_$line[13]"}!=1)
			{
				push(@modern_len,$len_modern);
				$CHECK{"$line[1]_$line[13]"}=1;
				$count_modern++;
			}
		}
		elsif("$line[4]" eq "right" and $line[12]=~/^$line[5]/)
		{
			if($CHECK{"$line[6]"}!=1)
			{
				push(@arc_len,$len_arc);
				$CHECK{"$line[6]"}=1;
				$count_arc++;
			}
			if($CHECK{"$line[1]_$line[13]"}!=1)
			{
				push(@modern_len,$len_modern);
				$CHECK{"$line[1]_$line[13]"}=1;
				$count_modern++;
			}
		}
	}
	@last_line=@line;
}
