library("data.table")
path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

condition <- grepl("vehicle", SCC[, SCC.Level.Two], ignore.case=TRUE)
vehicles_codes <- SCC[condition, SCC]
vehicles_emissions <- NEI[NEI[, SCC] %in% vehicles_codes,]

vehicles_Baltimore_emissions <- vehicles_emissions[fips == "24510",]
vehicles_Baltimore_emissions[, city := c("Baltimore City")]

vehicles_LA_emissions <- vehicles_emissions[fips == "06037",]
vehicles_LA_emissions[, city := c("Los Angeles")]

bothNEI <- rbind(vehicles_Baltimore_emissions,vehicles_LA_emissions)

png("plot6.png")
ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  labs(x="Year", y='Total Annual Emissions [Tons]') + 
  labs(title='Motor vehicle source in Baltimore & LA')
dev.off()