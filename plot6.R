## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
}

## Compare emissions from motor vehicle sources in Baltimore City with emissions
## from motor vehicle sources in Los Angeles County, California 
## (fips == "06037"). Which city has seen greater changes over time in motor 
## vehicle emissions?

library(ggplot2)

## merge NEI and SCC
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

## get records for motor vehicle sources in Baltimore City and Los Angeles 
## County, California
motorBaltimoreLosAngelesNEISCC <- NEISCC[NEISCC$fips == "24510"
                                         | NEISCC$fips == "06037" 
                                         & NEISCC$type=="ON-ROAD", ]

totalEmissionsByYearFips <- aggregate(Emissions ~ year + fips, 
                                      motorBaltimoreLosAngelesNEISCC, sum)

png("plot6.png", width = 480, height = 480)

plot <- ggplot(totalEmissionsByYearFips, aes(x = year, 
                                             y = Emissions, 
                                             color = fips))
plot <- plot + geom_line() +
  xlab("Year") +
  ylab("Total PM2.5 Emissions") +
  ggtitle("Total Emissions from Motor Vehicle Sources in Baltimore City vs 
          Los Angeles, California")
print(plot)
dev.off()

