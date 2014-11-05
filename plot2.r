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
plot(myCleanedData$DateTime, myCleanedData$Global_active_power, type = "l", ylab ="Global Active Power (kilowatts)", xlab = "")

dev.copy(png, "plot2.png", units="px", height = 480, width = 480)
dev.off()

