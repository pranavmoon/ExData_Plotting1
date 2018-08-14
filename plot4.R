## Course: EDA-week-1Project
rm("exdata_data_household_power_consumption.zip")
rm("household_power_consumption")
dataurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename<-"exdata_data_household_power_consumption.zip"
download.file(dataurl,filename)
unzip("exdata_data_household_power_consumption.zip")
##-----------------------------------------------------
library(data.table)
c4w1p1<-fread("household_power_consumption.txt")
#str(c4w1p1)
print("We will only be using data from the dates 2007-02-01 and 2007-02-02.")
c4w1p1_sub<-subset(c4w1p1, Date=="1/2/2007"|Date=="2/2/2007")

c4w1p1_sub<-transform(c4w1p1_sub,Global_active_power=as.numeric(Global_active_power))
c4w1p1_sub<-transform(c4w1p1_sub,Sub_meterning_1=as.numeric(Sub_metering_1))
c4w1p1_sub<-transform(c4w1p1_sub,Sub_meterning_2=as.numeric(Sub_metering_2))
c4w1p1_sub<-transform(c4w1p1_sub,Sub_meterning_3=as.numeric(Sub_metering_3))
c4w1p1_sub<-transform(c4w1p1_sub,Voltage=as.numeric( Voltage))
c4w1p1_sub<-transform(c4w1p1_sub,Global_reactive_power=as.numeric(Global_reactive_power))

library(gridExtra)

png("plot4.png",width=480,height=480)

par(mfrow=c(2,2))
with(c4w1p1_sub, 
     {plot(Global_active_power,type="l",ylab="Global Active Power",xlab=" ",xaxt="n")
       axis(1,at=c(0,1441,2880),labels = c("Thu","Fri","Sat"))
       plot(Voltage,type="l",ylab="Voltage",xlab="datetime ",xaxt="n")
       axis(1,at=c(0,1441,2880),labels = c("Thu","Fri","Sat"))
       plot(Sub_metering_1,type="l",ylab="Energy sub metering",xlab=" ",xaxt="n")
       lines(c4w1p1_sub$Sub_metering_2,col="red")
       lines(c4w1p1_sub$Sub_metering_3,col="blue")
       legend("topright",lty=1,cex=.9,bty="n",col=c("black","red","blue"),legend=c("Sub_meterning_1","Sub_meterning_2","Sub_meterning_3"))
       axis(1,at=c(0,1441,2880),labels = c("Thu","Fri","Sat"))
       plot(Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime ",xaxt="n")
       axis(1,at=c(0,1441,2880),labels = c("Thu","Fri","Sat"))
     })  
#dev.copy(png, width=480,height=480,file="plot4_ex.png")
dev.off()
par(mfrow=c(1,1))