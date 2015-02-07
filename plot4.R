library(plyr)

#Open and read file (specify the column classes to quicken the reading process)
sample = read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", nrows = 10, stringsAsFactors = FALSE)
cls = sapply(sample, class)
alldata = read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", colClasses = cls, na.strings = c('?'))

#Get data on 1st and 2nd February 207
cleandata = alldata[alldata$Date=='1/2/2007' | alldata$Date == '2/2/2007',]

#Create a datetime column by combining "Date" and "Time" columns
cleandata = mutate(cleandata, datetime = paste(cleandata$Date, cleandata$Time, sep = " "))
cleandata$datetime = strptime(x = cleandata$datetime, format = "%d/%m/%Y %H:%M:%S")

#plot
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

#Upper left plot
plot(cleandata$datetime, cleandata$Global_active_power, type="n", xlab = "", ylab="Global Active Power")
lines(cleandata$datetime, cleandata$Global_active_power, type="l")

#Upper right plot
plot(cleandata$datetime, cleandata$Voltage, type="n", xlab = "datetime", ylab="Voltage")
lines(cleandata$datetime, cleandata$Voltage, type="l")

#Bottom left plot
plot(cleandata$datetime, cleandata$Sub_metering_1, type="n", xlab="", ylab = "Energy sub meeting")
lines(cleandata$datetime, cleandata$Sub_metering_1)
lines(cleandata$datetime, cleandata$Sub_metering_2, col="Red")
lines(cleandata$datetime, cleandata$Sub_metering_3, col="Blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), box.lwd = 0, lwd=c(1, 1, 1), col=c("Black", "Red", "Blue"))

#Bottom right plot
plot(cleandata$datetime, cleandata$Global_reactive_power, type="n", xlab = "datetime", ylab="Global_reactive_power")
lines(cleandata$datetime, cleandata$Global_reactive_power, type="l")
dev.off()