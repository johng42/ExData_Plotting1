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

# Just get the Feb 1 and Feb 2 data from 2007 
myDataFrame$Date <- as.Date(myDataFrame$Date, format="%d/%m/%Y")
myCleanedData <- subset(myDataFrame, myDataFrame$Date == "2007-02-01" | myDataFrame$Date == "2007-02-02")

# have to set the background to clear
par(bg="transparent") 
# just use the same colors as the sample image
plot(myCleanedData$DateTime, myCleanedData$Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab = "")
lines(myCleanedData$DateTime, myCleanedData$Sub_metering_2, type = "l", col = "red")
lines(myCleanedData$DateTime, myCleanedData$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       lty = 1,pt.cex = .5, cex = 1
)

dev.copy(png, "plot3.png", units="px", width = 480, height = 480)
dev.off()
