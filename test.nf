#!/usr/bin/env nextflow

Channel.fromFilePairs(params.input, checkIfExists: true)
       .set{ ch_reads }
println params.input

process FASTQC{
    publishDir "./fastqc", mode: 'copy'
    echo true
    input:
    tuple val(base), file(reads) from ch_reads

    output:
    tuple val(base), file("*.{html,zip}") into ch_multiqc

    script:
    """
    pwd
    fastqc -q $reads
    """
}

