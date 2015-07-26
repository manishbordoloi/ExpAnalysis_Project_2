library(data.table)


# Code to download the zip file from internet and unzip the file 

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
unzip(temp)
unlink(temp)

# Code to read the data from the unzipped rds files into R data frame

NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")
NEI$year <- as.factor(NEI$year)

# Code for plot 2


png(filename="Plot2.png",width=480,height=480,units="px")
NEI1 <- subset(NEI,NEI$fips=="24510")
x1 <- subset(NEI1,year=="1999")
y1 <- sum(x1$Emissions)
x2 <- subset(NEI1,year=="2002")
y2 <- sum(x2$Emissions)
x3 <- subset(NEI1,year=="2005")
y3 <- sum(x3$Emissions)
x4 <- subset(NEI1,year=="2008")
y4 <- sum(x4$Emissions)

m <- c(y1,y2,y3,y4)
n <- c("1999","2002","2005","2008")
plot(n,m,pch=20,type="line",col="red",xlab="Year",ylab="Total PM 2.5 Emission",main="Total Emission in Baltimore City from 1999-2008")

dev.off()
