path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")
emissions <- readRDS('summarySCC_PM25.rds')
codes <- readRDS('Source_Classification_Code.rds')

coal_code <- codes[grepl('Coal', codes$Short.Name), ]
coal_emisssions <- emissions[emissions$SCC %in% coal_code$SCC, ]
coal_emissions_year <- aggregate(coal_emisssions$Emissions, by = list(coal_emisssions$year), sum)
colnames(coal_emissions_year) <- c('Year', 'Emissions')
png(filename = 'plot4.png')
plot(coal_emissions_year$Year, coal_emissions_year$Emissions, col = 'red', lwd = 5, xlab = 'Year', pch = 19,
     ylab = 'Total Annual Emissions [Tons]', main = 'Coal Emissions by year in the US')
dev.off()