
#read the file, skip the header row - we can put the header back
data <- read.table("household_power_consumption.txt",sep=";",skip=1)

#explicitly name the columns 
names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
#head(data)

#get a subset of data
sub_data <- subset(data,data$Date=="2/2/2007"|data$Date=="1/2/2007")
#head(sub_data)

#convert the "Global Active Power","Voltage","Global_reactive_power" columns to numeric
sub_data$Global_active_power <- as.numeric(as.character(sub_data$Global_active_power))
sub_data$Voltage <- as.numeric(as.character(sub_data$Voltage))
sub_data$Global_reactive_power <- as.numeric(as.character(sub_data$Global_reactive_power))

#concatnate date and time
sub_data$Date <- as.Date(sub_data$Date,format="%d/%m/%Y")
sub_data$Time <- strptime(paste(sub_data$Date,sub_data$Time),"%Y-%m-%d %H:%M:%S")
#convert to POSIXct format
sub_data$Time <- as.POSIXct(sub_data$Time)

# 2*2
par(mfrow=c(2,2))

#plot #1
plot(sub_data$Time,sub_data$Global_active_power,type="l",ylab="Global Active Power (kilowatts)", xlab="")

#Date/time vs Voltage
plot(sub_data$Time,sub_data$Voltage,type="l",ylab="Voltage",xlab="datetime")

#plot #3
plot(sub_data$Time,sub_data$Sub_metering_1,type="n",ylab = "Energy sub metering", xlab = "")
with(sub_data,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(sub_data,lines(Time,as.numeric(as.character(Sub_metering_2)),col="Red"))
with(sub_data,lines(Time,as.numeric(as.character(Sub_metering_3)),col="Blue"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Date/time vs Global_reactive_power
plot(sub_data$Time,sub_data$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime")

#write to a PNG file
png_file <- "plot4.png"
dev.print(png, file = png_file, width = 400, height = 400)
dev.off()
