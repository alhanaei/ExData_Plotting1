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
png(file = "plot1.png", bg = "transparent",height = 480,width = 480)

#plot graph 
hist(as.numeric(paste(mydata1$Global_active_power)),col= "red",main ="Global Active Power",
     xlab ="Global Active Power (in kilowatt)",)

#save graph and close device
dev.off()
