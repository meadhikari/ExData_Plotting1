#set directory to that with household_power_consumption.txt
setwd("C:/github/proj") 

# load libraries
library(data.table)
library(lubridate)


# read from source file limiting only 2 days
  variable.class<-c(rep('character',2),rep('numeric',7))
  power.consumption<-read.table('household_power_consumption.txt',header=TRUE,
                                sep=';',na.strings='?',colClasses=variable.class)
  power.consumption<-power.consumption[power.consumption$Date=='1/2/2007' | power.consumption$Date=='2/2/2007',]

# tidy up data
  cols<-c('Date','Time','GlobalActivePower','GlobalReactivePower','Voltage','GlobalIntensity',
          'SubMetering1','SubMetering2','SubMetering3')
  colnames(power.consumption)<-cols
  power.consumption$DateTime<-dmy(power.consumption$Date)+hms(power.consumption$Time)
  power.consumption<-power.consumption[,c(10,3:9)]
  
# write tidy data to file new_power_consumption.txt
  write.table(power.consumption,file='new_power_consumption.txt',sep=';',row.names=FALSE)
 
dir.create('plot 3')

png(filename='plot 3/plot3.png',width=480,height=480,units='px')

lncol<-c('black','red','blue')
lbls<-c('Sub_metering_1','Sub_metering_2','Sub_metering_3')
plot(power.consumption$DateTime,power.consumption$SubMetering1,type='l',col=lncol[1],xlab='',ylab='Energy sub metering')
lines(power.consumption$DateTime,power.consumption$SubMetering2,col=lncol[2])
lines(power.consumption$DateTime,power.consumption$SubMetering3,col=lncol[3])

legend('topright',legend=lbls,col=lncol,lty='solid')

# Close off graphic device
x<-dev.off()