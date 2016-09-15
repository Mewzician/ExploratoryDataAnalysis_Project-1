#execute this code in the directory where the txt file resides
#read in the 2-days of data
data <- read.table("household_power_consumption.txt", 
                   sep = ";", header=FALSE,
                   skip = 66637, nrows = 2879,
                   colClasses = "character")

##pull out column names from line 1, format, and add to dataframe
colnames <- readLines("household_power_consumption.txt", 1)
colnames <- strsplit(colnames, ";", fixed = TRUE)
names(data) <- make.names(colnames[[1]])

#combine the Date and Time columns, add new column to data, 
##then convert it to POSIXlt (list type as opposed to count type)
datetime <- paste(data$Date, data$Time)
data <- cbind(data, datetime)
data$datetime <- strptime(as.character(data$datetime), "%d/%m/%Y %H:%M:%S")

#create device, then plot, make a legend, and close device
png(file = "plot3.png")
with(data, plot(datetime, Sub_metering_1, type = "l", 
                xlab = "",
                ylab = "Energy sub metering"))
lines(data$datetime, data$Sub_metering_2, col = "red")
lines(data$datetime, data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
