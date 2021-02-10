path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")
emissions <- readRDS('summarySCC_PM25.rds')
codes <- readRDS('Source_Classification_Code.rds')

baltimore_car <- subset(emissions, emissions$fips == '24510' & emissions$type == 'ON-ROAD')
baltimore_car_year <- aggregate(baltimore_car$Emissions, by = list(baltimore_car$year), sum)
colnames(baltimore_car_year) <- c('Year','Emissions')
png(filename = 'plot5.png')
plot(baltimore_car_year$Year, baltimore_car_year$Emissions, col = 'red', lwd = 5, xlab = 'Year', pch = 19,
     ylab = 'Total Annual Emissions [Tons]',
     main = 'Emissions related to motor vehicles in Baltimore City')
dev.off()