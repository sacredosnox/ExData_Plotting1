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

##  create a PNG File, create Plot2 and write into PNG File
## Names of Weekdays are in Germany, my R is set to German Language 
## x-axis has no name, y-axis is called "Global Active Power (kilowatts)"
## type is set to lines
png(file="plot2.png")
plot(newdf$convertDate,newdf$Global_active_power, type="l",xlab="",
       ylab= "Global Active Power (kilowatts)")
## close the connection
dev.off()