#!/bin/bash
🚀zgtools/overdose
Usage:

        overdose run_anno example_cfg

        Run_Anno.cfg        --Run Config(You'd use 'example_cfg' to make cfg)
        do_all              --Run Steps

Example1:

        overdose run_anno example_cfg

Example2:

        overdose run_anno Run_Anno.cfg do_all

Flow:

        Repeat-->ncRNA-->Trans-->Denovo-->Homo-->Integrate-->Circos-->FuncAnno

Steps:

        before_ncRNA-->before_TransAnno-->before_DenovoAnno-->before_HomoAnno-->before_IntegrateAnno-->before_Circos-->before_FuncAnno
                
