library(polyester)
library(Biostrings)

set.seed(42)
 
# set up transcript-by-timepoint matrix:
base <- matrix(rep(c(100,100,100,100,100,100),5), nrow=6)
depx10 <- matrix(rep(c(1000,1000,1000,1000,1000,1000),5), nrow=6)
depx100 <- matrix(rep(c(10000,10000,10000,10000,10000,10000),5), nrow=6)
dilx10 <- matrix(rep(c(100,100,100,100,100,1000),5), nrow=6)
dilx100 <- matrix(rep(c(100,100,100,100,100,10000),5), nrow=6)
all <- cbind(base, depx10, depx100, dilx10, dilx100)
 
# simulate reads:
#simulate_experiment_countmat('tp53.fa', readmat=all, outdir='tp53_reads_all', readlen=75)
