# ArcSV
A pipeline to detect SV in archaic human
<br/>
![This is an image](https://github.com/xuxif/ArcSV/blob/main/Figure1_github.png )
<br/>
##
## Workflow of ArcSV <br />
ArcSV is a unique bioinformatics tool specifically tailored for identifying structural variations (SVs) in archaic human genomes. Leveraging its specialized features, ArcSV efficiently manages the challenges posed by ancient genomic data, including shorter fragment sizes and reduced discordant reads. Hence, it emerges as the only tool for SV detection in archaic hominins.

## Software version requirements : <br />
1. samtools (Other versions need to test whether the "samtools coverage" function is included)<br />
2. bedtools v2.30.0<br />
3. python 3.8 or 3.9 <br />
4. perl v5.32.1<br />
5. bc <br />
6. xarg v4.5 (v4.8 will prompt parameter conflict）
7. bcftools
### Recommended Environment Configuration Steps
1. Insatll Anaconda in your server.
2. Install ArcSV with bioconda channel 
 
 ```
  conda install -c bioconda arcsv 
  ```
### Generate feature in archaic human sequencing data
Due to GitHub's file size limitations, we're unable to host the complete feature set. 

If you're working with sequencing data from populations not covered in our paper, we highly recommend obtaining the complete feature set. Feel free to reach out to us via email at 2623716586@qq.com, and we'll be happy to provide the full feature file.

Moreover, if you're interested in studying other archaic humans (or non-human species), you can generate a new feature file using the code provided in this repository.

```
  #Download test data in test_data folder
  ArcSV generate -i /path/to/test_data/input_arc.bam 
  ```
The feature file, named 'input_arc.bam.tsv', generated from 'input_arc.bam', is located in the 'arcBKS' directory. The content of this feature file is:
```
chr1    9999    10001   16S92M  left    AACCCTAACCCTAACC        read_3
chr1    9999    10001   3S47M   left    GTT     read_7
chr1    9999    10001   3S50M   left    ACC     read_4
chr1    9999    10001   3S63M   left    ACC     read_36
```

### Detect shared SV in archaic human
 ```
  ArcSV generate -i /path/to/test_data/input_modern.bam -r /path/to/referece_genome.fa -d /path/to/input_arc.bam.tsv -b /path/to/test_data/input.bed
  ```
Please note: The version of the reference genome used in your modern BAM, archaic human BAM files, and the value specified in '-r' should all be identical. The format of input.bed is below and the first two coloumns is required:
```
10      100891948       100891998
10      101011255       101011255
10      101016124       101016124
10      101340248       101340248
10      10135356        10135356
10      101384909       101384909
10      10150346        10150424
10      101587731       101587731
10      103048086       103048087
10      10308094        10308559
10      103175249       103175303
10      103394012       103395092
```
#### Output (shared SV)
You can find the detected SVs file in the current directory. The file ArcSV_input_modern_input_arc.tsv contain the corresponding SVs shared between the modern human and archaic human.

If the provided SV file is in VCF format, the output file will also be in VCF format (ArcSV_input_modern_input_arc.vcf). The format of the output file is detailed below:
```
#chromosome position position evidence
10      1057407 BK_right=1057436;EVIDENCE_right_ARCHAIC=3;EVIDENCE_right_MODERN=3
10      1275635 BK_left=1275625;EVIDENCE_left_ARCHAIC=7;EVIDENCE_left_MODERN=38;BK_right=1275644;EVIDENCE_right_ARCHAIC=15;EVIDENCE_right_MODERN=47
10      1292090 BK_left=1292091;EVIDENCE_left_ARCHAIC=6;EVIDENCE_left_MODERN=19;BK_right=1292108;EVIDENCE_right_ARCHAIC=8;EVIDENCE_right_MODERN=16
10      10135356        BK_left=10135357;EVIDENCE_left_ARCHAIC=8;EVIDENCE_left_MODERN=9;BK_right=10135370;EVIDENCE_right_ARCHAIC=7;EVIDENCE_right_MODERN=14
10      10493409        BK_right=10493420;EVIDENCE_right_ARCHAIC=5;EVIDENCE_right_MODERN=28
10      10708535        BK_left=10708853;EVIDENCE_left_ARCHAIC=12;EVIDENCE_left_MODERN=52
10      11484966        BK_right=11484970;EVIDENCE_right_ARCHAIC=5;EVIDENCE_right_MODERN=18
```
In the output files, the term evidence_direction refers to the side of the reads in both archaic and modern humans that are soft-clipped. 
