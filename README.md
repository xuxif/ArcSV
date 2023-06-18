# ArcSV
A pipeline to detect SV in archaic human
<br/>
![This is an image](https://github.com/xuxif/ArcSV/blob/main/archaic_fig1.png)
<br/>
##
## Workflow of ArcSV <br />
ArcSV is a unique bioinformatics tool specifically tailored for identifying structural variations (SVs) in archaic human genomes. Leveraging its specialized features, ArcSV efficiently manages the challenges posed by ancient genomic data, including shorter fragment sizes and reduced discordant reads. Hence, it emerges as the only tool for SV detection in archaic hominins.

## Software version requirements (without docker): <br />
1. samtools 1.15.1 (Other versions need to test whether the "samtools coverage" function is included)<br />
2. bedtools v2.30.0<br />
3. pysam 0.17.0<br />
4. python 3.8 or 3.9 <br />
5. perl v5.32.1<br />
6. bc <br />
7. Anaconda <br />
8. xarg v4.5 (v4.8 will prompt parameter conflict）
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
  conda install samtools bedtools  bwa -y
  ```
