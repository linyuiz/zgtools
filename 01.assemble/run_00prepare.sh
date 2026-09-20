#!/bin/bash
🚀zgtools/overdose
Usage:

        overdose run_T2T example_cfg

        Run_T2T.cfg      --Run Config(You'd use 'example_cfg' to make cfg)
        before_juicebox  --Run Steps
        plant            --Species Type
        
Example1:

        overdose run_T2T example_cfg

Example2:

        overdose run_T2T Run_T2T.cfg before_HIC

Flows:

        data_stat-->nt_blast-->assemble-->HIC-->ragtag-->syntenic_check-->rDNA_telo_check-->juicebox-->makechr-->ngenomesyn-->rDNA_telo_check-->recall_rDNA-->join_check-->re-makechr-->rename_ID-->rDNA_telo_check-->join_check-->re-syntenic_check-->gapcloser-->telofix-->T2T_polish-->syntenic-->assessment-->hicplot

Steps:

        before_assemble-->before_initial_assessment-->before_HIC-->before_juicebox-->before_re-makechr-->before_rename_ID-->before_gapcloser-->before_telofix-->before_T2T_polish-->before_syntenic-->before_assessment-->before_hicplot
