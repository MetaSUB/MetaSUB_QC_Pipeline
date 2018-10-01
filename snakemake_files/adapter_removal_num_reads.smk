

rule count_adapter_removal_reads:
    input:
        reads1 = config['adapter_removal']['clean_read1'],
    output:
        count = config['adapter_removal_num_reads']['num_reads'],
    run:
        cmd = (
            'div4() { divide_by_four $1; }; '
            'zcat {input.reads1} | '
            ' wc -l | '
            'div4 > {output.count} '
        )
        shell(cmd)