args = commandArgs(TRUE)

require(data.table)
data = fread(args[1],header=FALSE,sep="\t")
names(data)=c("gid","variant")
statistics = as.data.frame(table(data$gid))
names(statistics)=c("gene","count")
write.table(statistics,file="vargene.count",sep="\t",quote=FALSE,row.names=F)
