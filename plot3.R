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

# Plot three "Sub_metering" variables vs "Datetime" on the same plot
# with different clolrs and save to a png file.
png("plot3.png", bg = "transparent")
with(pc_data, 
     plot(DateTime, Sub_metering_1, 
          type = "l", main = "", xlab = "", col = "black",
          ylab = "Energy sub metering")
)
with(pc_data, points(DateTime, Sub_metering_2, type = "l", col = "red"))
with(pc_data, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
