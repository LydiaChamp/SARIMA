source("code/04a_OutputCSV_cases.R")
source("code/04b_OutputCSV_deaths.R")


Lydia_SARIMA <- rbind(Lydia_SARIMA_cases, Lydia_SARIMA_deaths)

write.csv(Lydia_SARIMA, "./output/2023-10-30-Lydia-SARIMA.csv", row.names=FALSE)

#Lydia_SARIMA <- Lydia_SARIMA[order(Lydia_SARIMA$location),]