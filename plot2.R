library(lubridate)

plot2 <- function(writeImage = TRUE) {
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
        png("plot2.png")
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
    
    plot(
        data$DateTime,
        data$Global_active_power,
        type = "l",
        ylab = "Global Active Power (kilowatts)",
        xlab = "")
    
    if (writeImage) {
        dev.off()
    }
}