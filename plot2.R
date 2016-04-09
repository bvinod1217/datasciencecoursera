setwd("~/Downloads")
electric<-read.table("household_power_consumption.txt",sep=";",header=T,na.strings="?")
electric$Date<-as.Date(electric$Date,format="%d/%m/%Y")
electric.sub<-electric[electric$Date<=as.Date("2007-02-02")&electric$Date>=as.Date("2007-02-01"),]
electric.sub$Global_active_power<-as.numeric(electric.sub$Global_active_power)
electric.sub$DateTime<-as.POSIXct(paste(electric.sub$Date,electric.sub$Time),format="%Y-%m-%d %H:%M:%S")
plot(electric.sub$DateTime,electric.sub$Global_active_power,xlab="",ylab="Global Active Power (kilowatts)",main="",type="l",lwd=2)
dev.copy(png,'rplot2.png')
dev.off()
