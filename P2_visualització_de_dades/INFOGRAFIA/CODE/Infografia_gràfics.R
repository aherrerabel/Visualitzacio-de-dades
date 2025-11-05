library(tidyverse)

# llegeix les dades
datos <- read_csv("/home/andrea/Downloads/down-syndrome-rates-by-country-2025 (2).csv") %>% rename(prevalencia_estimada = "DownSyndromePrevalenceOverallEstimate_2019")
head(datos)

# Top 3 paísos
top_3_paisos <- datos %>% arrange(desc(prevalencia_estimada)) %>% slice(1:3)

# Gràfic top 3
grafic_top_3 <- top_3_paisos %>% ggplot(aes(x = reorder(country, prevalencia_estimada), y = prevalencia_estimada)) + geom_col(fill = "#0072B2", color = "white") + geom_text(aes(label = round(prevalencia_estimada, 1)), hjust = -0.1, size = 3) + coord_flip() + labs(title = "Països amb més alteració genètica: Còpia addicional al cromosoma 21", subtitle = "Casos per cada 100.000 naixements", x = "País", y = "Naixements", caption = "Font de les dades: worldpopulationreview.com") + theme_minimal() + theme(plot.title = element_text(face = "bold", size = 14), plot.subtitle = element_text(size = 10, color = "gray30"), axis.text.y = element_text(face = "bold"), panel.grid.major.y = element_blank())

print(grafic_top_3)

# paísos amb menys
bottom_3_paisos <- datos %>% arrange(prevalencia_estimada) %>% slice(1:3)

# Gràfic 
abaix_grafic <- bottom_3_paisos %>% ggplot(aes(x = reorder(country, -prevalencia_estimada), y = prevalencia_estimada)) + geom_col(fill = "#D55E00", color = "white") + geom_text(aes(label = round(prevalencia_estimada, 1)), hjust = 1.1, size = 3, color = "white") + coord_flip() + labs(title = "Països amb menys alteració genètica: Còpia addicional al cromosoma 21", subtitle = "Casos per cada 100.000 naixements", x = "País", y = "Naixements", caption = "Font de les dades: worldpopulationreview.com") + theme_minimal() + theme(plot.title = element_text(face = "bold", size = 14), plot.subtitle = element_text(size = 10, color = "gray30"), axis.text.y = element_text(face = "bold"), panel.grid.major.y = element_blank())

print(abaix_grafic)

