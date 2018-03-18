

rule methyl_make_blastm8:
    input:
        reads1 = config['filter_human_dna']['nonhuman_read1'],
        reads2 = config['filter_human_dna']['nonhuman_read2'],
        dmnd_db = config['align_to_methyltransferases']['dmnd']['filepath']
    output:
        m8 = config['align_to_methyltransferases']['m8']
    threads: int(config['align_to_methyltransferases']['dmnd']['threads'])
    params:
        dmnd = config['diamond']['exc']['filepath'],
        bsize=int(config['align_to_methyltransferases']['dmnd']['block_size']),
    resources:
        time=int(config['align_to_methyltransferases']['dmnd']['time']),
        n_gb_ram=int(config['align_to_methyltransferases']['dmnd']['ram'])
    run:
        cmd = ('{params.dmnd} blastx '
               '--threads {threads} '
               '-d {input.dmnd_db} '
               '-q {input.reads1} '
               '--block-size {params.bsize} '
               '> {output.m8} ') 
        shell(cmd)


rule methyl_quantify:
    input:
        m8 = config['align_to_methyltransferases']['m8'],
        readstats = config['read_stats']['json'],
        ags = config['microbe_census']['stats'],
        fasta = config['align_to_methyltransferases']['fasta_db']['filepath']
    output:
        tbl = config['align_to_methyltransferases']['table']
    params:
        script = config['align_to_methyltransferases']['script'],
    run:
        cmd = ('{params.script} '
               '-s {input.readstats} '
               '-a {input.ags} '
               '-f {input.fasta} '
               '{input.m8} '
               '> {output.tbl} ') 
        shell(cmd)