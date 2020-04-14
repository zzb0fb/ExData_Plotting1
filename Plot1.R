
file1=read.table("household_power_consumption.txt", header = TRUE, sep=";")
file1$Date=as.Date(file1$Date, format = "%d/%m/%Y")

# We will only be using data from the dates 2007-02-01 and 2007-02-02
file1extract=rbind((file1[file1$Date=="2007-02-01",]), (file1[file1$Date=="2007-02-02",]))

png(filename="plot1.png", width=480, height=480, unit="px")
with(file1extract, hist(as.numeric(as.character(file1extract$Global_active_power)), 
                        col="red", 
                        main="Global Active Power", 
                        xlab="Global Active Power (kilowatts)"))
dev.off()

