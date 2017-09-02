# Begin by downloading kallisto and Salmon quantifications for ERR188140 from
# https://www.dropbox.com/s/wgdhzeewotwsnyy/joint.txt?dl=0
# The script begins by reading in this file (joint.txt)

# Perform an analysis comparing default kallisto with Salmon run with --gcBias

df <- read.table("joint.txt",header=TRUE)
av <- 0.5*log2(df[,10]+1)+0.5*log2(df[,26]+1)
fc <- log2(df[,10]+1)-log2(df[,26]+1)
dat <- data.frame(av,fc)
frac <- length(fc[abs(fc<1) & av!=0])/length(av[av !=0])

# In the command below alpha (from 0 to 1) sets the transparency

for (aleph in c(1,0.5,0.25,0.125,0.06125,0.03,0.01)){
ggplot(dat,aes(x=av,y=fc))+geom_point(alpha=aleph)+geom_hline(yintercept=1,linetype="dashed",color="red")+geom_hline(yintercept=-1,linetype="dashed",color="red")+labs(x="0.5*(log2(kallisto+1)+log2(Salmon+1))", y="log2(kallisto+1)-log2(Salmon+1)",title=paste("ERR188140 (counts), fraction =",round(frac,3)))
ggsave(paste("ERR188140_",aleph,".jpg",sep=""))
}

# Calculate fraction inside red lines for default kallisto vs. default Salmon

av <- 0.5*log2(df[,10]+1)+0.5*log2(df[,15]+1)
fc <- log2(df[,10]+1)-log2(df[,15]+1)
frac <- length(fc[abs(fc<1) & av!=0])/length(av[av !=0])