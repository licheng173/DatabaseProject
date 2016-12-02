library("survival")
require(plotrix)
require(grid)
args=commandArgs(trailingOnly=TRUE)
GENDER_PAE=args[1] # character string, "Male" or "Female"
DIS_PAE=args[2] # character string, "Limited" or "Disseminated"
PS_PAE=as.numeric(args[3]) # numeric 
WBC_PAE=args[4] # character string, "Normal" or "Abnormal"
NEU_PAE=args[5] # character string, "Normal" or "Abnormal"
WL_PAE=as.numeric(args[6]) # numeric 
jpg_file=args[7] # path to plot output file
txt_file=args[8] # path to table output file
jpg_file2=args[9] # path to tree output file
txt_file2=args[10] # path to table2 output file

# input
GENDER_PAE=switch(GENDER_PAE,"Male"=TRUE,"Female"=FALSE)
DIS_PAE=switch(DIS_PAE,"Limited"=FALSE,"Disseminated"=TRUE)
PS_PAE=ifelse(PS_PAE<=70,TRUE,FALSE)
WBC_PAE=switch(WBC_PAE,"Normal"=FALSE,"Abnormal"=TRUE)
NEU_PAE=switch(NEU_PAE,"Normal"=FALSE,"Abnormal"=TRUE)
WL_PAE=ifelse(WL_PAE>5,TRUE,FALSE)

mst=26
surv1=21
surv2=5
if(!DIS_PAE&&!PS_PAE&&!GENDER_PAE){
  mst=60
  surv1=53
  surv2=27
}else if((!DIS_PAE&&!PS_PAE&&GENDER_PAE)||(DIS_PAE&&!WBC_PAE&&!NEU_PAE&&!WL_PAE)){
  mst=38
  surv1=38
  surv2=11
}else if(DIS_PAE&&WBC_PAE&&PS_PAE){
  mst=14
  surv1=10
  surv2=2
}

paedata0=data.frame(mst,surv1,surv2,GENDER_PAE,DIS_PAE,PS_PAE,WBC_PAE,NEU_PAE,WL_PAE)

# output: plot
paedata=paedata0
jpeg(jpg_file, width=20, height=13, units='cm', res=200)
mst=paedata$mst
plot.new()
plot.window(xlim=c(0,300),ylim=c(0,1))
box()
axis(1)
axis(2)
title(main="Paesmans survival curve")
title(xlab="Time (Weeks)")
title(ylab="Survival Probability")
# Group I
if(mst==60)
{
  df=data.frame("x"=c(0,3,7,12,18,19,31,31,35,35,40,41,45,45,52,52,66,68,74,74,107,107,133,133,300),"y"=c(1,1,0.95,0.92,0.92,0.83,0.83,0.78,0.78,0.74,0.74,0.64,0.64,0.58,0.58,0.53,0.53,0.34,0.34,0.27,0.27,0.22,0.22,0.16,0.16))
}else if(mst==38)
{
  df=data.frame("x"=c(0,3,6,12,19,25,38,41,43,50,52,63,75,88,104,112,120,125,150,250,300),"y"=c(1,0.98,0.93,0.86,0.79,0.685,0.52,0.47,0.44,0.40,0.38,0.3,0.22,0.16,0.11,0.1,0.085,0.08,0.06,0.05,0.05))
}else if(mst==26)
{
  df=data.frame("x"=c(0,6,12,19,25,31,38,50,52,61,63,68,75,92,100,113,118,119,125,150,200,250,300),"y"=c(1,0.865,0.775,0.625,0.52,0.42,0.325,0.24,0.21,0.17,0.15,0.14,0.11,0.08,0.06,0.04,0.035,0.0275,0.025,0.02,0.01,0.01,0.005))
}else if(mst==14)
{
  df=data.frame("x"=c(0,1,3,6,12,19,22,24,25,32,38,40,50,52,55,56,75,90,104,109,112,150,250,300),"y"=c(1,0.88,0.78,0.67,0.54,0.42,0.38,0.34,0.31,0.22,0.155,0.12,0.12,0.10,0.08,0.06,0.04,0.04,0.02,0.02,0.005,0.005,0,0))
}
lines(df,type="l",lwd=4,col="purple")

dev.off()

# output: table
paedata=paedata0
mst=paedata$mst
if(mst==60)
{
  df=data.frame(c(0,25,50,75,100,150,200),c(1,0.83,0.58,0.27,0.27,0.16,0.16))
}else if(mst==38)
{
  df=data.frame(c(0,25,50,75,100,150,200),c(1,0.68,0.41,0.22,0.13,0.06,0.05))
}else if(mst==26)
{
  df=data.frame(c(0,25,50,75,100,150,200),c(1,0.52,0.24,0.11,0.06,0.02,0.01))
}else if(mst==14)
{
  df=data.frame(c(0,25,50,75,100,150,200),c(1,0.31,0.12,0.04,0.02,0.01,0.005))
}
colnames(df)[1]="Time (Weeks)"
colnames(df)[2]="Survival Probability"
write.table(df,file=txt_file,quote=F,row.names=F,sep=",")

