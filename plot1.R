
#read the file, skip the header row - we can put the header back
data <- read.table("/Users/t93ku6h/Documents/Development/coursera/ExData_Plotting1/household_power_consumption.txt",sep=";",skip=1)

#explicitly name the columns 
names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
#head(data)

#get a subset of data
sub_data <- subset(data,data$Date=="2/2/2007"|data$Date=="1/2/2007")
#head(sub_data)

#convert the "Global Active Power" column to numeric
sub_data$Global_active_power <- as.numeric(as.character(sub_data$Global_active_power))

#plot it
hist(sub_data$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")

#write to a PNG file
png_file <- "/Users/t93ku6h/Documents/Development/coursera/ExData_Plotting1/plot1.png"
dev.print(png, file = png_file, width = 400, height = 400)
dev.off()
