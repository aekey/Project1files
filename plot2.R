dat<-read.table("household_power_consumption.txt",header=TRUE,sep=';')
dat$Date<-as.Date(dat$Date,'%d/%m/%Y')

#select date range
dat<-dat[as.Date('2007-02-01',format='%Y-%m-%d')<=dat$Date & dat$Date<=as.Date('2007-02-02',format='%Y-%m-%d'),]

#format date/time
dat$Date<-paste(dat$Date,dat$Time,sep=' ')
dat$Date<-strptime(dat$Date,'%Y-%m-%d %H:%M:%S')

#convert data to numeric
dat$Global_active_power<-as.character(dat$Global_active_power)
dat$Global_active_power[dat$Global_active_power=='?']='NA'
dat$Global_active_power<-as.numeric(dat$Global_active_power)

#make graph
png('plot2.png',width=480,height=480,units='px');
plot(dat$Date,(dat$Global_active_power),type='l',main='',xlab='',ylab='Global Active Power (kilowatts)')
dev.off()