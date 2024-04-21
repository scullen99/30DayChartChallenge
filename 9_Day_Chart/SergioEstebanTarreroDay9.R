# Fuente: https://www.kaggle.com/datasets/yaminh/netflix-dataset-for-analysis

setwd("/home/sergio/Desktop/30DayChartChallenge/9_Day_Chart")
getwd()

#install.packages("ggthemes")

library(ggplot2)
library(dplyr)
library(ggthemes) 

# Load the data
netflix_data <- read.csv("netflix.csv")

year_genre_counts <- netflix_data %>%
  filter(!(year %in% c(2014, 2015))) %>%
  group_by(year, genre) %>%
  summarise(count = n(), .groups = 'drop')

top_genres <- year_genre_counts %>%
  group_by(genre) %>%
  summarise(total_count = sum(count)) %>%
  top_n(7, total_count) %>%
  pull(genre)

year_genre_counts <- year_genre_counts %>%
  mutate(genre = ifelse(genre %in% top_genres, genre, 'Other')) %>%
  mutate(genre = factor(genre, levels = c(top_genres, 'Other')))

year_totals <- year_genre_counts %>% group_by(year) %>% summarise(total = sum(count))
year_genre_counts <- year_genre_counts %>%
  left_join(year_totals, by = "year") %>%
  mutate(percentage = count / total * 100)

ggplot(year_genre_counts, aes(x = year, y = percentage, fill = genre)) +
  geom_bar(stat="identity", position="stack") +
  labs(y = "Percentage", x = "Year", fill = "Genre", title = "Distribution of Genres by Year on Netflix") +
  scale_x_discrete(limits = sort(unique(year_genre_counts$year))) +
  theme(
    plot.title = element_text(hjust = 0.5)
  ) + 
  labs(
    title = "Distribution of Netflix Titles by Genre",
    caption = "Source: Kaggle (Netflix Dataset)\nAuthor: Sergio Esteban Tarrero",
    fill = "Genres"
  )

#ggsave("SergioEstebanTarreroDay9.png", width = 10, height = 8, dpi = 300)
ggsave("SergioEstebanTarreroDay9.png", plot = last_plot(), device = "png", width = 10, height = 8, dpi = 300, bg = "white")