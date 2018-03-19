MetaSUB Quality Control Pipeline
=========

This is the quality control pipeline used by MetaSUB. It has two steps
 - remove low quality bases and adapters from reads
 - rapidly align reads to the human genome and filter those that map

This pipeline is under heavy development. Most of the documentation for this pipeline is currently internal to MetaSUB.

Installation
------------

This is a ModuleUltra Pipeline. For more information on installing ModuleUltra Pipelines see the main MetaSUB_CAP repo.

Running
-------

To run the QC pipeline use the following commands

.. code-block:: bash

   cd /analysis/dir
   python /path/to/MetaSUB_CAP/add_fastq_data_to_datasuper.py <sample_type> [<fastq files>...]
   moduleultra run -p metasub_qc_cap -j <njobs> [--dryrun]
   
To see more options just use the help commands

.. code-block:: bash

   moduleultra run --help
   moduleultra --help
   datasuper --help
   
Most cluster systems will need a custom submit script. You can set a default script using the following command
   
.. code-block:: bash
   
   moduleultra config cluster_submit /path/to/submit_script

Licence
-------

MIT License

