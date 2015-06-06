## Reading and Subsetting the TXT.File
## Subsetting by using Package sqldf

install.packages("sqldf")
library(sqldf)

## Subsetting via Date
dataframe<-read.csv.sql("~/R/household_power_consumption.txt",
                        sql='select*from file where Date in ("1/2/2007","2/2/2007")',
                        sep= ";",header=TRUE)

## Convert the Date and Time variables to Date/Time classes in R
## For converting Date and Time, first bind Date and Time variables together

date_and_time<-paste(dataframe$Date,dataframe$Time)

## Convert using Lubridate Package

install.packages("lubridate")
library(lubridate)

convertDate<-dmy_hms(date_and_time)

## Binding the new varialbe convertDate to the original Dataframe

newdf<-cbind(convertDate,dataframe)

## Delete the old Date and Time variables from newdf

newdf$Date<-NULL
newdf$Time<-NULL

## create a PNG File, create Plot4

png(file = "plot4.png")

## create two Lines and  two  Pictures per Line

par(mfrow= c(2,2))

# Plot all four plots

## Names of Weekdays are in Germany, my R is set to German Language 
## x-axis has no name, y-axis has name"Global Active Power"
## type is set to lines

plot(newdf$convertDate,newdf$Global_active_power, type="l",xlab="",
       ylab= "Global Active Power")

## X-axis is called "datetime", y-axis is calles "Voltage"

plot(newdf$convertDate,newdf$Voltage,type="l",xlab="datetime",ylab="Voltage")

## Make an new Plot without Points, X-axis have no title 
## y-axis is called "Energy sub metering"

plot(newdf$convertDate,newdf$Sub_metering_1,xlab="",
     ylab="Energy sub metering",type="n")

## Add new points to the plot, type = line

points(newdf$convertDate,newdf$Sub_metering_1,type="l")

## Add new points to the plot, type = line, color = "red"

points(newdf$convertDate,newdf$Sub_metering_2,type="l", col= "red")

## Add new points to the plot, type = line, color = "blue"

points(newdf$convertDate,newdf$Sub_metering_3,type="l", col= "blue")

## Add a legend at the topright with three entries: 
## Three Lines, Three colors for lines and three names for the three lines

legend("topright", lty=c(1,1,1),lwd=c(1,1,1),col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## x-axis is called "datetime" , y-axis is called "Global_reactive_power"

plot(newdf$convertDate,newdf$Global_reactive_power,type="l",
     xlab="datetime",ylab="Global_reactive_power")

## close connection
dev.off()