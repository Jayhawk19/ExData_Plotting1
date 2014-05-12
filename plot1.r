require("sqldf")


filename<-unzip("exdata_data_household_power_consumption.zip", overwrite = TRUE)
mySqlquery <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"

#Read data for Feb 1 and Fed 2 based on the SQL Query
myData <- read.csv2.sql(filename,mySqlquery)

#PLot the graph onto PNG
dev.copy(png, width = 480, height = 480, "plot1.png")

# Plotting frequency of  Global Active Power
hist(myData$Global_active_power, xlab="Global Active Power(kilowatts)", main ="Global Active Power", col="red")
dev.off()