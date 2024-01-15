Usage:

```shell
(next_flow) hxl@hxl:~/mynextflow$ run main.nf -with-conda --read_path ./data/reads/

Nextflow 23.10.1 is available - Please consider updating your version to it
N E X T F L O W  ~  version 23.10.0
Launching `main.nf` [hungry_stonebraker] DSL2 - revision: 768118c8e2
executor >  local (18)
[35/feae46] process > DECONT (Sample1)      [100%] 2 of 2 ✔
[7a/caafca] process > Metaphlan4 (Sample1)  [100%] 2 of 2 ✔
[42/307fa9] process > Megahit (Sample1)     [100%] 2 of 2 ✔
[1e/580d28] process > Prodigal (${prefix})  [100%] 2 of 2 ✔
[03/606665] process > Cluster (${prefix})   [100%] 2 of 2 ✔
[57/78352c] process > Translate (${prefix}) [100%] 2 of 2 ✔
[58/a9aa37] process > Emapper0 (${prefix})  [100%] 2 of 2 ✔
[54/b1c258] process > Emapper1 (${prefix})  [100%] 2 of 2 ✔
[fc/e27a54] process > Abricate (${prefix})  [100%] 2 of 2 ✔
Completed at: 15-Jan-2024 14:06:08
Duration    : 5m 46s
CPU hours   : 1.5
Succeeded   : 18


```

Dirctory:

```shell
(next_flow) hxl@hxl:~/mynextflow$ tree .
.
├── data
│   └── reads
│       ├── Sample1_1.fq.gz
│       ├── Sample1_2.fq.gz
│       ├── Sample2_1.fq.gz
│       └── Sample2_2.fq.gz
├── main.nf
├── modules
│   ├── abricate.nf
│   ├── decont.nf
│   ├── growth.nf
│   ├── kegg.nf
│   ├── megahit.nf
│   ├── metaphlan4.nf
│   ├── prodigal.nf
│   └── votu.nf
├── nextflow.config
├── pipeline_output
│   ├── abricate_out
│   │   ├── card
│   │   │   ├── Sample1.card.txt
│   │   │   └── Sample2.card.txt
│   │   └── vfs
│   │       ├── Sample1.vfs.txt
│   │       └── Sample2.vfs.txt
│   ├── decont_out
│   │   ├── clean
│   │   │   ├── Sample1_fastp_1.fastq.gz
│   │   │   ├── Sample1_fastp_2.fastq.gz
│   │   │   ├── Sample2_fastp_1.fastq.gz
│   │   │   └── Sample2_fastp_2.fastq.gz
│   │   └── qc
│   │       ├── Sample1.html
│   │       ├── Sample1.json
│   │       ├── Sample2.html
│   │       └── Sample2.json
│   ├── kegg_out
│   │   ├── kegg_annotation
│   │   │   ├── Sample1.emapper.annotations
│   │   │   └── Sample2.emapper.annotations
│   │   ├── nr_gene
│   │   │   ├── Sample1.nr.fna
│   │   │   └── Sample2.nr.fna
│   │   ├── protein
│   │   │   ├── Sample1.faa
│   │   │   └── Sample2.faa
│   │   └── tmp
│   │       ├── Sample1.emapper.hits
│   │       ├── Sample1.emapper.seed_orthologs
│   │       ├── Sample2.emapper.hits
│   │       └── Sample2.emapper.seed_orthologs
│   ├── megahit_out
│   │   └── contig
│   │       └── Megahit
│   │           ├── Sample1.contigs.fa
│   │           └── Sample2.contigs.fa
│   ├── metaphlan4_out
│   │   ├── bwt
│   │   │   ├── Sample1.bt2out.bz
│   │   │   └── Sample2.bt2out.bz
│   │   └── mpl
│   │       ├── Sample1.metaphlan.txt
│   │       └── Sample2.metaphlan.txt
│   └── prodigal_out
│       └── prodigal
│           ├── cds
│           │   ├── Sample1.fna
│           │   └── Sample2.fna
│           ├── gf
│           │   ├── Sample1.gff
│           │   └── Sample2.gff
│           └── log
│               ├── Sample1.log
│               └── Sample2.log
├── process.config
└── work

27 directories, 49 files

```

