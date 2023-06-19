#chr1    1993735 1993739 65M4S   right   ACAT    read_23177      chr1    1993735 1993739 141M9S  right   ACATGGGAG
while(<STDIN>)
{
	chomp();
	@line=split(/\t/,$_);
	$pos=($line[1]+$line[2])/2;
	if("$line[4]" eq "$line[11]")
	{
		if("$line[4]" eq "left" and $line[12]=~/$line[5]$/)
		{
			print "$line[0]\t$pos\t$line[4]\t$line[6]\n";
		}
		elsif("$line[4]" eq "right" and $line[12]=~/^$line[5]/)
		{
			print "$line[0]\t$pos\t$line[4]\t$line[6]\n";
		}
	}
}
