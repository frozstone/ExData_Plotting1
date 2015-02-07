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

#Plot the graph between datetime column vs. Global_active_power column
png(filename = "plot2.png", width = 480, height = 480)
plot(cleandata$datetime, cleandata$Global_active_power, type="n", xlab = "", ylab="Global Active Power (kilowatts)")
lines(cleandata$datetime, cleandata$Global_active_power, type="l")
dev.off()