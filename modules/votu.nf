params.outdir = './'


process Virome {

	tag '${prefix}'
	cpus 8
	publishDir "${params.outdir}", mode: "copy", overwrite: "true"

	conda "/home/hxl/miniconda3/envs/vs2/"

	input:
	tuple val(prefix), file(contig)

	output:
	tuple val(prefix), path(result/${prefix}.fa)

	script:
	"""
	virsorter run -w result/${prefix} -i $contig --include-groups "dsDNAphage,ssDNA" --min-length 5000 -j $task.cpus all

	"""
}
