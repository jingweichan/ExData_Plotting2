## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
}

## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make a
## plot answering this question.

baltimoreNEI  <- NEI[NEI$fips == "24510", ]

totalEmissionsByYear <- aggregate(Emissions ~ year, baltimoreNEI, sum)

png("plot2.png", width = 480, height = 480)

barplot(height = totalEmissionsByYear$Emissions, 
        names.arg = totalEmissionsByYear$year, 
        xlab = "Year", 
        ylab = "Total PM2.5 Emissions",
        main = "Total PM2.5 Emissions in Baltimore City, Maryland")
dev.off()