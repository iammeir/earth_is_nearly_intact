setwd("/Users/gilesgraham/Downloads/indie games and related content/once upon a timespace")
library(tidyverse)
library(readtext)

load("sci_fi_word_list.Rdata")

words <- readtext(file="internet_archive_scifi_v3.txt")

corpus <- tibble(words = unlist(str_split(words$text," ")))

spaceships <- str_extract_all(words$text," [^ ]* spaceship [^ ]* ")
the_spaceship <- str_extract_all(words$text," (?i)the spaceship [^ ]* ")
shapeship_verbed <- tibble(items = the_spaceship[[1]]) %>% filter(str_detect(items,"spaceship (.*ed|.*ing)"))
behemoths <-  str_extract_all(words$text," [^ ]* behemoth [^ ]* ")

the_man <- str_extract_all(words$text," (?i)the man [^ ]* ")

the_man_verbed <-  tibble(items = the_man[[1]]) %>% filter(str_detect(items,"man (.*ed|.*ing)")) %>% distinct()
lasers <- str_extract_all(words$text," [^ ]* laser [^ ]* ")

spaceships[[1]] %>% unique()

behemoths[[1]]

inside_of <- str_extract_all(words$text," inside a [^ ]* ")

planets <- str_extract_all(words$text," [^ ]* planets* [^ ]* ")

planets_verbed <- tibble(items = planets[[1]]) %>% filter(str_detect(items,"planets* (.*ed|.*ing)")) %>% distinct()

spaceship_sentence <- tibble(sentences = str_extract_all(words$text,"\\.[^\\.]*spaceship[^\\.]*\\.")[[1]])
spaceship_sentence_trim <- spaceship_sentence %>% mutate(sentences = str_extract(sentences,"[^(\\. )].*"))


trimmed <- words$text %>% str_replace_all(paste("(",ordered_words$wordlist[1:100],")",collapse = "|",sep = ""),"")
markov_maybe <- ordered_words[100000:100100,] %>% 
  
  mutate(markov = str_extract_all(words$text,paste("(?<=",wordlist,")[^ ]",sep = "")))

split_words <- smaller_words %>% str_split(" ") %>% unlist()

test <- tibble(words = split_words) %>% filter(words %in% ordered_words$wordlist[100:600])

test_glued <- paste(test$words,collapse=" ")


the_man <- str_extract_all(words$text," (?i)the man [^ ]* ")

the_man_verbed <-  tibble(items = the_man[[1]]) %>% filter(str_detect(items,"man (.*ed|.*ing)")) %>% distinct()

the_woman <- str_extract_all(words$text," (?i)the woman [^ ]* ")

the_woman_verbed <-  tibble(items = the_woman[[1]]) %>% filter(str_detect(items,"woman (.*ed|.*ing)")) %>% distinct()

the_robot <- str_extract_all(words$text," (?i)the robot [^ ]* ")

the_robot_verbed <-  tibble(items = the_robot[[1]]) %>% filter(str_detect(items,"robot (.*ed|.*ing)")) %>% distinct()

i <- 1

seed = "the"
seed2 = "man"
output = list(seed,seed2)
for(i in 1:1000){
  adder <- two_stepped %>% 
    filter(words == seed & next_word == seed2) %>% 
    pull(two_word) %>% 
    sample(1L)
  
  print(adder)
  
  output <- append(output,adder)
  seed = seed2
  seed2 = adder
}

stepped_variable <- corpus %>% 
  mutate(next_word = lead(words,1L,default = "the"))

two_stepped <- stepped_variable %>% 
  mutate(two_word = lead(next_word,1L,default = "the"))
paste(output,collapse=" ")

