path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")
emissions <- readRDS('summarySCC_PM25.rds')
codes <- readRDS('Source_Classification_Code.rds')

baltimore_emissions <- subset(emissions, emissions$fips == '24510')
baltimore_year <- aggregate(baltimore_emissions$Emissions, by = list(baltimore_emissions$year), sum)
colnames(baltimore_year) <- c('Year','Total emissions')
png(filename = 'plot2.png')
plot(baltimore_year$Year, baltimore_year$`Total emissions`, col = 'red', lwd = 5, xlab = 'Year', pch = 19,
     ylab = 'Total Annual Emissions [Tons]', main = 'Total Emissions by year in Baltimore')
dev.off()