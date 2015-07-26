library(datasets)
library(ggplot2)
library(dplyr)

# Code to Read the data from the downloaded rds files 

NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")
NEI$year <- as.factor(NEI$year)
NEI$type <- as.factor(NEI$type)

# Code for plot 3 using ggplot2 

png(filename="Plot3.png",width=960,height=960,units="px")
g<-ggplot(NEI, aes(x=factor(year), y=Emissions)) + stat_summary(fun.y="sum", geom="bar",fill="red")
g+labs(x="Year")+labs(y="Total Emissions of PM25")+facet_grid(.~ type)+theme(axis.text=element_text(colour="blue"))
dev.off()

# Code for plot 4 using ggplot2

SCC_Coal <- SCC[grep("*Coal",SCC$Short.Name),]
SCC_Coal$SCC <- as.character(SCC_Coal$SCC)
SCC_Coal$SCC <- as.numeric(SCC_Coal$SCC)
NEI$SCC <- as.numeric(NEI$SCC)
SCC_Coal1<- SCC_Coal$SCC

a<-list()
n <-length(SCC_Coal1)
for(i in 1:n){
  a[[i]]<- subset(NEI,NEI$SCC==SCC_Coal1[i])
  i=i+1
}
NEI_final<- bind_rows(a)

png(filename="Plot4.png",width=960,height=960,units="px")
g<-g<-ggplot(NEI_final, aes(x=factor(year), y=Emissions)) + stat_summary(fun.y="sum", geom="bar",fill="green")
g+labs(x="Year")+labs(y="Total Emissions of PM25")+theme(axis.text=element_text(colour="blue"))+labs(title="Emissions of PM 2.5 from Coal sources(1999-2008)")
dev.off()

#Code for plot 5

SCC_Motor <- SCC[grep("*Motor*",SCC$Short.Name),]
SCC_Motor$SCC <- as.character(SCC_Motor$SCC)
SCC_Motor$SCC <- as.numeric(SCC_Motor$SCC)
#NEI$SCC <- as.numeric(NEI$SCC)
SCC_Motor1<- SCC_Motor$SCC

b<-list()
n <-length(SCC_Motor1)
for(i in 1:n){
  b[[i]]<- subset(NEI,NEI$SCC==SCC_Motor1[i])
  i=i+1
}
NEI_final_motor<- bind_rows(b)

png(filename="Plot5.png",width=960,height=960,units="px")
g<-ggplot(NEI_final_motor, aes(x=factor(year), y=Emissions)) + stat_summary(fun.y="sum", geom="bar",fill="yellow")
g+labs(x="Year")+labs(y="Total Emissions of PM25")+theme(axis.text=element_text(colour="blue"))+labs(title="Emissions of PM 2.5 from Motor sources(1999-2008)")
dev.off()


#Code for plot 6

city <- c("24510","06037")
NEI_final_motor_city <- subset(NEI_final_motor,NEI_final_motor$fips==city)
NEI_final_motor_city$fips=as.character(NEI_final_motor_city$fips)
NEI_final_motor_city$fips[NEI_final_motor_city$fips=="24510"] <- "Baltimore City"
NEI_final_motor_city$fips[NEI_final_motor_city$fips=="06037"] <- "Los Angeles County,California"
NEI_final_motor_city$fips=as.factor(NEI_final_motor_city$fips)
png(filename="Plot6.png",width=960,height=960,units="px")
g<-ggplot(NEI_final_motor_city, aes(x=factor(year), y=Emissions)) + stat_summary(fun.y="sum", geom="bar",fill="red")
g+labs(x="Year")+labs(y="Total Emissions of PM25")+facet_grid(.~ fips)+theme(axis.text=element_text(colour="blue"))
dev.off()



















