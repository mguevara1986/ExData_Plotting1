rm(list = ls())
library(data.table)

##Loading the data
#Make sure the txt file is in the same folder where this code is
#We will only be using data from the dates 2007-02-01 and 2007-02-02 (Split first 66637 rows)
#Measurements are made with a one-minute sampling rate. 2 days = 48hours*60min/hour = 2880
headers_hpc <- names(read.table("household_power_consumption.txt",sep = ";", header = TRUE, nrows=1))
hpc <- read.table("household_power_consumption.txt", 
                  header = FALSE, sep= ";", dec = ".", na.strings = "?", 
                  skip = 66637,
                  nrows=2880)
hpc_old<-names(hpc)
setnames(hpc,old = hpc_old,new = headers_hpc)
rm(hpc_old, headers_hpc)

#Convert the Date and Time variables to Date/Time classes
hpc$Date <- as.character(hpc$Date)
hpc$Time <- as.character(hpc$Time)
hpc$DateTime <- paste(hpc$Date, hpc$Time)
hpc$Date <- NULL
hpc$Time <- NULL
hpc$DateTime<-as.POSIXct(hpc$DateTime, format = "%d/%m/%Y %H:%M:%S")

##PLot Time Series
Sys.setlocale("LC_ALL", "en_GB.UTF-8") # change locale to English so that labels are plotted in English
par(bg = "transparent")
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(Global_active_power ~ DateTime, hpc, ylab="Global Active Power (Kilowatts)", 
     type="l", xlab = "")
dev.off()