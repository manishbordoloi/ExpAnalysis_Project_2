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
















