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

dat$DateTime <- paste(as.character(dat[[1]]), as.character(dat[[2]]))
dat$DateTime <- strptime(dat$DateTime, "%d/%m/%Y %H:%M:%S")

### PLOTTING BELOW ###

# Plot 2: GAP vs Time (line)

png(file = "./ExData_Plotting1/plot2.png")
par(bg = NA)
with(dat, plot(DateTime, Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l"))
dev.off()