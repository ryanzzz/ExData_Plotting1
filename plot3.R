sdata <- read.table("household_power_consumption.txt", nrows=5, na.strings="?", sep=";", header=TRUE)
classes <- sapply(sdata, class)
colnm <- colnames(sdata)

fconn <- file("household_power_consumption.txt")
pdata <- read.table(text = grep("^[1,2]/2/2007", readLines(fconn), value = TRUE), na.strings="?", sep = ";", header = TRUE, colClasses=classes, col.names=colnm)
ch_datetime <- paste(as.Date(pdata$Date, format="%d/%m/%Y"), pdata$Time)
pdata$datetime <- as.POSIXct(strptime(ch_datetime, format="%Y-%m-%d %H:%M:%S"))

png(filename="plot3.png", width=480, height=480)
plot(pdata$datetime, pdata$Sub_metering_1, type="l", ylab="Global Active Power (kilowatts)", xlab="")
lines(pdata$datetime, pdata$Sub_metering_2, col="red")
lines(pdata$datetime, pdata$Sub_metering_3, col="blue")
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()