
rule remove_adapters:
    input:
        reads1 = getOriginResultFiles(config, "raw_short_read_dna", "read1"),
        reads2 = getOriginResultFiles(config, "raw_short_read_dna", "read2"),
    output:
        clean_reads1 = config['adapter_removal']['clean_read1'],
        clean_reads2 = config['adapter_removal']['clean_read2'],
    params:
        arem = config['adapter_removal']['exc']['filepath'],
        basename='temp_{sample_name}'
    threads: int(config['adapter_removal']['threads'])
    resources:
        time = int(config['adapter_removal']['time']),
        n_gb_ram = int(config['adapter_removal']['ram'])
    run:

        cmd = ('{params.arem} '
               '--file1 {input.reads1} '
               '--file2 {input.reads2} '
               '--trimns '
               '--trimqualities '
	       '--qualitybase 33 '
	       '--qualitymax 50 '
               '--gzip '
               '--output1 {output.clean_reads1} '
               '--output2 {output.clean_reads2} '
               '--basename {params.basename} '
               '--threads {threads} '
               '; '
               'rm {params.basename}*'
              )
        shell(cmd)