# output: tree
paedata=paedata0
jpeg(jpg_file2, width=31, height=20, units='cm', res=200)
gen=paedata$GENDER_PAE
dis=paedata$DIS_PAE
ps=paedata$PS_PAE
wbc=paedata$WBC_PAE
neu=paedata$NEU_PAE
wl=paedata$WL_PAE
plot.new()
  plot.window(xlim=c(0,100),ylim=c(0,100),asp=1)
  text(-43,50,"NSCLC\npatients")
  lines(c(-35,-25),c(50,50),lwd=3,col=2)
  lines(c(-25,-25,0),c(50,75,75),lwd=ifelse(dis,3,1),col=ifelse(dis,2,1))
  lines(c(-25,-25,0),c(50,35,35),lwd=ifelse(dis,1,3),col=ifelse(dis,1,2))
  text(-12.5,80,"Disseminated\ndisease")
  text(-12.5,40,"Limited\ndisease")
  lines(c(0,0,20),c(35,15,15),lwd=ifelse(!dis&&!ps,3,1),col=ifelse(!dis&&!ps,2,1))
  text(10,43,"PS <= 70")
  text(10,18,"PS >= 80")
  lines(c(20,20,120),c(15,25,25),lwd=ifelse(!dis&&!ps&&gen,3,1),col=ifelse(!dis&&!ps&&gen,2,1))
  lines(c(20,20,120),c(15,5,5),lwd=ifelse(!dis&&!ps&&!gen,3,1),col=ifelse(!dis&&!ps&&!gen,2,1))
  text(30,28,"Male")
  text(30,8,"Female")
  lines(c(0,0,30),c(75,85,85),lwd=ifelse(dis&&wbc,3,1),col=ifelse(dis&&wbc,2,1))
  lines(c(0,0,30),c(75,55,55),lwd=ifelse(dis&&!wbc,3,1),col=ifelse(dis&&!wbc,2,1))
  text(15,88,"WBC abnormal")
  text(15,58,"WBC normal")
  lines(c(30,30,120),c(85,95,95),lwd=ifelse(dis&&wbc&&ps,3,1),col=ifelse(dis&&wbc&&ps,2,1))
  lines(c(30,30,125,125),c(85,75,75,70),lwd=ifelse(dis&&wbc&&!ps,3,1),col=ifelse(dis&&wbc&&!ps,2,1))
  text(40,98,"PS <= 70")
  text(40,78,"PS >= 80")
  lines(c(30,30,120),c(55,65,65),lwd=ifelse(dis&&!wbc&&neu,3,1),col=ifelse(dis&&!wbc&&neu,2,1))
  lines(c(30,30,50),c(55,45,45),lwd=ifelse(dis&&!wbc&&!neu,3,1),col=ifelse(dis&&!wbc&&!neu,2,1))
  text(40,68,"NC abnormal")
  text(40,48,"NC normal")
  lines(c(50,50,123.3,123.3),c(45,55,55,60),lwd=ifelse(dis&&!wbc&&!neu&&wl,3,1),col=ifelse(dis&&!wbc&&!neu&&wl,2,1))
  lines(c(50,50,120),c(45,30,30),lwd=ifelse(dis&&!wbc&&!neu&&!wl,3,1),col=ifelse(dis&&!wbc&&!neu&&!wl,2,1))
  text(60,58,"WL > 5%")
  text(60,33,"WL <= 5%")
  lines(c(0,0,20,48,49,51,52,126.6,126.6),c(35,40,40,40,41,41,40,40,60),lwd=ifelse(!dis&&ps,3,1),col=ifelse(!dis&&ps,2,1))
  rect(120,0,130,10,lwd=ifelse(paedata$mst==60,3,1),border=ifelse(paedata$mst==60,2,1))
  text(125,5,"I",cex=1.5)
  rect(120,22.5,130,32.5,lwd=ifelse(paedata$mst==38,3,1),border=ifelse(paedata$mst==38,2,1))
  text(125,27.5,"II",cex=1.5)
  rect(120,60,130,70,lwd=ifelse(paedata$mst==26,3,1),border=ifelse(paedata$mst==26,2,1))
  text(125,65,"III",cex=1.5)
  rect(120,90,130,100,lwd=ifelse(paedata$mst==14,3,1),border=ifelse(paedata$mst==14,2,1))
  text(125,95,"IV",cex=1.5)
dev.off()

# output: table2
paedata=paedata0
df=data.frame(paedata$mst,paedata$surv1,paedata$surv2)
colnames(df)[1]="Median Survival Time (weeks)"
colnames(df)[2]="1 Year Survival Rate (%)"
colnames(df)[3]="2 Year Survival Rate (%)"
write.table(df,file=txt_file2,quote=F,row.names=F,sep=",")