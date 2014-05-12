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
dev.copy(png, width = 480, height = 480, "plot2.png")

par(mar=c(4,4,2,2))
# Plotting DateTime vs Global Active Power
plot(myData$DateTime, myData$Global_active_power, type='l', ylab="Global Active Power (kilowatts)", xlab="")
dev.off()