## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
}

## Of the four types of sources indicated by the type (point, nonpoint, onroad, 
## nonroad) variable, which of these four sources have seen decreases in 
## emissions from 1999–2008 for Baltimore City? Which have seen increases in 
## emissions from 1999–2008? Use the ggplot2 plotting system to make a plot 
## answer this question.

library(ggplot2)

baltimoreNEI  <- NEI[NEI$fips == "24510", ]

totalEmissionsByYearType <- aggregate(Emissions ~ year + type, baltimoreNEI, sum)

png("plot3.png", width = 480, height = 480)

plot <- ggplot(totalEmissionsByYearType, aes(x = year, 
                                                 y = Emissions, 
                                                 color = type))
plot <- plot + geom_line() +
  xlab("Year") +
  ylab("Total PM2.5 Emissions") +
  ggtitle("Total PM2.5 Emissions in Baltimore City, Maryland")
print(plot)
dev.off()