#!/usr/bin/env nextflow

Channel.fromFilePairs("dummy_files/SRR000*_R{1,2}.fastq.gz")
       .into{ch_fwd;ch_rev}

forward_reads = ch_fwd.map{ it -> [it[0], it[1][0]] }.view()

