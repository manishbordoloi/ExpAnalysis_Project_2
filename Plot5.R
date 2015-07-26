library(datasets)
library(ggplot2)
library(dplyr)

# Code to download the zip file from internet and unzip the file 

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
unzip(temp)
unlink(temp)

# Code to Read the data from the downloaded rds files 

NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")
NEI$year <- as.factor(NEI$year)
NEI$type <- as.factor(NEI$type)

#Code for plot 5

SCC_Motor <- SCC[grep("*Motor*",SCC$Short.Name),]
SCC_Motor$SCC <- as.character(SCC_Motor$SCC)
SCC_Motor$SCC <- as.numeric(SCC_Motor$SCC)
NEI$SCC <- as.numeric(NEI$SCC)
SCC_Motor1<- SCC_Motor$SCC

b<-list()
n <-length(SCC_Motor1)
for(i in 1:n){
  b[[i]]<- subset(NEI,NEI$SCC==SCC_Motor1[i])
  i=i+1
}
NEI_final_motor<- bind_rows(b)

png(filename="Plot5.png",width=960,height=960,units="px")
g<-g<-ggplot(NEI_final_motor, aes(x=factor(year), y=Emissions)) + stat_summary(fun.y="sum", geom="bar",fill="yellow")
g+labs(x="Year")+labs(y="Total Emissions of PM25")+theme(axis.text=element_text(colour="blue"))+labs(title="Emissions of PM 2.5 from Motor sources(1999-2008)")
dev.off()
