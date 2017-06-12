datafile <- "household_power_consumption.txt"
dataset <- read.csv(datafile, sep = ";")
library(dplyr)
dataset = mutate(dataset, newDate = as.Date(Date, format = "%d/%m/%Y"))
dataset = dataset[dataset$newDate >= "2007-02-01" & dataset$newDate <= "2007-02-02",]
dataset = transmute(dataset, datetime = as.POSIXct(strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")), 
                    Global_active_power = as.numeric(as.character(Global_active_power)), 
                    Global_reactive_power = as.numeric(as.character(Global_reactive_power)), 
                    Voltage = as.numeric(as.character(Voltage)), 
                    Global_intensity = as.numeric(as.character(Global_intensity)), 
                    Sub_metering_1 = as.numeric(as.character(Sub_metering_1)), 
                    Sub_metering_2 = as.numeric(as.character(Sub_metering_2)), 
                    Sub_metering_3 = as.numeric(as.character(Sub_metering_3)))
png("plot3.png")
plot(dataset$datetime, dataset$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(dataset$datetime, dataset$Sub_metering_2, type = "l", col = "red")
lines(dataset$datetime, dataset$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd = 1, col = c("black","red","blue"))
dev.off()