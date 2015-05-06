# Exploratory Data Analysis -- Coursera
# Course Project 1

### FOR REPRODUCABILITY ###

# Dataset source: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

dat_loc <- "household_power_consumption.txt"
# Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.
# The dataset has 2,075,259 rows and 9 columns.
# We will only be using data from the dates 2007-02-01 and 2007-02-02.

# dat starts from 16/12/06 17:24 and there is one row for each minute.
# We can therefore work how how many rows to skip to reach 01/02/2007
first_obs <- read.table(dat_loc, sep=";", header=TRUE, nrows=1)[c(1,2)]
first_obs_char <- paste(as.character(first_obs[[1]]), as.character(first_obs[[2]]))
first_obs_date <- strptime(first_obs_char, "%d/%m/%Y %H:%M:%S")
first_int_date <- as.POSIXlt("2007-02-01")
nrowskip <- as.double(difftime(first_int_date, first_obs_date, units="min"))

# Load only data that we will need.
nrows <- 60*24*2 # Number of minutes in 2 days
dat <- read.table(dat_loc, sep=";", header=FALSE, skip=nrowskip + 1, nrows=nrows, na.strings = "?") # +1 for header
header <- read.table(dat_loc, sep=";", header=FALSE, nrows=1, stringsAsFactors = FALSE)
colnames(dat) <- unlist(header)

### PLOTTING BELOW ###

# Plot 4: Multiple plots

png(file = "./ExData_Plotting1/plot4.png")
par(bg = NA, mfrow = c(2, 2))
with(dat, plot(DateTime, Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l"))
with(dat, plot(DateTime, Voltage, xlab = "datetime", type = "l"))
with(dat, plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n"))
with(dat, lines(DateTime, Sub_metering_1, col = "black"))
with(dat, lines(DateTime, Sub_metering_2, col = "red"))
with(dat, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
with(dat, plot(DateTime, Global_reactive_power, xlab = "datetime", type = "l"))
dev.off()