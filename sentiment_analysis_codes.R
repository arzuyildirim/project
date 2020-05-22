
rey <- read.csv("rey_tweets.csv", encoding="UTF-8")
rey

library(stringr)
#I used tidytext package for sentiment analysis
library(tidytext)
library("dplyr")

#I created tibble from given data to make proper data frame 
library(tibble)
tibblerey<-as_tibble(rey)
tibblerey<-as.character(tibblerey$content)
tibblerey
d <- tibble(txt = tibblerey)
d


#I separated words and put each of them in one line by using unnest_tokens function
dat <- d %>% unnest_tokens(word, txt)
dat

#there are many words I am not interested in.To be able to extract what I need I used anti_join function from dplyr package
unnested <- dat %>% anti_join(stop_words)
# count function to take a look at what we have in tiddle
count(unnested, word, sort=TRUE)

#I used get_sentiment function to get specific sentiments with one row per word. 
rey_counts <- dat %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()

#checked the first 20 adjectives 
head(rey_counts,20)

#used ggplot2 package to create good looking graph
library(ggplot2)
rey_counts %>%
  group_by(sentiment) %>%
  top_n(5) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y") +
  labs(y = "Contribution to sentiment",
       x = NULL) +
  coord_flip()

#used for datawrangling using acast() function
library(reshape2)

#created wordcloud to visualize better with wordcloud package 
library(wordcloud)
dat %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("red", "blue"),
                   max.words = 100)


library(ggplot2)
library(tidyr)
#I created polarity graph to see overall distribution of positive to negative words
rey_counts %>%
  group_by(sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(polarity = positive - negative) %>% 
  filter(abs(polarity)<10) %>% 
  ggplot(aes(polarity)) +
  geom_density(alpha = 0.3) +
  geom_vline(xintercept=0, linetype="dashed", color = "red")+
  ggtitle("Polarity of Rey Comments'")


#Same codes for other characters "Finn" & "Poe"

finn <- read.csv("finn_tweets.csv", encoding="UTF-8")

tibblefinn<-as_tibble(finn)

tibblefinn<-as.character(tibblefinn$content)
tibblefinn
tibblecontent

d2<- tibble(txt = tibblefinn)
d2

dat2 <- d2 %>% unnest_tokens(word, txt)
dat2

unnested2 <- dat2 %>% anti_join(stop_words)
count(unnested2, word, sort=TRUE)

finn_counts <- dat2 %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()

head(finn_counts,20)


library(ggplot2)
finn_counts %>%
  group_by(sentiment) %>%
  top_n(5) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y") +
  labs(y = "Contribution to sentiment",
       x = NULL) +
  coord_flip()


dat2 %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("blue", "red"),
                   max.words = 100)



finn_counts %>%
  group_by(sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(polarity = positive - negative) %>% 
  filter(abs(polarity)<10) %>% 
  ggplot(aes(polarity)) +
  geom_density(alpha = 0.3) +
  geom_vline(xintercept=0, linetype="dashed", color = "red")+
  ggtitle("Polarity of 'Finn Comments'")

#CODES FOR POE

poe <- read.csv("poe_tweets_new.csv", encoding="UTF-8")


tibblepoe<-as_tibble(poe)

tibblepoe<-as.character(tibblepoe$content)
tibblepoe


d3 <- tibble(txt = tibblepoe)
d3

dat3 <- d3 %>% unnest_tokens(word, txt)
dat3

unnested3 <- dat3 %>% anti_join(stop_words)
count(unnested, word, sort=TRUE)


poe_counts <- dat3 %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()

head(poe_counts,20)



poe_counts %>%
  group_by(sentiment) %>%
  top_n(5) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y") +
  labs(y = "Contribution to sentiment",
       x = NULL) +
  coord_flip()



library(reshape2)#used for datawrangling using acast() function
library(wordcloud)
dat3 %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("red", "blue"),
                   max.words = 100)


poe_counts %>%
  group_by(sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(polarity = positive - negative) %>% 
  filter(abs(polarity)<10) %>% 
  ggplot(aes(polarity)) +
  geom_density(alpha = 0.3) +
  geom_vline(xintercept=0, linetype="dashed", color = "red")+
  ggtitle("Polarity of 'Poe Comments'")
