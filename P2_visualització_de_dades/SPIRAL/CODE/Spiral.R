library(ggplot2); library(dplyr); library(lubridate); library(viridis)

city_temperature <- read.csv("/home/andrea/Videos/P2_visualització_de_dades/SPIRAL/DADES/city_temperature.csv")

algiers_2years <- city_temperature %>% filter(Country == "Algeria", City == "Algiers", Year %in% c(1995, 1996)) %>% mutate(date = as.Date(sprintf("%d-%02d-%02d", Year, Month, Day)), day_num = yday(date), temp = AvgTemperature) %>% filter(!is.na(temp)) %>% arrange(Year, day_num) %>% mutate(day_cum = day_num + cumsum(lag(day_num, default = 0) * (Year != lag(Year, default = Year[1]))))

ggplot(algiers_2years, aes(x = day_cum %% 365, y = 0.05*day_cum + temp/2, fill = temp)) + geom_tile(width = 1, height = 10) + scale_x_continuous(breaks = 30*0:11, minor_breaks = NULL, labels = month.abb) + coord_polar() + scale_fill_gradient2(low = "blue", mid = "yellow", high = "red", midpoint = mean(algiers_2years$temp), name = "Temp (°F)") + theme_minimal() + labs(title = "Temperatures Diàries a Algiers (Algeria) (1994-1995)", x = NULL, y = NULL, caption = "Font: https://www.kaggle.com")
