

file1=read.table("household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors = FALSE)
file1$Date=as.Date(file1$Date, format = "%d/%m/%Y") 

# We will only be using data from the dates 2007-02-01 and 2007-02-02
file1extract=rbind((file1[file1$Date=="2007-02-01",]), (file1[file1$Date=="2007-02-02",]))
file1extract$Time=strptime(file1extract$Time, format="%H:%M:%S")
file1extract[1:1440,"Time"] <- format(file1extract[1:1440,"Time"],"2007-02-01 %H:%M:%S")
file1extract[1441:2880,"Time"] <- format(file1extract[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


png(filename="plot3.png", width=480, height=480, unit="px")
plot(file1extract$Time, as.numeric(file1extract$Sub_metering_1),  
     type="l",
     xlab="",
     col="black",
     ylab="Energy sub metering")     
lines(file1extract$Time,file1extract$Sub_metering_2, col="red")
lines(file1extract$Time,file1extract$Sub_metering_3, col="blue")

legend("topright", pch ="___",  col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()