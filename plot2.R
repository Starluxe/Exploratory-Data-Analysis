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
infosize <- as.numeric(object.size(read.table("./Project01/household_power_consumption.txt", header = TRUE, sep = ";")))
infosize <- infosize / (1024)^2
if (infosize >= memory.limit()){
    print("Memory size not enough!")
    break()
}
housepowerconstotal <- read.table("./Project01/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "NA")
housepowerconstotal$Date <- as.Date(housepowerconstotal$Date, format = "%d/%m/%Y")
housepowerconstotal$Global_active_power <- as.numeric(levels(housepowerconstotal$Global_active_power)[housepowerconstotal$Global_active_power])

## Subset data from 2007-02-01 to 2007-02-02 
hpsubset <- subset(housepowerconstotal, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(housepowerconstotal)

## Convert Date and Time to POSIXct     
hpdatetime <- paste(hpsubset$Date, hpsubset$Time)
hpsubset$datetime <- as.POSIXct(hpdatetime)

## Plot 2
hpsubset$Global_active_power <- as.numeric(hpsubset$Global_active_power)
plot(hpsubset$Global_active_power ~ hpsubset$datetime, xlab = "", ylab = "Global Active Power (kilowatts)",type = "l")

## Copy to file .PNG
dev.copy(png,"./Project01/plot2.png", width=480, height=480)
dev.off()