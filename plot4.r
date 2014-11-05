# Frst, read the file Which needs to be named "exdata_data_household_power_consumption" (no quotes)
# and needs to be in the current working folder
# the colClasses information was gained from inspection of the file
myDataFrame <- read.table( "household_power_consumption.txt", 
                           header = T, 
                           sep = ";",
                           na.strings = "?", 
                           stringsAsFactors = F,
                           colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

# create a datetime field that will be used for plotting
myDataFrame$DateTime <- strptime(paste(myDataFrame$Date, myDataFrame$Time), format="%d/%m/%Y %H:%M:%S")

# Just get the Feb 1 and Feb 2 data from 2007 and add to new Date column
myDataFrame$Date <- as.Date(myDataFrame$Date, format="%d/%m/%Y")
myCleanedData <- subset(myDataFrame, myDataFrame$Date == "2007-02-01" | myDataFrame$Date == "2007-02-02")

# make a 2x2 grid that has transparent background
par(mfrow = c(2, 2), ps = 12,bg="transparent")
with(myCleanedData,
{ plot(myCleanedData$DateTime, myCleanedData$Global_active_power, type = "l",
       ylab = "Global Active Power", xlab = "") #plot1
  plot(myCleanedData$DateTime, myCleanedData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage") #plot 2
  plot(myCleanedData$DateTime, myCleanedData$Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab = "") #plot3
  lines(myCleanedData$DateTime, myCleanedData$Sub_metering_2, type = "l", col = "red") #plot 3 cont
  lines(myCleanedData$DateTime, myCleanedData$Sub_metering_3, type = "l", col = "blue") #plot 3 cont
  legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, #plot 3 cont
         pt.cex = .5, cex = .5, box.lty = 1, box.lwd = 1, bty = "n") #plot 3 cont
  plot(myCleanedData$DateTime, myCleanedData$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power") #plot 4
})

dev.copy(png, "plot4.png", units="px", width = 480, height = 480)
dev.off()
