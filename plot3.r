## Exploratory Data Analysis Course Project 1 : Plot 2

# Check if data file is existed, download it if it is not 
if (!file.exists("household_power_consumption.txt")){
        message("Downloading data")
        fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip&method=DOWNLOAD"
        filename <- "household_power_consumption.zip" 
        download.file(fileurl, filename , method = "curl")
        unzip(filename)
}

# Read data from file
filename <- "household_power_consumption.txt"
ColClasses <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")

dataset <- read.table(filename, header=TRUE, sep=";", skip = 66636, nrow = 2820, colClasses = ColClasses,na.strings = c("?") )
dataset$DateTime <- NA

# Add descriptive names
colNames <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3", "DataTime")
names(dataset) <- colNames

# Format data and time
dataset$Date <- as.Date(dataset$Date,format="%d/%m/%Y") 
dataset$Time <- format(dataset$Time,format = "%X" )

# Merge Data with Time
dataset$DateTime <- as.POSIXct(strptime(paste(dataset$Date, dataset$Time), "%Y-%m-%d %H:%M:%S"))

# Constract Plot3 and save it to the file
png(filename = "plot3.png",width = 480,height = 480, units = "px")
plot(dataset$DateTime, dataset$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = " ")
lines(dataset$DateTime, dataset$Sub_metering_2, type = "l", col = "red")
lines(dataset$DateTime, dataset$Sub_metering_3, type = "l", col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty =c(1,1,1))
dev.off()
