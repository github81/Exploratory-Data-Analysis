
#read the file, skip the header row - we can put the header back
data <- read.table("household_power_consumption.txt",sep=";",skip=1)

#explicitly name the columns 
names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
#head(data)

#get a subset of data
sub_data <- subset(data,data$Date=="2/2/2007"|data$Date=="1/2/2007")
#head(sub_data)

#convert the "Global Active Power" column to numeric
sub_data$Global_active_power <- as.numeric(as.character(sub_data$Global_active_power))

#concatnate date and time
sub_data$Date <- as.Date(sub_data$Date,format="%d/%m/%Y")
sub_data$Time <- strptime(paste(sub_data$Date,sub_data$Time),"%Y-%m-%d %H:%M:%S")
#convert to POSIXct format
sub_data$Time <- as.POSIXct(sub_data$Time)

head(sub_data)

#plot it
plot(sub_data$Time,sub_data$Global_active_power,type="l",ylab = "Global Active Power (kilowatts)", xlab = "")

#write to a PNG file
png_file <- "plot2.png"
dev.print(png, file = png_file, width = 400, height = 400)
dev.off()
