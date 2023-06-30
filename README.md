# ArcSV
A pipeline to detect SV in archaic human
<br/>
![This is an image](https://github.com/xuxif/ArcSV/blob/main/Figure1_github.png )
<br/>
##
## Workflow of ArcSV <br />
ArcSV is a unique bioinformatics tool specifically tailored for identifying structural variations (SVs) in archaic human genomes. Leveraging its specialized features, ArcSV efficiently manages the challenges posed by ancient genomic data, including shorter fragment sizes and reduced discordant reads. Hence, it emerges as the only tool for SV detection in archaic hominins.

## Software version requirements : <br />
1. samtools 1.15.1 (Other versions need to test whether the "samtools coverage" function is included)<br />
2. bedtools v2.30.0<br />
3. python 3.8 or 3.9 <br />
4. perl v5.32.1<br />
5. bc <br />
6. xarg v4.5 (v4.8 will prompt parameter conflict）
### Recommended Environment Configuration Steps
1. Insatll Anaconda in your server.
2. Create a new conda environment 
 
 ```
  conda env create -n ArcSV 
  conda activate ArcSV
 ```
 <br />
 
3. Conda install samtools, bedtools
 
 ```
  conda install samtools bedtools  bwa -y
  ```
4. Clone ArcSV
 
 ```
  git clone git@github.com:xuxif/ArcSV.git
  ```
### Generate feature in archaic human sequencing data
In this repository, we've included a partial feature set for three archaic humans. Due to GitHub's file size limitations, we're unable to host the complete feature set. However, rest assured that the features we have provided include all loci identified in our related paper.

If you're working with sequencing data from populations not covered in our paper, we highly recommend obtaining the complete feature set. Feel free to reach out to us via email at 2623716586@qq.com, and we'll be happy to provide the full feature file.

Moreover, if you're interested in studying other archaic humans (or non-human species), you can generate a new feature file using the code provided in this repository.
```
  cd arcIn
  bash generateBKSinArc.sh -i /path/to/your/archaic.bam 
  ```

### Detect shared SV in archaic human
 ```
  cd arcIn/generateBKSinBam
  bash order.sh /path/to/your/modern_human.bam -r /path/to/your/reference.fa -b /path/to/your/breakpoint.tsv
  ```
The version of reference genome is GRCh38 (HG38). The format of breakpoint.tsv is below and the first two coloumns is required:
```
chr1    948661  1/1     HG01529
chr1    998785  0/1     HG01529
chr1    1068732 0/1     HG01529
chr1    1124043 0/1     HG01529
chr1    1240648 0/1     HG01529
chr1    1477837 1/1     HG01529
chr1    1565630 0/1     HG01529
chr1    1595081 0/1     HG01529
chr1    1595093 0/1     HG01529
chr1    1667010 1/1     HG01529
```
#### Output (shared SV)
You can find the detected structural variations (SVs) in the BKSinBAM_oneBP file. The files bamfile_dan.tsv, bamfile_Altai.tsv, and bamfile_Vindija.tsv contain the corresponding SVs shared between the bamfile and three archaic humans, respectively.

The format of the output file is detailed below:
```
#chromosome position position evidence_direction count1 count2
chr1    948661  948663  left    1       16
chr1    1068834 1068836 right   1       5
chr1    1565630 1565632 left    1       11
chr1    1595103 1595105 right   1       4
chr1    2147719 2147721 left    1       1
chr1    3176298 3176300 right   1       12
chr1    3181552 3181554 left    1       1
chr1    3502017 3502019 left    4       12
chr1    3502089 3502091 right   2       12
```
In the output files, the term evidence_direction refers to the side of the reads in both archaic and modern humans that are soft-clipped. The term count1 represents the count of reads in the archaic human that support the identified SV, while count2 refers to the count of reads in the modern human that support the same SV.
