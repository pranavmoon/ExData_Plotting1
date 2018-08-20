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
str(c4w1p1)
print("We will only be using data from the dates 2007-02-01 and 2007-02-02.")
c4w1p1_sub<-subset(c4w1p1, Date=="1/2/2007"|Date=="2/2/2007")

c4w1p1_sub<-transform(c4w1p1_sub,Sub_meterning_1=as.numeric(Sub_metering_1))
c4w1p1_sub<-transform(c4w1p1_sub,Sub_meterning_2=as.numeric(Sub_metering_2))
c4w1p1_sub<-transform(c4w1p1_sub,Sub_meterning_3=as.numeric(Sub_metering_3))

library(dplyr)

#add a column of date and time togegher
c4w1p1_sub[,datetime:=paste(c4w1p1_sub$Date,c4w1p1_sub$Time,sep=" ")]  
c4w1p1_sub<-transform(c4w1p1_sub,datetime=as.POSIXct(datetime, format="%d/%m/%Y %H:%M:%S"))


str(c4w1p1_sub)
par(mfrow=c(1,1))
library(gridExtra)
png("plot3.png",width=480,height=480)

plot(c4w1p1_sub$Sub_metering_1~c4w1p1_sub$datetime,type="l",ylab="Energy sub metering",xlab=" ")
lines(c4w1p1_sub$Sub_metering_2~c4w1p1_sub$datetime,col="red")
lines(c4w1p1_sub$Sub_metering_3~c4w1p1_sub$datetime,col="blue")
#axis(1,at=c(0,1441,2880),labels = c("Thu","Fri","Sat"))
legend("topright",lty=1,xjust=1,cex=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#dev.copy(png, width=480,height=480,file="plot3_ex.png")
dev.off()