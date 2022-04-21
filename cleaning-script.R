library(tidyverse)
library(readxl)
library(dplyr)

#Chinese 
chinese1 <- read_excel("datasets/Chinese/AUT_materialBase.xlsx", sheet = 1) 
chinese2 <- read_excel("datasets/Chinese/AUT_materialBase.xlsx", sheet = 2) 
chinese3 <- read_excel("datasets/Chinese/chineseaut_validity.xlsx")

chinese1 <- chinese1 %>% dplyr::rename("ID" = "subID",
                                       "prompt" = "item",
                                       "response" = "res") %>%
  dplyr::select(ID, prompt, response, itemID, rater1, rater2, rater3, rater4) %>%
  write_excel_csv("processed/chinese1.csv")

chinese2 <- chinese2 %>% dplyr::rename("ID" = "id",
                                       "prompt" = "item") %>%
  dplyr::select(ID, prompt, response, rater1, rater2, rater3, rater4) %>%
  write_excel_csv("processed/chinese2.csv")

chinese3 <- chinese3 %>% dplyr::rename("ID" = "subID",
                                       "prompt" = "item") %>%
  dplyr::select(ID, prompt, response, item_english, rater1, rater2, rater3, rater4, openness, CAQ) %>%
  write_excel_csv("processed/chinese3.csv")

#French
french1 <- read_excel("datasets/French/Volle_CREAFLEX_data.xlsx", sheet = 1)

french1 <- french1 %>% dplyr::rename("prompt" = "item") %>%
  dplyr::select(ID, prompt, response, coder1, coder2, coder3, coder4, coder5, "C-act", "C-ach") %>%
  write_excel_csv("processed/french1.csv")

#German
german1 <- read_excel("datasets/German/NEMOData_DT.xls", sheet = 1) %>% mutate("prompt" = "konservendose")
german2 <- read_excel("datasets/German/NEMOData_DT.xls", sheet = 2) %>% mutate("prompt" = "messer")
german3 <- read_excel("datasets/German/NEMOData_DT.xls", sheet = 3) %>% mutate("prompt" = "haarfoehn")

german <- do.call("rbind", list(german1, german2, german3)) %>% 
  rename("ID" = "Person", "response" = "Response...1", "responseorder" = "Response...3") %>%
  select(ID, prompt, response, responseorder, Rating, R1, R2, R3, R4) %>% 
  write_excel_csv("processed/german1.csv")

#Italian
italian1 <- read_excel("datasets/Italian/italian1.xlsx")
italian2 <- read_excel("datasets/Italian/italian2.xlsx")

italian1 <- italian1 %>% dplyr::rename("prompt" = "Item", "response" = "ALTERNATIVERESPONSE") %>%
  dplyr::select(ID, prompt, response, Coder1, Coder2, CAAC_TOT, NEO_OPEN) %>%
  write_excel_csv("processed/italian1.csv")

italian2 <- italian2 %>% dplyr::rename("prompt" = "Item", "response" = "Alternativeresponse") %>%
  dplyr::select(ID, prompt, response, Coder1, Coder2, CAAC_TOT, Openness) %>%
  write_excel_csv("processed/italian2.csv")

#Polish
polish1 <- read_excel("datasets/Polish/Can-Brick-complete(S1).xlsx")
polish2 <- read_excel("datasets/Polish/String-Can-Brick(S2).xlsx")

polish1 <- polish1 %>% dplyr::rename("ID" = "id", "prompt" = "item") %>%
  dplyr::select(ID, prompt, response, lp, order, coder1, coder2, coder3, iq_all:lnmusic) %>%
  write_excel_csv("processed/polish1.csv")

polish2 <- polish2 %>% dplyr::rename("prompt" = "item") %>%
  dplyr::select(ID, prompt, response, lp, order, coder1, coder2, coder3, coder4, Extr:age) %>%
  write_excel_csv("processed/polish2.csv")

#Russian
russian1 <- read_excel("datasets/Russian/Rus-DT-AUT [final].xlsx", sheet = 1)
russian2 <- read_excel("datasets/Russian/Rus-DT-AUT [final].xlsx", sheet = 2)

russian1 <- russian1 %>% dplyr::rename("ID" = "id", "prompt" = "item") %>%
  dplyr::select(ID, prompt, response, coder1, coder2, coder3) %>%
  write_excel_csv("processed/russian1.csv")

russian2 <- russian2 %>% dplyr::rename("ID" = "id", "prompt" = "item") %>%
  dplyr::select(ID, prompt, response, coder1, coder2, coder3, "RAPM-Gf":"BFI-Neuroticism") %>%
  write_excel_csv("processed/russian2.csv")

#Spanish
spanish1 <- read.csv("datasets/Spanish/spanish1.csv", na.strings = c("", "NA"))

spanish1_responses <- spanish1 %>% rename("ID" = "ï..ID") %>% select(ID, prompt, starts_with("response")) %>%
  group_by(ID) %>% pivot_longer(cols = "response_1":"response_21", 
                                names_to = c("drop", "order"),
                                names_sep = "_",
                                values_to = "response", values_drop_na = TRUE) %>%
  select(ID, prompt, response, order)

spanish1_ratings <- spanish1 %>% rename("ID" = "ï..ID") %>% select(ID, starts_with("rater")) %>%
  group_by(ID) %>% pivot_longer(cols = "rater1_1":"rater3_21", 
                                names_to = c("rater", "order"),
                                names_sep = "_",
                                values_to = "ratings", values_drop_na = TRUE)

spanish1_demog <- spanish1 %>% rename("ID" = "ï..ID") %>% select(ID, age, sex, starts_with("cse"))

spanish1_validation <- merge(spanish1_ratings, spanish1_demog, by = "ID")

spanish1_all <- merge(spanish1_responses, spanish1_validation, by = c("ID", "order")) %>%
  select(ID, prompt, response, order, rater:cse11) %>% arrange(ID, order)

write_excel_csv(spanish1_all, "processed/spanish1.csv")

#Arabic
arabic1 <- read_excel("datasets/Arabic/Arabic SemDis data .xlsx")

arabic1 <- arabic1 %>% rename("prompt" = "AUT item",
                              "response" = "AUT response",
                              "rating" = "AUT rating",
                              "CAQTotal" = "Total CAQ",
                              "openness" = "Openness",
                              "visual_arts" = "Visual arts",
                              "music" = "Music",
                              "dance" = "Dance",
                              "architecture" = "Architectural design",
                              "writing" = "Writing", 
                              "humor" = "Humor",
                              "inventions" = "Inventions",
                              "theater_film" = "Theater and film",
                              "culinary_arts" = "Culinary arts") %>%
  group_by(ID) %>% mutate("order" = 1:n()) %>%
  select(ID, prompt, response, order, rating:CAQTotal)

write_excel_csv(arabic1, "processed/arabic1.csv")
