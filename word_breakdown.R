setwd("/Users/gilesgraham/Downloads/indie games and related content/once upon a timespace")

library(readtext)
library(tidyverse)

words <- readtext(file="internet_archive_scifi_v3.txt")

wordlist <- strsplit(words$text," ",fixed = TRUE)

results <- table(wordlist)

frames_results <- as.data.frame(results)

ordered_words <- arrange(frames_results,desc(Freq))

ordered_words[5000:5100,]

tail(ordered_words,200)

save(ordered_words,file = "sci_fi_word_list.Rdata")
