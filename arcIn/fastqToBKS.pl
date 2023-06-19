#@soft|A00132:125:HV3KJDSXX:3:1422:13096:9204|163|chr10|10093394|60|9S141M|*|10093394|655|chr10|10093904
while(<STDIN>)
{
	chomp();
	$read_name=$_;
	$read_base=<STDIN>;chomp($read_base);
	<STDIN>;<STDIN>;
	@fields=split(/\|/,$read_name);
	$dir="left";
	if($fields[6]=~/S$/)
	{
		$dir="right";
	}
	print "$fields[3]\t$fields[8]\t$fields[6]\t$dir\t$read_base\t$fields[1]\n";
}
	
	
