library(lubridate)

plot1 <- function(writeImage = TRUE) {
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
        png("plot1.png")
    }
    
    data <- read.table(
                file = "household_power_consumption.txt",
                na.strings = "?",
                header = TRUE,
                sep = ";",
                colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
    data$Date <- dmy(data$Date)
    data$Time <- hms(data$Time)
    data <- subset(data, Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))
    
    hist(
        data$Global_active_power,
        col = "red",
        xlab = "Global Active Power (kilowatts)",
        main = "Global Active Power")
    
    if (writeImage) {
        dev.off()
    }
}