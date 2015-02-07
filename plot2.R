sdata <- read.table("household_power_consumption.txt", nrows=5, na.strings="?", sep=";", header=TRUE)
classes <- sapply(sdata, class)
colnm <- colnames(sdata)

fconn <- file("household_power_consumption.txt")
pdata <- read.table(text = grep("^[1,2]/2/2007", readLines(fconn), value = TRUE), na.strings="?", sep = ";", header = TRUE, colClasses=classes, col.names=colnm)
ch_datetime <- paste(as.Date(pdata$Date, format="%d/%m/%Y"), pdata$Time)
pdata$datetime <- as.POSIXct(strptime(ch_datetime, format="%Y-%m-%d %H:%M:%S"))

png(filename="plot2.png", width=480, height=480)
plot(pdata$datetime, pdata$Global_active_power, type="l", ylab="Global Average Power (kilowatts)", xlab="")
dev.off()