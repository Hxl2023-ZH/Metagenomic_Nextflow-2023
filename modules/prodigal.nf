params.outdir = './'


process Prodigal {

	tag '${prefix}'
	cpus 8
	publishDir "${params.outdir}/prodigal/cds/", pattern: "*.fna", mode: "copy", overwrite: true
	publishDir "${params.outdir}/prodigal/gf/", pattern: "*.gff", mode: "copy", overwrite: true
	publishDir "${params.outdir}/prodigal/log/", pattern: "*.log", mode: "copy", overwrite: true

	conda "/home/hxl/miniconda3/envs/prodigal/" 

	input:
	tuple val(prefix), file(contig)

	output:
	tuple val(prefix), path("${prefix}.fna")
	tuple val(prefix), path("${prefix}.gff")
	tuple val(prefix), path("${prefix}.log")

	script:
	"""
	time prodigal -i $contig -d ${prefix}.fna -o ${prefix}.gff -p meta -f gff > ${prefix}.log

	"""
}
