hpc <- read.table("./data/household_power_consumption.txt", sep = ";",header = TRUE, na.strings = ("?"))
#head(hpc)

library(stringr)
fixed <-str_split_fixed(hpc$Date, "/", 3)

#head(fixed)

hpcfixed <- cbind(fixed,hpc)
#head(hpcfixed)
colnames(hpcfixed)[1] <- c("Day")
colnames(hpcfixed)[2] <- c("Month")
colnames(hpcfixed)[3] <- c("Year")


newdata <- subset(hpcfixed, Day == 1 & Month == 2 & Year == 2007)
#head(newdata)

newdata2 <-subset(hpcfixed, Day == 2 & Month == 2 & Year == 2007)

Two_day_analysis <- rbind.data.frame(newdata,newdata2)
#head(Two_day_analysis)

#write.csv(Two_day_analysis, "./data/two_day_analysis.csv")


#perfect plot 1
hist(Two_day_analysis$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowats)") # good graph
dev.copy(png, file = "plot1.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!

timeseries <- as.POSIXct(paste(Two_day_analysis$Year,Two_day_analysis$Month, Two_day_analysis$Day,sep = "/"))
timeseries2 <-as.POSIXct(paste(timeseries, Two_day_analysis$Time, sep = " "))
final <- cbind(Two_day_analysis, timeseries2)
#head(final)


#perfect plot 2                        
plot(final$timeseries2,final$Global_active_power, type = "l", ylab = "Global Active Power (kilowats)", xlab="" ) 
dev.copy(png, file = "plot2.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!




#plot3
plot(final$timeseries2,final$Sub_metering_1, type = "l", col = 1, ylab = "Energy sub meeting", xlab = "" )
lines(final$timeseries2,final$Sub_metering_2, type = "l", col = 2)
lines(final$timeseries2,final$Sub_metering_3, type = "l", col = 4)
legend("topright", legend = c("sub_metering_1","sub_metering_2","sub_metering_3"), col=c(1,2,4),pch = "-" ) # optional legend
dev.copy(png, file = "plot3.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!

#plot4
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))
plot(final$timeseries2,final$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "") 

plot(final$timeseries2,final$Voltage, type = "l", col =1, ylab = "Voltage", xlab = "datetime")

plot(final$timeseries2,final$Sub_metering_1, type = "l", col = 1, ylab = "Energy sub meeting", xlab = "" )
lines(final$timeseries2,final$Sub_metering_2, type = "l", col = 2)
lines(final$timeseries2,final$Sub_metering_3, type = "l", col = 4)
legend("topright", legend = c("sub_metering_1","sub_metering_2","sub_metering_3"), col=c(1,2,4),pch = "-",bty = "n" ) # optional legend

plot(final$timeseries2,final$Global_reactive_power, type = "l", col = 1, ylab = "Global_reactive_power", xlab = "datetime")

dev.copy(png, file = "plot4.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!