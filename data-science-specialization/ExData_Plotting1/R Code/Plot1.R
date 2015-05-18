Plot1 <- function{
  FilePath = "C:\\Users\\Jonathan.WSF\\Desktop\\household_power_consumption.txt"
  df <- read.table(filePath,sep=";",col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),colClasses = as.character(), na.strings = "?",skip=66637,nrows=69517-66637)
  df$Date = strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S")
  for(x in 3:9){
    df[,x] = as.numeric(df[,x])
  }
  
  png(filename = "C:\\Users\\Jonathan.WSF\\Desktop\\Plot1.png")
  hist(df$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")
  dev.off()
}