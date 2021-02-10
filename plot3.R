path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")
emissions <- readRDS('summarySCC_PM25.rds')
codes <- readRDS('Source_Classification_Code.rds')

library(ggplot2)
baltimore_type_year <- aggregate(baltimore_emissions$Emissions, by = list(baltimore_emissions$type, 
                                                                          baltimore_emissions$year), sum)
colnames(baltimore_type_year) <- c('Type','Year','Emissions')
png(filename = 'plot3.png')
ggplot(baltimore_type_year, aes(factor(Year), Emissions, fill = Type)) +
  geom_bar(stat = 'identity') +
  theme_bw() +
  guides(fill = FALSE) +
  facet_grid(.~Type, scales = 'free', space = 'free') +
  labs(x = 'Year', y = 'Total Annual Emissions [Tons]') +
  labs(title = 'Emissions, Baltimore city by source type')
dev.off()