setwd("~/Downloads")
electric<-read.table("household_power_consumption.txt",sep=";",header=T,na.strings="?")
electric$Date<-as.Date(electric$Date,format="%d/%m/%Y")
electric.sub<-electric[electric$Date<=as.Date("2007-02-02")&electric$Date>=as.Date("2007-02-01"),]
electric.sub$Global_active_power<-as.numeric(electric.sub$Global_active_power)
hist(electric.sub$Global_active_power,freq=T,xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power",col="red")
dev.copy(png,'rplot1.png')
dev.off()
