# Download dataset and unzip data

if(!file.exists("./household_power_consumption.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="household_power_consumption.zip")
  unzip(zipfile="household_power_consumption.zip",exdir="./")
}

# Reading and preparing data - this should be common to all plots in this exercise

power <- read.table("household_power_consumption.txt", header=T, sep=";")
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
power_df <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
power_df$Global_active_power <- as.numeric(as.character(power_df$Global_active_power))
power_df$Global_reactive_power <- as.numeric(as.character(power_df$Global_reactive_power))
power_df$Voltage <- as.numeric(as.character(power_df$Voltage))
power_df <- transform(power_df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
power_df$Sub_metering_1 <- as.numeric(as.character(power_df$Sub_metering_1))
power_df$Sub_metering_2 <- as.numeric(as.character(power_df$Sub_metering_2))
power_df$Sub_metering_3 <- as.numeric(as.character(power_df$Sub_metering_3))

# plot 3

plot(power_df$timestamp,power_df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(power_df$timestamp,power_df$Sub_metering_2,col="red")
lines(power_df$timestamp,power_df$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

# plot3.png
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off() 