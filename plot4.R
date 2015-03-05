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

png(file = "plot4.png",height = 480,width = 480)

#set two two rows and two columns for graphs
par(mfrow=c(2,2))


#plot first graph (top left)
plot(mydata1$Datetime, as.numeric(paste(mydata1$Global_active_power)),
     type="l",
     lty=1,
     ylab ="Global Active Power",
     xlab ="")

#plot second graph (top right)
plot(mydata1$Datetime, as.numeric(paste(mydata1$Voltage)),
     type="l",
     lty=1,
     ylab ="Voltage",
     xlab ="Datetime")

#plot third graph (bottom left)
plot(mydata1$Datetime, as.numeric(paste(mydata1$Sub_metering_1)),
     type="l",
     lty=1,
     ylab ="Energy sub metering",
     xlab =""
     
)
lines(mydata1$Datetime,as.numeric(paste(mydata1$Sub_metering_2)), 
      type='l', 
      col="red")
lines(mydata1$Datetime,as.numeric(paste(mydata1$Sub_metering_3)), 
      type='l', 
      col="blue")
legend("topright",
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),
       lty=c(1,1,1),bty = "n",adj=0.05)

#plot fourth graph (bottom right)
plot(mydata1$Datetime, as.numeric(paste(mydata1$Global_reactive_power)),
     type="l",
     lty=1,
     ylab ="Global_reactive_power",
     xlab ="Datetime")





#save graph and close device
dev.off()
