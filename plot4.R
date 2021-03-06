sdata <- read.table("household_power_consumption.txt", nrows=5, na.strings="?", sep=";", header=TRUE)
classes <- sapply(sdata, class)
colnm <- colnames(sdata)

fconn <- file("household_power_consumption.txt")
pdata <- read.table(text = grep("^[1,2]/2/2007", readLines(fconn), value = TRUE), na.strings="?", sep = ";", header = TRUE, colClasses=classes, col.names=colnm)
ch_datetime <- paste(as.Date(pdata$Date, format="%d/%m/%Y"), pdata$Time)
pdata$datetime <- as.POSIXct(strptime(ch_datetime, format="%Y-%m-%d %H:%M:%S"))

png(filename="plot4.png", width=480, height=480)
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(pdata, {
    plot(Global_active_power ~ datetime, type="l", ylab="Global Active Power", xlab="")
    plot(Voltage ~ datetime, type="l", ylab="Voltage", xlab="datetime")
    plot(Sub_metering_1 ~ datetime, type="l", ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2 ~ datetime, col='red')
    lines(Sub_metering_3 ~ datetime, col='blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power ~ datetime, type="l", ylab="Global_rective_power", xlab="datetime")
})
dev.off()