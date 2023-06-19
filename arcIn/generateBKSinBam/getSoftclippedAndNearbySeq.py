import sys
import pysam
import numpy as np

# Get the input filename from the command line
bamfile= sys.argv[1]
region= sys.argv[2]
ref= sys.argv[3]
output_filename = bamfile+ ".fastq"
if region:
    try:
        chrom, region = region.split(":")
        start, end = map(int, region.split("-"))
    except:
        print("Error: Invalid region argument. Please provide a region in the format 'chr:start-end'.", file=sys.stderr)
        sys.exit(1)
if bamfile.endswith(".bam"):
    bamfile = pysam.AlignmentFile(bamfile, "rb")
elif bamfile.endswith(".cram"):
    ref = pysam.FastaFile(ref)
    bamfile = pysam.AlignmentFile(bamfile, "rc", reference_filename=ref.filename)
else:
    print("Error: Input file format not recognized. Please provide a BAM or CRAM file.", file=sys.stderr)
    sys.exit(1)


# Construct the output filename by appending ".fastq" to the input filename

# Open the input BAM file
reads=bamfile.fetch(chrom, start, end, until_eof=True)

# Open the output FASTQ file
output_file = open(output_filename, "w")

# Loop through each read in the BAM file
for read in reads:
    # Check if the read is soft-clipped
    if read.is_unmapped :
        continue
    if read.cigartuples[0][0] == 4 or read.cigartuples[-1][0] == 4:
        # Get the soft-clipped sequence and nearby 30 bases sequence
        if read.cigartuples[0][0] == 4:
            soft_clipped_seq = read.query_sequence[:read.cigartuples[0][1]]
            nearby_start = read.cigartuples[0][1]
            if len(soft_clipped_seq) > 30:
                soft_clipped_seq = soft_clipped_seq[:30]
                nearby_start = 30
            nearby_end = min(nearby_start + 30, len(read.query_sequence) - len(soft_clipped_seq))
            nearby_seq = read.query_sequence[nearby_start:nearby_end]
            qual_scores = read.query_qualities[(read.cigartuples[0][1]-len(soft_clipped_seq)):(read.cigartuples[0][1]+len(nearby_seq))]
        # Convert the integer quality scores to ASCII characters
            qual_chars = "".join([chr(q + 33) for q in qual_scores])
        # Output the soft-clipped sequence and nearby 30 bases sequence in FASTQ format
            print("@{}\n{}\n+\n{}".format(read.query_name, soft_clipped_seq + nearby_seq, qual_chars))
        else:
            soft_clipped_seq = read.query_sequence[-read.cigartuples[-1][1]:]
            nearby_end = len(read.query_sequence) - read.cigartuples[-1][1]
            if len(soft_clipped_seq) > 30:
                soft_clipped_seq = soft_clipped_seq[-30:]
                nearby_end = len(soft_clipped_seq) - 30
            nearby_start = max(nearby_end - 30, len(soft_clipped_seq))
            nearby_seq = read.query_sequence[nearby_start:nearby_end]
            if -read.cigartuples[-1][1]+len(soft_clipped_seq) ==0:
                qual_scores = read.query_qualities[(-read.cigartuples[-1][1]-len(nearby_seq)):]
            else :
                qual_scores = read.query_qualities[(-read.cigartuples[-1][1]-len(nearby_seq)):(-read.cigartuples[-1][1]+len(soft_clipped_seq))]
        # Convert the integer quality scores to ASCII characters
            qual_chars = "".join([chr(q + 33) for q in qual_scores])
        # Output the soft-clipped sequence and nearby 30 bases sequence in FASTQ format
            print("@{}\n{}\n+\n{}".format(read.query_name, nearby_seq+soft_clipped_seq , qual_chars))

