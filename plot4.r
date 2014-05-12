require("sqldf")
filename<-unzip("exdata_data_household_power_consumption.zip", overwrite = TRUE)
mySqlquery <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"

#Read data for Feb 1 and Fed 2 based on the SQL Query
myData <- read.csv2.sql(filename,mySqlquery)


#Add new column to teh myData dataframe to proces datetime over weekdays
myData["DateTime"]<-NA
#Format Datetime with strptimr function
myData$DateTime <- strptime(paste(myData$Date, myData$Time), format = '%d/%m/%Y %H:%M:%S')

#PLot the graph onto PNG
dev.copy(png, width = 480, height = 480, "plot4.png")

par(mar=c(4,4,2,2))
#Split PLot in 2 x 2  onto PNG
par(mfrow =c(2,2))

#Plot c(1,1)
plot(myData$DateTime, myData$Global_active_power, type='l', ylab="Global Active Power", xlab="")

#Plot c(1,2)
plot(myData$DateTime, myData$Voltage, type='l', ylab="Voltage", xlab="")

#Plot c(2,1)
plot(myData$DateTime, myData$Sub_metering_1, type='l', ylab="Energy sub metering", xlab="")
lines(myData$DateTime, myData$Sub_metering_2, type='l', col="red")
lines(myData$DateTime, myData$Sub_metering_3, type='l', col="blue")
legend("topright", bty="n",cex=0.75, lty=c(1,1,1), col= c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#Plot c(2,2)
plot(myData$DateTime, myData$Global_reactive_power, type='l', ylab="Global_reactive_power", xlab="")

dev.off()