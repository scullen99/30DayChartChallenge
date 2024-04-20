# Fuente: https://www.kaggle.com/datasets/yaminh/netflix-dataset-for-analysis

setwd("/home/sergio/Desktop/30DayChartChallenge/8_Day_Chart")
getwd()

#install.packages("ggthemes")

library(ggplot2)
library(dplyr)
library(ggthemes) 

# Load the data
netflix_data <- read.csv("netflix.csv")

genre_counts <- netflix_data %>%
  group_by(genre) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

top_genres <- head(genre_counts, 5)$genre
genre_counts$grouped_genre <- ifelse(genre_counts$genre %in% top_genres, genre_counts$genre, 'Other')

final_counts <- genre_counts %>%
  group_by(grouped_genre) %>%
  summarise(count = sum(count))

final_counts$percentage <- round(final_counts$count / sum(final_counts$count) * 100)

final_counts <- final_counts %>%
  mutate(grouped_genre = factor(grouped_genre, levels = grouped_genre[order(-count)]))

ggplot(final_counts, aes(x = "", y = count, fill = grouped_genre)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar(theta = "y") +
  theme_minimal() +
  theme(axis.title = element_blank(),
        axis.text = element_blank(),
        panel.grid = element_blank(),
        legend.position = "right") +
  scale_fill_brewer(palette = "Dark2") +
  geom_text(aes(label = paste0(percentage, "%")), position = position_stack(vjust = 0.5)) +
  labs(
    title = "Distribution of Netflix Titles by Genre",
    caption = "Source: Kaggle (Netflix Dataset)\nAuthor: Sergio Esteban Tarrero",
    fill = "Genres"
  )

ggsave("SergioEstebanTarreroDay8.png", width = 10, height = 8, dpi = 300)