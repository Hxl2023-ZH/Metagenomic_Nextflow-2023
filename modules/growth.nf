params.outdir = './'

process Growth {
	tag '${prefix}'
	cpus 8
	publishDir "${params.outdir}/grid/", mode: "copy", overwrite: "true"

	conda "/home/hxl/miniconda3/envs/grid/"
	
	input:
	tuple val(prefix), file(reads1), file(reads2)

	output:
	path("result/${prefix}.GRiD.txt")
	path("result/${prefix}.mosdepth.summary.txt")
	
	script:
	"""
	echo $reads2 > Sample_id.txt

	grid multiplex -r . -e fq.gz -l Sample_id.txt -d ~/database/Grid_db39/ -p -c 0.2 -o result -n 16

	"""


}
