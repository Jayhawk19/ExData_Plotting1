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
dev.copy(png, width = 480, height = 480, "plot3.png")
par(mar=c(4,4,2,2))

#PLot 3 graphs into a single plot onto PNG
plot(myData$DateTime, myData$Sub_metering_1, type='l', ylab="Energy sub metering", xlab="")
lines(myData$DateTime, myData$Sub_metering_2, type='l', col="red")
lines(myData$DateTime, myData$Sub_metering_3, type='l', col="blue")
legend("topright", lty=c(1,1,1), col= c("black", "red", "blue"), legend = c("sub_metering_1","sub_metering_2","sub_metering_3"))
dev.off()