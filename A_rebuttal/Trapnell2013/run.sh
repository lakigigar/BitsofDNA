#!/bin/bash

# OMP_NUM_THREADS=1 Rscript --vanilla --default-packages=methods,stats,utils,knitr -e 'setwd("src")' -e 'rmarkdown::render("timing.Rmd", output_file = "../timing.html")'
OMP_NUM_THREADS=1 Rscript --vanilla --default-packages=methods,stats,utils,knitr -e 'setwd("src")' -e 'rmarkdown::render("DESeq2_post.Rmd", output_file = "../DESeq_post.html")'
