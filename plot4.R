library(data.table)

# Read the whole dataset into pc_data. 
# Keep only the following two dates, "1/2/2007" and "2/2/2007".
# Convert the Date column to IDate class and Time column to ITime class.
pc_data <- fread("household_power_consumption.txt", sep = ";",
                 na.strings = "?")
pc_data <- subset(pc_data, Date %in% c("1/2/2007", "2/2/2007"))
pc_data[,Date:=as.IDate(Date, format = "%d/%m/%Y")]
pc_data[,Time:=as.ITime(Time, format = "%H:%M:%S")]

# Add DateTime colume that combines Date and Time column. Useful for plotting
pc_data[, DateTime:=as.POSIXct(Time, tz = "UTC", date = Date)]

# Setup a 2 by 2 grid for plotting and open png device
png("plot4.png", bg = "transparent")
par(mfcol = c(2,2))

# Make topleft plot. Same as plot2.
with(pc_data, 
     plot(DateTime, Global_active_power,
          type = "l", main = "", xlab = "", ylab = "Global Active Power")
)

# Make bottomleft plot. Same as plot3.
with(pc_data,
    {plot(DateTime, Sub_metering_1, 
          type = "l", main = "", xlab = "", col = "black",
          ylab = "Energy sub metering")
     points(DateTime, Sub_metering_2, type = "l", col = "red")
     points(DateTime, Sub_metering_3, type = "l", col = "blue")
     legend("topright", lty = 1, col = c("black", "red", "blue"), 
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

# Make topright plot. Plot "Voltage" vs "Datetime"
with(pc_data, 
     plot(DateTime, Voltage,
          type = "l", main = "", xlab = "datetime")
)

# Make bottomright plot. Plot "Global_reactive_power" vs "Datetime"
with(pc_data, 
     plot(DateTime, Global_reactive_power,
          type = "l", main = "", xlab = "datetime")
)

dev.off()
