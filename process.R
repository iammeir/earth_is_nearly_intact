library(tidyverse)
library(readtext)

load("sci_fi_word_list.Rdata")

words <- readtext(file="internet_archive_scifi_v3.txt")

corpus <- tibble(words = unlist(str_split(words$text," ")))

stepped_variable <- corpus %>% 
  mutate(next_word = lead(words,1L,default = "science"))

two_stepped <- stepped_variable %>% 
  mutate(two_word = lead(next_word,1L,default = "fiction"))



i <- 1

seed = "Giles"
seed2 = "remembered"

output = list(seed,seed2)
for(i in 1:5000){
  adder <- two_stepped %>% 
    filter(words == seed & next_word == seed2) %>% 
    pull(two_word) %>% 
    sample(1L)
  
  print(adder)
  print(i)
  
  output <- append(output,adder)
  seed = seed2
  seed2 = adder
}

write_lines(paste(output,collapse=" "),"tenth_5000.txt")
