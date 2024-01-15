params.outdir = './'

process Megahit {
	tag "${prefix}"
	cpus 8
	publishDir "${params.outdir}/contig/", mode: "copy", overwrite: true
	
	conda "/home/hxl/miniconda3/envs/megahit/"

	input:
	tuple val(prefix), file(reads1), file(reads2)

	output:
	tuple val(prefix), path("Megahit/${prefix}.contigs.fa")

	script:
	"""
	time megahit -t $task.cpus -m 0.9 --k-min 29 --min-contig-len 1000 -1 $reads1 -2 $reads2 -o Megahit --out-prefix ${prefix}

	"""
}
