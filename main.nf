#!/usr/bin/env nextflow

// DSL 2 syntax
nextflow.enable.dsl=2

// parameters
params.help = false
params.read_path = "${workflow.projectDir}/data"

// parametres decont
params.decont_outdir = './pipeline_output/decont_out'

// parameters metaphlan4
params.metaphlan4_refpath = '/home/hxl/database/metaphlan4_db/'
params.metaphlan4_outdir = './pipeline_output/metaphlan4_out'
ch_metaphlan4_idx = file(params.metaphlan4_refpath)

// parameters megahit
params.megahit_outdir = './pipeline_output/megahit_out'

// parameters prodigal
params.prodigal_outdir = './pipeline_output/prodigal_out'

// parameters kegg
params.kegg_outdir = './pipeline_output/kegg_out'

params.abricate_outdir = './pipeline_output/abricate_out'
params.growth_outdir = './pipeline_output/growth_out'

// ***
include {DECONT} from './modules/decont.nf' params(outdir: "${params.decont_outdir}")
include {Metaphlan4} from './modules/metaphlan4.nf' params(outdir: "$params.metaphlan4_outdir")
include {Megahit} from './modules/megahit.nf' params(outdir: "$params.megahit_outdir")
include {Prodigal} from './modules/prodigal' params(outdir: "$params.prodigal_outdir")
include {Cluster; Translate; Emapper0; Emapper1} from './modules/kegg.nf' params(outdir: "$params.kegg_outdir")
include {Abricate} from './modules/abricate.nf' params(outdir: "$params.abricate_outdir")
include {Growth} from './modules/growth.nf' params(outdir: "$params.growth_outdir" )

// help message
def helpMessage() {
	log.info"""
	==================================================================
	Usage: "${workflow.projectDir}/main.nf} --read_path /PATH/OF/READS
	==================================================================
	""".stripIndent()
}

if (params.help){
	helpMessage()
	exit 0
}

// Create channel for reads
ch_reads = Channel.fromFilePairs(params.read_path + '/**{1,2}.f*q*', flat: true)


workflow{
	DECONT(ch_reads)
	DECONT.out[0].view()
	Metaphlan4(ch_metaphlan4_idx, DECONT.out[0])
	Megahit(DECONT.out[0])
	Prodigal(Megahit.out[0])
	Cluster(Prodigal.out[0])
	Translate(Cluster.out[0])
	Emapper0(Translate.out[0])
	Emapper1(Emapper0.out[0])
	
	Abricate(Cluster.out[0])
}

