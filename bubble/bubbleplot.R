#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
if (length(args)!=3) {
  st_sentence=paste("This script requires  exactly 3  arguments",length(args),"supplied\n")
  stop(sentence, call.=FALSE)
}

bubbleplot<-function(MatData,VirData,palette,magn,main,space)
{
        COL=ncol(MatData)
        ROW=nrow(MatData)
        Mcopy=rep(1:COL,ROW)
        Mfactor=rep(1:ROW,rep( COL,ROW ))

        COLOR=rep(palette,rep(COL,ROW))
        CEX=(log10(t((MatData*100)+1)))*magn


        par(mar=c(8,4,4,0),fig=c(0,0.8,0,1))
        plot(Mcopy,Mfactor,cex=0.1,pch=20,xaxt="n",yaxt="n",xlab="",ylab="",main=main,yaxs="r");
        #grid(COL*ROW)
        abline(h=1:ROW)
        abline(v=1:COL)
        lines(Mcopy,Mfactor,cex=CEX,col=COLOR,pch=20,type="p")

        axis(1,at=1:COL,labels=colnames(MatData),las=2)
        axis(2,at=(1:ROW),labels=rownames(MatData),las=2)

        par(fig=c(0.8,1,0,1),new=TRUE,mar=c(8,0,4,1))
        barplot(log10(VirData+1),horiz=T,las=2,space=space,yaxs="i",main="Log(N genomes)")
}
MatData=read.table("MatData.csv",header=T,row.names=1,check.names=F);
VirData=read.table("VirData.csv",header=T,row.names=1);
VirData=as.vector(VirData[,1])
add_data=read.table(args[1],header=T,row.names=1,check.names=F);
VirData=c(VirData,rep(1,nrow(add_data) ))
MatData=rbind(MatData,add_data);
pdf(args[2],width=1200,height=1600)
bubbleplot(MatData,VirData,c(colors()[c(90,60,150,120,30)],topo.colors(nrow(add_data))),3,main="",space=1)
dev.off()
pdf(args[3],width=1600,height=1600)
heatmap(cor(t(MatData)),col=blues9);
dev.off()
