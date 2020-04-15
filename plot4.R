

file1=read.table("household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors = FALSE)
file1$Date=as.Date(file1$Date, format = "%d/%m/%Y") 

# We will only be using data from the dates 2007-02-01 and 2007-02-02
file1extract=rbind((file1[file1$Date=="2007-02-01",]), (file1[file1$Date=="2007-02-02",]))
file1extract$Time=strptime(file1extract$Time, format="%H:%M:%S")
file1extract[1:1440,"Time"] <- format(file1extract[1:1440,"Time"],"2007-02-01 %H:%M:%S")
file1extract[1441:2880,"Time"] <- format(file1extract[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


png(filename="plot4.png", width=480, height=480, unit="px")
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
#
## PLOT 1 - Global active Power vs time
plot(file1extract$Time, as.numeric(file1extract$Global_active_power),  
     type="l",
     xlab="",
     col="black",
     ylab="Global Active Power")

## PLOT 2 - Voltage vs time
plot(file1extract$Time, as.numeric(file1extract$Voltage),  
     type="l",
     col="black",
     xlab="datetime",
     ylab="Voltage")

## PLOT 3 - Energy sub metering
plot(file1extract$Time, as.numeric(file1extract$Sub_metering_1),  
     type="l",
     xlab="",
     col="black",
     ylab="Energy sub metering")     
lines(file1extract$Time,file1extract$Sub_metering_2, col="red")
lines(file1extract$Time,file1extract$Sub_metering_3, col="blue")
legend("topright", 
       pch ="___", 
       bty = "n",
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## PLOT 4 - Global reactive power vs time
plot(file1extract$Time, as.numeric(file1extract$Global_reactive_power),  
     type="l",
     col="black",
     xlab="datetime",
     ylab="Global_reactive_power")

dev.off()