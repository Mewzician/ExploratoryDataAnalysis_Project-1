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

##to plot var it must be numeric, not character 
data$Global_active_power <- as.numeric(data$Global_active_power)

#create device, then plot and close device
png(file = "plot1.png")
hist(data$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()
