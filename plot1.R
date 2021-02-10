path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")
emissions <- readRDS('summarySCC_PM25.rds')
codes <- readRDS('Source_Classification_Code.rds')

emissions_year <- aggregate(emissions$Emissions, by = list(year = emissions$year), sum)
colnames(emissions_year) <- c('Year', 'Total emissions')

png(filename = 'plot1.png')
plot(emissions_year$Year, emissions_year$`Total emissions`, col = 'red', lwd = 5, xlab = 'Year', pch = 19,
     ylab = 'Total Annual Emissions [Tons]', main = 'Total Emissions by year in the US')
dev.off()