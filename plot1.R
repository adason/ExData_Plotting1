library(data.table)

# Read the whole dataset into pc_data. 
# Keep only the following two dates, "1/2/2007" and "2/2/2007".
# Convert the Date column to IDate class and Time column to ITime class.
pc_data <- fread("household_power_consumption.txt", sep = ";", na.strings = "?")
pc_data <- subset(pc_data, Date %in% c("1/2/2007", "2/2/2007"))
pc_data[,Date:=as.IDate(Date, format = "%d/%m/%Y")]
pc_data[,Time:=as.ITime(Time, format = "%H:%M:%S")]

# Plot histogram of variable "Global_active_power" and save to a png file.
png("plot1.png", bg = "transparent")
with(pc_data, 
     hist(Global_active_power, breaks = 12,
          col = "red", main =  "Global Active Power",
          xlab = "Global Active Power (kilowatts)")
)
dev.off()