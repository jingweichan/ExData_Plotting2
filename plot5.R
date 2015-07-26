## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
}

## How have emissions from motor vehicle sources changed from 1999–2008 in 
## Baltimore City?

library(ggplot2)

## merge NEI and SCC
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

## get records for motor vehicle sources in Baltimore City
motorBaltimoreNEISCC <- NEISCC[NEISCC$fips == "24510" & NEISCC$type == "ON-ROAD", ]

totalEmissionsByYear <- aggregate(Emissions ~ year, motorBaltimoreNEISCC, sum)

png("plot5.png", width = 480, height = 480)

plot <- ggplot(totalEmissionsByYear, aes(factor(year), Emissions))
plot <- plot + geom_bar(stat="identity") +
  xlab("Year") +
  ylab("Total PM2.5 Emissions") +
  ggtitle("Total Emissions from Motor Vehicle Sources in Baltimore City")
print(plot)
dev.off()

