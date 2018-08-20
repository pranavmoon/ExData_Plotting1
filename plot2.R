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

print("We will only be using data from the dates 2007-02-01 and 2007-02-02.")

c4w1p1_sub<-subset(c4w1p1, Date=="1/2/2007"|Date=="2/2/2007")  #data: 1/2/07 t0 2/2/07

c4w1p1_sub<-transform(c4w1p1_sub,Global_active_power=as.numeric(Global_active_power))

library(dplyr)

#add a column of date and time togegher
c4w1p1_sub[,datetime:=paste(c4w1p1_sub$Date,c4w1p1_sub$Time,sep=" ")]  
c4w1p1_sub<-transform(c4w1p1_sub,datetime=as.POSIXct(datetime, format="%d/%m/%Y %H:%M:%S"))
par(mfrow=c(1,1))
plot(c4w1p1_sub$Global_active_power~c4w1p1_sub$datetime ,type="l",ylab="Global Active Power (kilowatts)",xlab=" ")

dev.copy(png, file="plot2.png")
dev.off()