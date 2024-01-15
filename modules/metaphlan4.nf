params.outdir = './'

process Metaphlan4 {
	tag "${prefix}"
	cpus 8
	// publishDir params.outdir, mode: 'copy'
	publishDir "${params.outdir}/mpl/", pattern: "*.metaphlan.txt", mode: "copy", overwrite: true
	publishDir "${params.outdir}/bwt/", pattern: "*.bz", mode: "copy", overwrite: true

	conda '/home/hxl/miniconda3/envs/metaphlan4/'

	input:
	file index_path
	tuple val(prefix), file(reads1), file(reads2)

	output:
	tuple val(prefix), path("${prefix}.metaphlan.txt")
	tuple val(prefix), path("${prefix}.bt2out.bz")

	script:
	"""
	time metaphlan $reads1,$reads2 --bowtie2db $index_path --bowtie2out ${prefix}.bt2out.bz --nproc $task.cpus --input_type fastq -o ${prefix}.metaphlan.txt

	"""
}

