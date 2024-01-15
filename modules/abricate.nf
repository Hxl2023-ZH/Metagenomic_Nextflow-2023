params.outdir = './'

// Bacteria VFs
process Abricate {
	tag '${prefix}'
	cpus 8
	publishDir "${params.outdir}/vfs/", pattern: "*.vfs.txt", mode: "copy", overwrite: true
	publishDir "${params.outdir}/card/", pattern: "*.card.txt", mode: "copy", overwrite: true

	conda "/home/hxl/miniconda3/envs/abricate/"

	input:
	tuple val(prefix), file(dna)
	
	output:
	tuple val(prefix), path("${prefix}.vfs.txt")
	tuple val(prefix), path("${prefix}.card.txt")

	script:
	"""
	abricate --db vfdb --quiet --threads $task.cpus $dna > ${prefix}.vfs.txt

	abricate --db card --quiet --threads $task.cpus $dna > ${prefix}.card.txt

	"""
}
