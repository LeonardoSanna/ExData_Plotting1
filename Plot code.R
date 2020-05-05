data_source <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- "plot-week-1.zip"
download.file(data_source, destfile = file)
dataset <- unzip(file)
dataset

power_cons <- read.table("./household_power_consumption.txt", header=TRUE, 
                         sep=";", stringsAsFactors=FALSE, dec=".")

#variables
active_power <- subset(power_cons, Date=="1/2/2007" | Date =="2/2/2007")
datetime <- strptime(paste(active_power$Date, active_power$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
global <- as.numeric(active_power$Global_active_power)
reactive_power <- as.numeric(active_power$Global_reactive_power)
voltage <- as.numeric(active_power$Voltage)
subMetering1 <- as.numeric(active_power$Sub_metering_1)
subMetering2 <- as.numeric(active_power$Sub_metering_2)
subMetering3 <- as.numeric(active_power$Sub_metering_3)



#plot 1

png("plot1.png", width=480, height=480)
hist(as.numeric(active_power$Global_active_power), col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

#plot2
png("plot2.png", width=480, height=480)
plot(datetime, global, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()


#plot3


png("plot3.png", width=480, height=480)
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()

#plot  4

png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2)) 

plot(datetime, global, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()