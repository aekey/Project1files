dat<-read.table("household_power_consumption.txt",header=TRUE,sep=';')
dat$Date<-as.Date(dat$Date,'%d/%m/%Y')

#select date range
dat<-dat[as.Date('2007-02-01',format='%Y-%m-%d')<=dat$Date & dat$Date<=as.Date('2007-02-02',format='%Y-%m-%d'),]

#format date/time
dat$Date<-paste(dat$Date,dat$Time,sep=' ')
dat$Date<-strptime(dat$Date,'%Y-%m-%d %H:%M:%S')

#convert data to numeric
dat$Sub_metering_1<-as.character(dat$Sub_metering_1)
dat$Sub_metering_2<-as.character(dat$Sub_metering_2)
dat$Sub_metering_3<-as.character(dat$Sub_metering_3)
dat$Sub_metering_1[dat$Sub_metering_1=='?']='NA'
dat$Sub_metering_2[dat$Sub_metering_2=='?']='NA'
dat$Sub_metering_3[dat$Sub_metering_3=='?']='NA'
dat$Sub_metering_1<-as.numeric(dat$Sub_metering_1)
dat$Sub_metering_2<-as.numeric(dat$Sub_metering_2)
dat$Sub_metering_3<-as.numeric(dat$Sub_metering_3)

#make graph
png('plot3.png',width=480,height=480,units='px');
plot(dat$Date,dat$Sub_metering_1,type='l',col='black',main='',xlab='',ylab='Energy sub metering')
lines(dat$Date,dat$Sub_metering_2,type='l',col='red')
lines(dat$Date,dat$Sub_metering_3,type='l',col='blue')
legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),col=c('black','red','blue'),lty='solid')
dev.off()