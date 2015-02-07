library(plyr)

#Open and read file (specify the column classes to quicken the reading process)
sample = read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", nrows = 10, stringsAsFactors = FALSE)
cls = sapply(sample, class)
alldata = read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", colClasses = cls, na.strings = c('?'))

#Get data on 1st and 2nd February 207
cleandata = alldata[alldata$Date=='1/2/2007' | alldata$Date == '2/2/2007',]

#Plot the frequency of Global_active_power column
png(filename="plot1.png", width = 480, height = 480)
hist(cleandata$Global_active_power, col = "Red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()