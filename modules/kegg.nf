params.outdir = './'

// cluster
process Cluster {
	tag '${prefix}'
	cpus 8
	publishDir "${params.outdir}/nr_gene/", pattern: "*.nr.fna", mode: "copy", overwrite: true

	input:
	tuple val(prefix), file(gene)

	output:
	tuple val(prefix), path("${prefix}.nr.fna")	

	script:
	"""
	cd-hit-est -i $gene -o ${prefix}.nr.fna -aS 0.9 -c 0.95 -G 0 -g 0 -T 0 -M 0

	"""
}


// translation
process Translate {
	tag '${prefix}'
	cpus 8
	publishDir "${params.outdir}/protein/", pattern: "*.faa", mode: "copy", overwrite: true

	input:
	tuple val(prefix), file(nrGene)

	output:
	tuple val(prefix), path("${prefix}.faa")

	script:
	"""
	transeq -sequence $nrGene -outseq ${prefix}.faa -trim Y

	"""
}


// annotation
process Emapper0 {
	tag '${prefix}'
	cpus 8
	publishDir "${params.outdir}/tmp/", pattern: "*.seed_orthologs", mode: "copy", overwrite: true
	publishDir "${params.outdir}/tmp/", pattern: "*.hits", mode: "copy", overwrite: true

	conda "/home/hxl/miniconda3/envs/eggnog-mapper/"

	input:
	tuple val(prefix), file(protein)

	output:
	tuple val(prefix), path("${prefix}.emapper.seed_orthologs")
	tuple val(prefix), path("${prefix}.emapper.hits")

	script:
	"""
	time emapper.py --no_annot --no_file_comments --override --data_dir ~/database/eggnog_db/ -i $protein --cpu $task.cpus -m diamond -o ${prefix}

	"""
}


process Emapper1 {
	tag '${prefix}'
	cpus 8
	publishDir "${params.outdir}/kegg_annotation/", pattern: "*.emapper.annotations", mode: "copy", overwrite: true
	
	conda "/home/hxl/miniconda3/envs/eggnog-mapper/"

	input:
	tuple val(prefix), file(orthologs)

	output:
	tuple val(prefix), path("${prefix}.emapper.annotations")

	script:
	"""
	emapper.py --annotate_hits_table $orthologs --data_dir ~/database/eggnog_db/ --cpu $task.cpus --no_file_comments --override -o ${prefix}

	"""
}

