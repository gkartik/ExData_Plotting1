# Since we need data only for 2 specific days (02/01/2007 and 02/02/2007), we'll need to calculate how many days(rows) we need to skip
# The dataset begins from 16th December 2006 17:24:00
skip_days <- 46;
skip_hours <- 6;
skip_mins <- 60-23;
mins_day <- 60*24;
mins_hour <- 60;
num_days_data_needed <- 2;

skip_nrows <- (skip_days*mins_day) + (skip_hours*mins_hour) + skip_mins;
nrows_select <- (num_days_data_needed*mins_day);

filename <- "household_power_consumption.txt";
my_colnames <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3");

selected_data <- read.table(filename, header = FALSE, sep = ";", na.strings = "?", nrows = nrows_select, skip = skip_nrows, col.names = my_colnames);

datetime <- strptime(paste(selected_data$Date, selected_data$Time, sep = " "), "%d/%m/%Y %H:%M:%OS");
selected_data$datetime <- datetime;
png("plot4.png");
par(mfcol=c(2,2));
plot(selected_data$datetime, selected_data$Global_active_power, type = "l", xlab ="", ylab = "Global Active Power");
plot(selected_data$datetime, selected_data$Sub_metering_1, type = "l", col = "black", xlab ="", ylab = "Energy sub metering");
lines(selected_data$datetime, selected_data$Sub_metering_2, type = "l", col = "red");
lines(selected_data$datetime, selected_data$Sub_metering_3, type = "l", col = "blue");
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, lwd = 1, bty = "n");
plot(selected_data$datetime, selected_data$Voltage, type = "l", xlab ="datetime", ylab = "Voltage");
plot(selected_data$datetime, selected_data$Global_reactive_power, type = "l", xlab ="datetime", ylab = "Global_reactive_power");
dev.off();
