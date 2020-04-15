
library(sqldf)
library(dplyr)

# Read incoming file selecting the 2 required dates

file1 <- read.csv.sql("household_power_consumption.txt",
                      sql="select * from file where (Date == '1/2/2007' or Date == '2/2/2007') and Voltage != '?' ",
                      sep = ";")
# Convert date column into date format
file1$Date=as.Date(file1$Date, format = "%d/%m/%Y")

file1$Time=strptime(file1$Time, format="%H:%M:%S")
file1[1:1440,"Time"] <- format(file1[1:1440,"Time"],"2007-02-01 %H:%M:%S")
file1[1441:2880,"Time"] <- format(file1[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


png(filename="plot2.png", width=480, height=480, unit="px")
plot(file1$Time, as.numeric(as.character(file1$Global_active_power)),  
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")     
dev.off()