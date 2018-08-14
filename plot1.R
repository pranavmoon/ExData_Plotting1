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

# c4w1p1_sub<-c4w1p1[which(c4w1p1[,"Date"]=="1/2/2007"|c4w1p1[,"Date"]=="2/2/2007"),]
c4w1p1_sub<-subset(c4w1p1, Date=="1/2/2007"|Date=="2/2/2007")

c4w1p1_sub<-transform(a_sub,Global_active_power=as.numeric(Global_active_power))
par(mfrow=c(1,1))
hist(c4w1p1_sub$Global_active_power,col="red",xlab="Global Active Power(kilowatts)",main="Global Active Power")

dev.copy(png, file="plot1.png")
dev.off()
##--------------------------------------
