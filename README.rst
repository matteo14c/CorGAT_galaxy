CorGAT_galaxy
=============

Galaxy tools and wrappers for `CorGAT <https://github.com/matteo14c/CorGAT>`_


--------------
``nucmer_snp``
--------------

:Description:
        This simple wrapper is used to align a SARS-CoV-2 genome assembly to the reference genome as available from Genbank (NC_045512).This wrapper run nucmer with default parameters to align genomes. Variants are extracted from the nucmer delta file by the show-snps utility.Output files obtained from this software should be concatenated with the join_nucmer utility before functional annotation.

:Galaxy wrapper: `nucmer_snp <https://testtoolshed.g2.bx.psu.edu/repository?repository_id=85898cb9600a48e0>`_

---------------
``join_nucmer``
---------------

:Description:
        This tool is used to merge variant calls, in nucmer format, into a single tabular file. The output file will have as may columns as the number of genomes provided in input. And as many rows as the number of variants observed in the genomes. For every genome assembly and variant a simple binary code 1= present, 0=absent will be used to indicate whether that genome carries a specific variant.This table should be provided to the FunAnn tool to obtain the functional annotation of the variants. 
:Galaxy wrapper: `join_nucmer <https://testtoolshed.g2.bx.psu.edu/repository?repository_id=5b9f056619e4a36b>`_

----------
``FunAnn``
----------

:Description:
       This program reads a tabular formatted file, in pseudo vcf format, as obtained from the **join_nucmer** utility and performs functional annotation of SARS-CoV-2 variants. Please notice that the program performs minimum error checks, and that it is designed to work exclusively with the reference annotation of the SARS-CoV-2 genome as available from Genbank.
 
:Galaxy wrapper: `FunAnn <https://testtoolshed.g2.bx.psu.edu/repository?repository_id=0e8d0775db86a736>`_
