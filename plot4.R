library(lubridate)

plot4 <- function(writeImage = TRUE) {
    ## Download Data
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    if (!file.exists("data.zip") ){
        download.file( url, destfile = "data.zip", mode = "wb")
    }
    if (!file.exists("household_power_consumption.txt")){
        unzip("data.zip")
    }
    
    ## Generate Plot
    if (writeImage) {
        png("plot4.png")
    }
    
    data <- read.table(
        file = "household_power_consumption.txt",
        na.strings = "?",
        header = TRUE,
        sep = ";",
        colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
    data$DateTime <- dmy_hms(with(data, paste(Date, Time)))
    data$Date <- dmy(data$Date)
    data$Time <- hms(data$Time)
    data <- subset(data, Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))
    
    par( mfcol = c(2, 2) )
    
    plot(
        data$DateTime,
        data$Global_active_power,
        type = "l",
        ylab = "Global Active Power",
        xlab = "")
    
    plot(
        data$DateTime,
        data$Sub_metering_1,
        type = "l",
        xlab = "",
        ylab = "Energy sub metering")
    lines(
        data$DateTime,
        data$Sub_metering_2,
        col = "red")
    lines(
        data$DateTime,
        data$Sub_metering_3,
        col = "blue")
    legend(
        "topright",
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        col = c("black", "red", "blue"),
        lwd = c(1, 1, 1))
    
    plot(
        data$DateTime,
        data$Voltage,
        type = "l",
        xlab = "datetime",
        ylab = "Voltage")
    
    plot(
        data$DateTime,
        data$Global_reactive_power,
        type = "l",
        xlab = "datetime",
        ylab = "Global_reactive_power")
    
    if (writeImage) {
        dev.off()
    }
}