library(sqldf)
library(dplyr)

# Read incoming file selecting the 2 required dates

file1 <- read.csv.sql("household_power_consumption.txt",
                       sql="select * from file where (Date == '1/2/2007' or Date == '2/2/2007') and Voltage != '?' ",
                       sep = ";")


# Convert date column into date format
file1$Date=as.Date(file1$Date, format = "%d/%m/%Y")

# Open png device and create required histogram
png(filename="plot1.png", width=480, height=480, unit="px")
with(file1, hist(as.numeric(as.character(file1$Global_active_power)), 
                        col="red", 
                        main="Global Active Power", 
                        xlab="Global Active Power (kilowatts)"))
dev.off()

