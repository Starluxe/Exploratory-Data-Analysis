## Download file from web
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
workdir <- getwd()
# Check if directory exist and create if it doesn't
subfolder <- "./Project01"
if(!file.exists(subfolder)){
    dir.create(subfolder)
}

download.file(fileUrl, destfile = "./Project01/Fhousehold_power_consumption.zip")

## Unzip file
unzip("./Project01/Fhousehold_power_consumption.zip", exdir =  "./Project01")

## Read total dataset
infosize <- as.numeric(object.size(read.table("./Project01/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", 
                                              colClasses = c('character','character','numeric','numeric',
                                                             'numeric','numeric','numeric','numeric','numeric'))))
infosize <- infosize / (1024)^2
if (infosize >= memory.limit()){
    print("Memory size not enough!")
    break()
}
housepowerconstotal <- read.table("./Project01/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", 
                                  colClasses = c('character','character','numeric','numeric','numeric',
                                                 'numeric','numeric','numeric','numeric'))
housepowerconstotal$Date <- as.Date(housepowerconstotal$Date, format = "%d/%m/%Y")


## Subset data from 2007-02-01 to 2007-02-02 
hpsubset <- subset(housepowerconstotal, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
# rm(housepowerconstotal)

## Convert Date and Time to POSIXct     
hpdatetime <- paste(hpsubset$Date, hpsubset$Time)
hpsubset$datetime <- as.POSIXct(hpdatetime)

## Preapraing data


## Plot 3
with(hpsubset, {
    plot(Sub_metering_1 ~ datetime, xlab = "", ylab = "Energy sub metering",type = "l")
    lines(Sub_metering_2 ~ datetime, col = 'Red')
    lines(Sub_metering_3 ~ datetime, col = 'Blue')
})

legend("topright", col = c("black", "red", "blue"), lwd = c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Copy to flie .PNG
dev.copy(png,"./Project01/plot3.png", width=480, height=480)
dev.off()