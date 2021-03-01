require(ggplot2)

## change the eigenvec filename
pca = read.table("attract.eigenvec")
dim(pca)

## Segment 1:
## You should modify the values in the bracket to define the ethinicity.
## Purely by eye, unless you can implement machine learning way of defining cutoffs
## Check with the ggplot image to confirm the colors and race
pca$target = as.character(rep("None"))
pca$target[ pca$V3<(-0.003) & pca$V4>-0.005 ] = "Chinese" ## modify 
pca$target[ pca$V4<(-0.029) ] = "Malay" ## modify
pca$target[ pca$V3>0.054 ] = "Indian" ## modify
table(pca$target)

## Output race prediction
## cross check with the clinical file for the race assignment. they should be similar.
race = data.frame(V1=rownames(pca),V2=pca$target)
write.table(race,file="race.txt",row.names=F,col.names=F,sep="\t",quote=FALSE)

## This is more likely the file generated after the previous step
## Two-columns tab-delimited file
## <libray id> <race>
race = read.table("race.txt")
pca$race = race$V6[match(pca$V1,race$V1)]
pca$race

table(pca$race)
head(pca)




png("PC12.png",width=1500,height=1500,res=300)
p1 = ggplot(pca,aes(x=V3,V4))+geom_point(aes(color=as.factor(target)),size=1.5)+theme_bw()+theme(panel.grid=element_blank())+xlab("PC1")+ylab("PC2")+scale_color_manual(values=c("red","purple","green","black","orange"))+theme(legend.position="bottom")
p1 = p1 +geom_hline(yintercept=c(-0.028,-0.005))+geom_vline(xintercept=c(-0.003,0.053)) ## modify accordign to the values in segment 1
print(p1)
dev.off()


chinese = pca[ pca$target=="Chinese",c("V1","V2")]
colnames(chinese)=c("FID","IID")
head(chinese)
write.table(chinese,file="chinese.txt",sep="\t",quote=FALSE,row.names=F)


malay = pca[ pca$target=="Malay",c("V1","V2")]
colnames(malay)=c("FID","IID")
head(malay)
write.table(malay,file="malay.txt",sep="\t",quote=FALSE,row.names=F)

indian = pca[ pca$target=="Indian",c("V1","V2")]
colnames(indian)=c("FID","IID")
head(indian)
write.table(indian,file="indian.txt",sep="\t",quote=FALSE,row.names=F)




seqid = read.table("../v2-ASC-seqlibraryIDs.txt",header=TRUE,sep="\t")
head(seqid)

chinese$PID = seqid$DESCRIPTION[match(chinese$FID,seqid$LIBRARY_ID)]
chinese$Etiology = rep(1)
chinese$Etiology[ grep("CSH", chinese$PID ) ] = 0

chinese.control = chinese[ chinese$Etiology==0, c(1,2)]
chinese.disease = chinese[ chinese$Etiology==1, c(1,2)]
write.table(chinese.control,file="chinese.control.txt",sep="\t",quote=FALSE,row.names=F)
write.table(chinese.disease,file="chinese.disease.txt",sep="\t",quote=FALSE,row.names=F)



malay$PID = seqid$DESCRIPTION[match(malay$FID,seqid$LIBRARY_ID)]
malay$Etiology = rep(1)
malay$Etiology[ grep("CSH", malay$PID ) ] = 0

malay.control = malay[ malay$Etiology==0, c(1,2)]
malay.disease = malay[ malay$Etiology==1, c(1,2)]
write.table(malay.control,file="malay.control.txt",sep="\t",quote=FALSE,row.names=F)
write.table(malay.disease,file="malay.disease.txt",sep="\t",quote=FALSE,row.names=F)


indian$PID = seqid$DESCRIPTION[match(indian$FID,seqid$LIBRARY_ID)]
indian$Etiology = rep(1)
indian$Etiology[ grep("CSH", indian$PID ) ] = 0

indian.control = indian[ indian$Etiology==0, c(1,2)]
indian.disease = indian[ indian$Etiology==1, c(1,2)]
write.table(indian.control,file="indian.control.txt",sep="\t",quote=FALSE,row.names=F)
write.table(indian.disease,file="indian.disease.txt",sep="\t",quote=FALSE,row.names=F)









