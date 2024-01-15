params.outdir = './'

process DECONT{
	tag "${prefix}"
	cpus 8
	publishDir "${params.outdir}/clean/", pattern: "*.fastq.gz", mode: 'copy', overwrite: true
	publishDir "${params.outdir}/qc/", pattern: "*.html", mode: "copy", overwrite: true
	publishDir "${params.outdir}/qc/", pattern: "*.json", mode: "copy", overwrite: true

	input:
	tuple val(prefix), file(reads1), file(reads2)

	output:
	tuple val(prefix), file("${prefix}_fastp_1.fastq.gz"), file("${prefix}_fastp_2.fastq.gz")
	tuple file("${prefix}.html"), file("${prefix}.json")

	script:
	"""
	fastp -i $reads1 -I $reads2 -j ${prefix}.json -h ${prefix}.html -o ${prefix}_fastp_1.fastq.gz -O ${prefix}_fastp_2.fastq.gz

	"""

}
