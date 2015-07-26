## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
}

## Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999–2008?

library(ggplot2)

## merge NEI and SCC
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

## get only coal combustion-related records
coal <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
coalNEISCC <- NEISCC[coal, ]

totalEmissionsByYear <- aggregate(Emissions ~ year, coalNEISCC, sum)

png("plot4.png", width = 480, height = 480)

plot <- ggplot(totalEmissionsByYear, aes(factor(year), Emissions))
plot <- plot + geom_bar(stat="identity") +
  xlab("Year") +
  ylab("Total PM2.5 Emissions") +
  ggtitle("Total Emissions from Coal-Combustion Related Sources")
print(plot)
dev.off()

