library("survival")
require(plotrix)
require(grid)
args=commandArgs(trailingOnly=TRUE)
GENDER_FIN=args[1] # character string, "Male" or "Female"
HIST_FIN=args[2] # character string, "Adenocarcinoma or Squamous cell carcinoma" or "Large cell carcinoma"
ECOG_FIN=args[3] # character string, "0" or ">=1" 
SUB_FIN=as.numeric(args[4]) # numeric
BONE_FIN=as.numeric(args[5]) # numeric
LIVER_FIN=as.numeric(args[6]) # numeric
PAIN_FIN=as.numeric(args[7]) # numeric
WL_FIN=as.numeric(args[8]) # numeric
jpg_file=args[9] # path to plot output file
txt_file=args[10] # path to txt output file

# input
GENDER_FIN=switch(GENDER_FIN,"Male"=0,"Female"=0.67)
LC_FIN=switch(HIST_FIN,"Adenocarcinoma or Squamous cell carcinoma"=0.69,
              "Large cell carcinoma"=0)
ECOG_FIN=switch(ECOG_FIN,"0"=1.02,">=1"=0)
SUB_FIN=(!SUB_FIN)*1.08
BONE_FIN=(!BONE_FIN)*0.99
LIVER_FIN=(!LIVER_FIN)*0.57
PAIN_FIN=(!PAIN_FIN)*0.68
if(WL_FIN>=5) {WL_FIN=0} else {WL_FIN=0.61}
score=GENDER_FIN+LC_FIN+ECOG_FIN+SUB_FIN+BONE_FIN+LIVER_FIN+PAIN_FIN+WL_FIN-5.58
pval=1-1/(1+exp(score))
findata0=data.frame(score,pval)

# output: plot
findata=findata0
jpeg(jpg_file, width=20, height=20, units='cm', res=200)
plot.new()
plot.window(xlim=c(-6,1),ylim=c(0,0.8))
axis(1)
axis(2)
title(main="Finkelstein model")
title(xlab="Factor Score")
title(ylab="Calculated Value")
box()
x=seq(-7,3,by=0.1)
lines(x,y=1-1/(1+exp(x)),type="l",lwd=4,col="purple")
lines(c(-10,10),c(0.18,0.18),col="red")
lines(c(findata$score,findata$score),c(-1,findata$pval),col="purple")
lines(c(-7,findata$score),c(findata$pval,findata$pval),col="purple")
legend(-6,0.8,c("Patient","One-year survival threshold"),lty=c(1,1),lwd=c(1,1),col=c("purple","red"))
dev.off()

# output: text
findata=findata0
text="The model predicts that the patient will not survive 1 year."
if(findata$pval>0.18)
  text="The model predicts that the patient will survive 1 year."
write.table(text,file=txt_file,quote=F,row.names=F,sep="\t",col.names=F)

