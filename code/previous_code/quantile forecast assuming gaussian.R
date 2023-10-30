qf_1 <- matrix(0, nrow=N_countries, ncol=(N_quantiles - 1))
m_1 <- matrix(0, nrow=N_countries, ncol=1)
s_1 <- matrix(0, nrow=N_countries, ncol=1)

qf_2 <- matrix(0, nrow=N_countries, ncol=(N_quantiles - 1))
m_2 <- matrix(0, nrow=N_countries, ncol=1)
s_2 <- matrix(0, nrow=N_countries, ncol=1)

qf_3 <- matrix(0, nrow=N_countries, ncol=(N_quantiles - 1))
m_3 <- matrix(0, nrow=N_countries, ncol=1)
s_3 <- matrix(0, nrow=N_countries, ncol=1)

qf_4 <- matrix(0, nrow=N_countries, ncol=(N_quantiles - 1))
m_4 <- matrix(0, nrow=N_countries, ncol=1)
s_4 <- matrix(0, nrow=N_countries, ncol=1)

for (country in 1:N_countries){
  arima_forecasts_bycountry_cases <- lapply(arima_models_bycountry_cases, 
                                            function(model) 
                                              forecast(model, 
                                                       h = 4, 
                                                       level = 95)
                                            
  )
  
  m_1[country,1] <- arima_forecasts_bycountry_cases[[country]]$mean[1]
  m_2[country,1] <- arima_forecasts_bycountry_cases[[country]]$mean[2]
  m_3[country,1] <- arima_forecasts_bycountry_cases[[country]]$mean[3]
  m_4[country,1] <- arima_forecasts_bycountry_cases[[country]]$mean[4]
  
    s_1[country,1] <- ((arima_forecasts_bycountry_cases[[country]]$upper[1]-arima_forecasts_bycountry_cases[[country]]$lower[1])/1.96/2)
    s_2[country,1] <- ((arima_forecasts_bycountry_cases[[country]]$upper[2]-arima_forecasts_bycountry_cases[[country]]$lower[2])/1.96/2)
    s_3[country,1] <- ((arima_forecasts_bycountry_cases[[country]]$upper[3]-arima_forecasts_bycountry_cases[[country]]$lower[3])/1.96/2)
    s_4[country,1] <- ((arima_forecasts_bycountry_cases[[country]]$upper[4]-arima_forecasts_bycountry_cases[[country]]$lower[4])/1.96/2)
    
    qf_1[country,] <- qnorm(c(0.01, 0.025, seq(0.05, 0.95, by = 0.05), 0.975, 0.99), m_1[country,1], s_1[country,1])
    qf_2[country,] <- qnorm(c(0.01, 0.025, seq(0.05, 0.95, by = 0.05), 0.975, 0.99), m_2[country,1], s_2[country,1])
    qf_3[country,] <- qnorm(c(0.01, 0.025, seq(0.05, 0.95, by = 0.05), 0.975, 0.99), m_3[country,1], s_3[country,1])
    qf_4[country,] <- qnorm(c(0.01, 0.025, seq(0.05, 0.95, by = 0.05), 0.975, 0.99), m_4[country,1], s_4[country,1])

    qf_1 <- cbind(arima_forecasts_bycountry_cases[[country]]$mean[1], qf_1[country,])
    
    }


colnames(qf_1) <- c(as.character(c(0.01, 0.025, seq(0.05, 0.95, by = 0.05), 0.975, 0.99)))
rownames(qf_1) <- unique(data$country)

colnames(qf_2) <- c(as.character(c(0.01, 0.025, seq(0.05, 0.95, by = 0.05), 0.975, 0.99)))
rownames(qf_2) <- unique(data$country)

colnames(qf_3) <- c(as.character(c(0.01, 0.025, seq(0.05, 0.95, by = 0.05), 0.975, 0.99)))
rownames(qf_3) <- unique(data$country)

colnames(qf_4) <- c(as.character(c(0.01, 0.025, seq(0.05, 0.95, by = 0.05), 0.975, 0.99)))
rownames(qf_4) <- unique(data$country)