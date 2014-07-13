dat<-read.table("household_power_consumption.txt",header=TRUE,sep=';')
dat$Date<-as.Date(dat$Date,'%d/%m/%Y')

#select date range
dat<-dat[as.Date('2007-02-01',format='%Y-%m-%d')<=dat$Date & dat$Date<=as.Date('2007-02-02',format='%Y-%m-%d'),]

#format date/time
dat$Date<-paste(dat$Date,dat$Time,sep=' ')
dat$Date<-strptime(dat$Date,'%Y-%m-%d %H:%M:%S')

#convert data to numeric
dat$Global_active_power<-as.character(dat$Global_active_power)
dat$Global_reactive_power<-as.character(dat$Global_reactive_power)
dat$Voltage<-as.character(dat$Voltage)
dat$Sub_metering_1<-as.character(dat$Sub_metering_1)
dat$Sub_metering_2<-as.character(dat$Sub_metering_2)
dat$Sub_metering_3<-as.character(dat$Sub_metering_3)
dat$Global_active_power[dat$Global_active_power=='?']='NA'
dat$Global_reactive_power[dat$Global_reactive_power=='?']='NA'
dat$Voltage[dat$Voltage=='?']='NA'
dat$Sub_metering_1[dat$Sub_metering_1=='?']='NA'
dat$Sub_metering_2[dat$Sub_metering_2=='?']='NA'
dat$Sub_metering_3[dat$Sub_metering_3=='?']='NA'
dat$Global_active_power<-as.numeric(dat$Global_active_power)
dat$Global_reactive_power<-as.numeric(dat$Global_reactive_power)
dat$Voltage<-as.numeric(dat$Voltage)
dat$Sub_metering_1<-as.numeric(dat$Sub_metering_1)
dat$Sub_metering_2<-as.numeric(dat$Sub_metering_2)
dat$Sub_metering_3<-as.numeric(dat$Sub_metering_3)

png('plot4.png',height=480,width=480,units='px')
par(mfrow=c(2,2))
plot(dat$Date,(dat$Global_active_power),type='l',main='',xlab='',ylab='Global Active Power')

plot(dat$Date,dat$Voltage,type='l',main='',xlab='datetime',ylab='Voltage')

plot(dat$Date,dat$Sub_metering_1,type='l',col='black',main='',xlab='',ylab='Energy sub metering')
lines(dat$Date,dat$Sub_metering_2,type='l',col='red')
lines(dat$Date,dat$Sub_metering_3,type='l',col='blue')
legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),col=c('black','red','blue'),lty='solid',bty='n')

plot(dat$Date,dat$Global_reactive_power,type='l',main='',xlab='datetime',ylab='Global_reactive_power')

dev.off()