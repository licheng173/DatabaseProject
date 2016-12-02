library("survival")
require(plotrix)
require(grid)
args=commandArgs(trailingOnly=TRUE)
MET_HOANG=args[1] # character string, "0", "1", "2", "3", ">=4"
SUB_HOANG=as.numeric(args[2]) # numeric
LIVER_HOANG=as.numeric(args[3]) # numeric
ECOG_HOANG=args[4] # character string, "0", "1", ">=2"
APP_HOANG=as.numeric(args[5]) # numeric
LUNG_HOANG=as.numeric(args[6]) # numeric
jpg_file=args[7] # path to plot output file
txt_file=args[8] # path to table output file

# input
MET_HOANG=switch(MET_HOANG,"0"=0,"1"=0,"2"=0,"3"=0,">=4"=19)
SUB_HOANG=SUB_HOANG*66
LIVER_HOANG=LIVER_HOANG*35
ECOG_HOANG=switch(ECOG_HOANG,"0"=0,"1"=1,">=2"=1)
APP_HOANG=APP_HOANG*38
LUNG_HOANG=LUNG_HOANG*15
points=MET_HOANG+SUB_HOANG+LIVER_HOANG+ECOG_HOANG*43+APP_HOANG+LUNG_HOANG
x=points
y1=-2.471438875e-17*x^9+2.571294045e-14*x^8-1.123981941e-11*x^7+2.67637254e-9*x^6-3.76012201e-7*x^5+3.146180878e-5*x^4-1.487423465e-3*x^3+3.385587076e-2*x^2-5.670003457e-1*x+55.38098878
y2=-5.289938165e-10*x^5+3.135276102e-7*x^4-7.69813389e-5*x^3+1.076444248e-2*x^2-9.476479986e-1*x+41.57430684
if(x>=160.8)
{
  y2=0.2/10^(5*(x-160.8)/69)
}else 
{
  if(x<=62) {y2=5.217469349e-5*x^3-4.28769596e-3*x^2-2.439619928e-1*x+29.17285647}
}
hoangdata0=data.frame(points,y1,y2)

# output: plot
hoangdata=hoangdata0
jpeg(jpg_file, width=20, height=17, units='cm', res=200)
points=hoangdata$points
plot.new()
plot.window(xlim=c(0,220),ylim=c(0,60))
axis(1)
axis(2)
title(main=paste("Nomograph regression model\ntotal points =",points))
title(xlab="Total Points")
title(ylab="Survival Probability (%)")
box()
x=seq(0,216,by=0.1)
lines(x,y=-2.471438875e-17*x^9+2.571294045e-14*x^8-1.123981941e-11*x^7+2.67637254e-9*x^6-3.76012201e-7*x^5+3.146180878e-5*x^4-1.487423465e-3*x^3+3.385587076e-2*x^2-5.670003457e-1*x+55.38098878
      ,type="l",lwd=4,col="purple")
x=seq(0,62,by=0.1)
lines(x,y=5.217469349e-5*x^3-4.28769596e-3*x^2-2.439619928e-1*x+29.17285647
      ,type="l",lwd=4,col="red")
x=seq(62,160.8,by=0.1)
lines(x,y=-5.289938165e-10*x^5+3.135276102e-7*x^4-7.69813389e-5*x^3+1.076444248e-2*x^2-9.476479986e-1*x+41.57430684
      ,type="l",lwd=4,col="red")
x=seq(160.8,216,by=0.1)
lines(x,y=0.2/10^(5*(x-160.8)/69)
      ,type="l",lwd=4,col="red")
y1=hoangdata$y1
lines(c(points,points),c(-10,y1),lwd=1)
lines(c(-10,points),c(y1,y1),lwd=1,col="purple")
y2=hoangdata$y2
lines(c(-10,points),c(y2,y2),lwd=1,col="red")
legend(120,55,c("One-year","Two-year"),lty=c(1,1),lwd=c(4,4),col=c("purple","red"))
dev.off()

# output: table
hoangdata=hoangdata0
df=data.frame(hoangdata$points,round(hoangdata$y1,d=2),round(hoangdata$y2,d=2))
colnames(df)[1]="Points"
colnames(df)[2]="One-year survival rate (%)"
colnames(df)[3]="Two-year survival rate (%)"
write.table(df,file=txt_file,quote=F,row.names=F,sep=",")
