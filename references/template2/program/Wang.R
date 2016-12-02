library("survival")
require(plotrix)
require(grid)
load("figures.RData")
args=commandArgs(trailingOnly=TRUE)
GENDER=args[1] # character string, "Male" or "Female"
DIAGHIST=args[2] # character string, "Adenocarcinoma or Squamous cell carcinoma" or "Large cell carcinoma"
ECOGSCOR=args[3] # character string,"0", "1", "2", ">=3"
PERITON=as.numeric(args[4]) # boolean
SKIN=as.numeric(args[5]) # boolean
LIVER=as.numeric(args[6]) # boolean
HGB=as.numeric(args[7]) # numeric
WBC=as.numeric(args[8]) # numeric
LYMPH=as.numeric(args[9]) # numeric
jpg_file=args[10] # path to plot output file
txt_file=args[11] # path to table output file

# input
GENDER=switch(GENDER,"Male"="M","Female"="F")
LC=switch(DIAGHIST,"Adenocarcinoma or Squamous cell carcinoma"=0,
          "Large cell carcinoma"=1)
ECOGSCOR=switch(ECOGSCOR,"0"=0,"1"=1,"2"=2,">=3"=3)
PERITON=PERITON*1
SKIN=SKIN*1
LIVER=LIVER*1
HGB=HGB
WBC=log(WBC)
LYMPH=LYMPH/100

coefs=abs(coef(summary(fit))[,1])
risk=(GENDER=="M")*coefs["GENDERM"]+LC*coefs["LC"]+
  ECOGSCOR*coefs["ECOGSCOR"]+LIVER*coefs["LIVER"]+SKIN*coefs["SKIN"]+
  (18-HGB)*coefs["HGB"]+(WBC-1)*coefs["WBC"]+(1-LYMPH)*coefs["LYMPH"]+
  PERITON*coefs["PERITON"]
newdata0=data.frame(GENDER,LC,ECOGSCOR,SKIN,LIVER,HGB,WBC,LYMPH,PERITON,risk)

# output: plot
newdata=newdata0
pred=survfit(fit,newdata=newdata)
jpeg(jpg_file, width=20, height=13, units='cm', res=200)
plot(pred$time,pred$surv,ylim=c(0,1),xlab="Time (Months)",ylab="Survival Probability",
     main=paste("Kaplan Meier estimator\nrisk score =",round(newdata$risk,d=2)),type="l",lwd=4,
     col="purple")
dev.off()

# output: table
newdata=newdata0
pred=survfit(fit,newdata=newdata)
times=c(pred$time)
probs=c(pred$surv)
Time=c(0, 6, 12, 18, 24, 30)
Survival_Probability=c(probs[which.min(abs(times-0))],probs[which.min(abs(times-6))],probs[which.min(abs(times-12))],
                       probs[which.min(abs(times-18))],probs[which.min(abs(times-24))],probs[which.min(abs(times-30))])
Time=data.frame(Time, round(Survival_Probability,d=3))
colnames(Time)[1]="Time (Months)"
colnames(Time)[2]="Survival Probability"
write.table(Time,file=txt_file,quote=F,row.names=F,sep=",")


