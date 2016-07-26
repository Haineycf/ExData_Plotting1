#this script will produce graphs for the Coursera Exploratory Data Analysis Course, Homework week1, plot3


# create file if it does not exist
if (!file.exists("data")) {
  dir.create("data")
}
#Download url
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./energy/Energy_consumption.zip", method = "curl")
dateDownloaded <- date()

#unzip and read file
ss <-unzip("./energy/Energy_consumption.zip")
hpc <-read.table(ss,sep = ";",header = TRUE, na.strings = ("?"))

#split date up, it was not ordered correctly
library(stringr)
fixed <-str_split_fixed(hpc$Date, "/", 3)

#rebind the data in new format and give new names to columns
hpcfixed <- cbind(fixed,hpc)
colnames(hpcfixed)[1] <- c("Day")
colnames(hpcfixed)[2] <- c("Month")
colnames(hpcfixed)[3] <- c("Year")
#head(hpcfixed)

#extract only the data needed and bind them together
newdata <- subset(hpcfixed, Day == 1 & Month == 2 & Year == 2007)
newdata2 <-subset(hpcfixed, Day == 2 & Month == 2 & Year == 2007)
Two_day_analysis <- rbind.data.frame(newdata,newdata2)
#head(Two_day_analysis)
#write.csv(Two_day_analysis, "./data/two_day_analysis.csv")

timeseries <- as.POSIXct(paste(Two_day_analysis$Year,Two_day_analysis$Month, Two_day_analysis$Day,sep = "/"))
timeseries2 <-as.POSIXct(paste(timeseries, Two_day_analysis$Time, sep = " "))
final <- cbind(Two_day_analysis, timeseries2)
#head(final)

#plot3
par(mfrow = c(1, 1), mar = c(4, 4, 2, 1))
plot(final$timeseries2,final$Sub_metering_1, type = "l", col = 1, ylab = "Energy sub meeting", xlab = "" )
lines(final$timeseries2,final$Sub_metering_2, type = "l", col = 2)
lines(final$timeseries2,final$Sub_metering_3, type = "l", col = 4)
legend("topright", legend = c("sub_metering_1","sub_metering_2","sub_metering_3"), col=c(1,2,4),pch = "-" ) # optional legend
dev.copy(png, file = "plot3.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!
