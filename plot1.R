library(data.table)
pc_data <- fread("household_power_consumption.txt", sep = ";",
                 na.strings = "?")
pc_data <- subset(pc_data, Date %in% c("1/2/2007", "2/2/2007"))
pc_data[,Date:=as.IDate(Date, format = "%d/%m/%Y")]
pc_data[,Time:=as.ITime(Time, format = "%H:%M:%S")]

png("plot1.png", bg = "transparent")
hist(pc_data$Global_active_power, breaks = 12,
     col = "red", main =  "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()
