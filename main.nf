#!/usr/bin/env nextflow

Channel.fromFilePairs(params.input, checkIfExists: true)
       .set{ ch_reads }
println params.input

process FASTQC{
    publishDir "./fastqc", mode: 'copy'
    echo true
    input:
    tuple val(base), file(gato) from ch_reads

    output:
    tuple val(base), file("*.{html,zip}") into ch_multiqc

    script:
    """
    pwd
    fastqc -q $gato
    """
}


process MULTIQC{

    publishDir "./multiqc", mode: 'copy'
    echo true
    input:
    file(htmls) from ch_multiqc.collect()
    output:
    file("*html") into ch_out
    


    script:
    """
    multiqc .
    
    
    """

}

