sdata <- read.table("household_power_consumption.txt", nrows=5, na.strings="?", sep=";", header=TRUE)
classes <- sapply(sdata, class)
colnm <- colnames(sdata)

fconn <- file("household_power_consumption.txt")
pdata <- read.table(text = grep("^[1,2]/2/2007", readLines(fconn), value = TRUE), na.strings="?", sep = ";", header = TRUE, colClasses=classes, col.names=colnm)

png(filename="plot1.png", width=480, height=480)
hist(pdata$Global_active_power, col = "red", main = paste("Global Active Power"), xlab = "Global Active Power (kilowatts)")
dev.off()