#read file into data.frame

myfile<-"household_power_consumption.txt"
mydata <-read.csv(myfile,sep = ";")
dsize<-object.size(mydata)


#subsetting data to selected dates
mydata1<-mydata[mydata$Date=="1/2/2007"|mydata$Date=="2/2/2007",]


#create Datetime variable, delete Date and Time variable
mydata1$Datetime<- as.POSIXct(strptime(paste(mydata1$Date,mydata1$Time),format ="%d/%m/%Y %H:%M:%S"),tz = "")

mydata1$Time<-NULL
mydata1$Date<-NULL




# open device for plot

png(file = "plot3.png", bg = "transparent",height = 480,width = 480)

#plot graph sub_metering_1
plot(mydata1$Datetime, as.numeric(paste(mydata1$Sub_metering_1)),
     type="l",
     lty=1,
     ylab ="Energy sub metering",
     xlab =""
)
#add sub_metering_2
lines(mydata1$Datetime,as.numeric(paste(mydata1$Sub_metering_2)), 
      type='l', 
      col="red")
#add sub_metering_3
lines(mydata1$Datetime,as.numeric(paste(mydata1$Sub_metering_3)), 
      type='l', 
      col="blue")
#add legend
legend("topright",
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),
       lty=c(1,1,1))



#save graph and close device
dev.off()
