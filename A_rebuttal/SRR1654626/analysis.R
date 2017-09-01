# Begin by downloading quantifications:
# kallisto samples from https://github.com/greenelab/continuous_analysis_rnaseq/tree/master/kallisto_output
# Salmon samples from https://github.com/COMBINE-lab/continuous_analysis_rnaseq/tree/master/salmon_output
# The analysis below works for any of the eight quantified samples. The example shown is for SRR1654626
# The kallisto abundance.tsv file has been renamed kallisto.26 and the Salmon quant.sf file has been renamed salmon.26

kal <- read.table("kallisto.26", header=TRUE)
sal <- read.table("salmon.26", header=TRUE)
colnames(sal)[1] <- "target_id"
tmp <- merge(kal, sal, by="target_id", all=FALSE)
av <- 0.5*(log2(tmp$est_counts+1)+log2(tmp$NumReads+1))
fc <- log2(tmp$est_counts+1)-log2(tmp$NumReads+1)
dat <- data.frame(tmp$est_counts,tmp$NumReads)
frac <- length(fc[abs(fc<1) & av!=0])/length(av[av !=0])

# In the command below alpha (from 0 to 1) sets the transparency

for (aleph in c(1,0.5,0.25,0.125,0.06125,0.03,0.01)){
ggplot(dat,aes(x=av,y=fc))+geom_point(alpha=aleph)+geom_hline(yintercept=1,linetype="dashed",color="red")+geom_hline(yintercept=-1,linetype="dashed",color="red")+labs(x="0.5*(log2(kallisto+1)+log2(Salmon+1))", y="log2(kallisto+1)-log2(Salmon+1)",title=paste("SRR654626 (counts), fraction =",round(frac,3)))
ggsave(paste("SRR1654626_",aleph,".jpg",sep=""))
}

#density analysis

df <- abs(log2(tmp$est_counts+1)-log2(tmp$NumReads+1))
df <- df[av != 0]
median(df)
abline(v=median(df),col="blue")
hist(df,100000,xlim=range(0,0.1),main="Differences between kallisto and Salmon",xlab="abs(log2kallisto-log2Salmon)")