library("survival")
require(plotrix)
require(grid)
args=commandArgs(trailingOnly=TRUE)
AGE_AL=as.numeric(args[1]) # numeric
ECOG_AL=args[2] # character string, "0", "1", ">=2"
LDH_AL=args[3] # character string, "Normal", "Abnormal" 
HGB_AL=as.numeric(args[4]) # numeric
jpg_file=args[5] # path to tree output file
txt_file=args[6] # path to table output file

# input
ECOG_AL=switch(ECOG_AL,"0"=0,"1"=1,">=2"=2)
LDH_AL=switch(LDH_AL,"Normal"="N","Abnormal"="A")

mst=5.1
surv1=16
surv2=3
if(ECOG_AL<2&&HGB_AL>=11.0&&AGE_AL>=47){
  mst=7.6
  surv1=27
  surv2=8
}else if(ECOG_AL==2&&LDH_AL=="A"){
  mst=3.0
  surv1=6
  surv2=1
}
aldata0=data.frame(mst,surv1,surv2,AGE_AL,ECOG_AL,LDH_AL,HGB_AL)

# output: plot
aldata=aldata0
jpeg(jpg_file, width=37, height=20, units='cm', res=200)
plot.new()
par(mar=c(2,2,2,2))
plot.window(xlim=c(0,100),ylim=c(0,100),asp=1)
text(-49,50,"NSCLC\npatients")
lines(c(-40,-30),c(50,50),lwd=3,col=2)
ps=aldata$ECOG_AL>=2
ldh=aldata$LDH_AL=="A"
hgb=aldata$HGB_AL<11.0
age=aldata$AGE_AL<=47
lines(c(-30,-30,10),c(50,75,75),lwd=ifelse(ps,3,1),col=ifelse(ps,2,1))
lines(c(-30,-30,10),c(50,25,25),lwd=ifelse(ps,1,3),col=ifelse(ps,1,2))
text(-10,79,"Poor PS (ECOG >=2)")
text(-10,29,"Good PS (ECOG >=2)")
lines(c(10,10,45),c(75,90,90),lwd=ifelse(ps&&ldh,3,1),col=ifelse(ps&&ldh,2,1))
lines(c(10,10,45),c(75,60,60),lwd=ifelse(ps&&!ldh,3,1),col=ifelse(ps&&!ldh,2,1))
lines(c(10,10,45),c(25,45,45),lwd=ifelse(!ps&&hgb,3,1),col=ifelse(!ps&&hgb,2,1))
lines(c(10,10,40),c(25,15,15),lwd=ifelse(!ps&&!hgb,3,1),col=ifelse(!ps&&!hgb,2,1))
text(25,94,"LDH > normal")
text(25,64,"LDH normal")
text(25,49,"HGB < 11.0")
text(25,19,"HGB >= 11.0")
lines(c(40,40,75),c(15,30,30),lwd=ifelse(!ps&&!hgb&&age,3,1),col=ifelse(!ps&&!hgb&&age,2,1))
lines(c(40,40,75),c(15,0,0),lwd=ifelse(!ps&&!hgb&&!age,3,1),col=ifelse(!ps&&!hgb&&!age,2,1))
text(55,34,"Age <= 47")
text(55,4,"Age > 47")
rect(45,87,51,93,lwd=ifelse(ps&&ldh,3,1),border=ifelse(ps&&ldh,2,1))
text(48.25,90.25,"I")
rect(45,57,51,63,lwd=ifelse(ps&&!ldh,3,1),border=ifelse(ps&&!ldh,2,1))
text(48.25,60.25,"II")
rect(45,42,51,48,lwd=ifelse(!ps&&hgb,3,1),border=ifelse(!ps&&hgb,2,1))
text(48.25,45.25,"III")
rect(75,27,81,33,lwd=ifelse(!ps&&!hgb&&age,3,1),border=ifelse(!ps&&!hgb&&age,2,1))
text(78.25,30.25,"IV")
rect(75,-3,81,3,lwd=ifelse(!ps&&!hgb&&!age,3,1),border=ifelse(!ps&&!hgb&&!age,2,1))
text(78.25,0.25,"V")
lines(c(100,103,103,100),c(65,65,25,25))
text(125,45,"Same median survival\ntime and 1/2 year\nsurvival rates")
dev.off()

# output: table
aldata=aldata0
df=data.frame(aldata$mst,aldata$surv1,aldata$surv2)
colnames(df)[1]="Median Survival Time (months)"
colnames(df)[2]="1 Year Survival Rate (%)"
colnames(df)[3]="2 Year Survival Rate (%)"
write.table(df,file=txt_file,quote=F,row.names=F,sep=",")

