power_data <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power_data) <-  c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subset_of_power <- subset(power_data,power_data$Date == "1/2/2007" | power_data$Date == "2/2/2007")

subset_of_power$Date <- as.Date(subset_of_power$Date, format="%d/%m/%Y")
subset_of_power$Time <- strptime(subset_of_power$Time, format="%H:%M:%S")
subset_of_power[1:1440,"Time"] <- format(subset_of_power[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subset_of_power[1441:2880,"Time"] <- format(subset_of_power[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

par(mfrow=c(2,2))

with(subset_of_power,{
  plot(subset_of_power$Time,as.numeric(as.character(subset_of_power$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(subset_of_power$Time,as.numeric(as.character(subset_of_power$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(subset_of_power$Time,subset_of_power$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(subset_of_power,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(subset_of_power,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(subset_of_power,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(subset_of_power$Time,as.numeric(as.character(subset_of_power$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})