arabic1_clean <- read_csv("processed/arabic1.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "arabic1")
chinese1_clean <- read_csv("processed/chinese1.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "chinese1")
chinese2_clean <- read_csv("processed/chinese2.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "chinese2")
dutch1_clean <- read_csv("processed/dutch1.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "dutch1")
dutch2_clean <- read_csv("processed/dutch2.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "dutch2")
dutch3_clean <- read_csv("processed/dutch3.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "dutch3")
dutch4_clean <- read_csv("processed/dutch4.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "dutch4")
french1_clean <- read_csv("processed/french1.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "french1")
french2_clean <- read_csv("processed/french2.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "french2")
french3_clean <- read_csv("processed/french3.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "french3")
french4_clean <- read_csv("processed/french4.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "french4")
german1_clean <- read_csv("processed/german1.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "german1")
german2_clean <- read_csv("processed/german2.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "german2")
german3_clean <- read_csv("processed/german3.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "german3")
hebrew1_clean <- read_csv("processed/hebrew1.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "hebrew1")
italian1_clean <- read_csv("processed/italian1.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "italian1")
italian2_clean <- read_csv("processed/italian2.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "italian2")
polish1_clean <- read_csv("processed/polish1.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "polish1")
polish2_clean <- read_csv("processed/polish2.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "polish2")
russian1_clean <- read_csv("processed/russian1.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "russian1")
russian2_clean <- read_csv("processed/russian2.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "russian2")
spanish1_clean <- read_csv("processed/spanish1.csv") %>%
  select(ID, prompt, response) %>% mutate("set" = "spanish1")

multi_all <- arabic1_clean %>%
  merge(chinese1_clean, all = TRUE) %>%
  merge(chinese2_clean, all = TRUE) %>%
  merge(dutch1_clean, all = TRUE) %>%
  merge(dutch2_clean, all = TRUE) %>%
  merge(dutch3_clean, all = TRUE) %>%
  merge(dutch4_clean, all = TRUE) %>%
  merge(french1_clean, all = TRUE) %>%
  merge(french2_clean, all = TRUE) %>%
  merge(french3_clean, all = TRUE) %>%
  merge(french4_clean, all = TRUE) %>%
  merge(german1_clean, all = TRUE) %>%
  merge(german2_clean, all = TRUE) %>%
  merge(german3_clean, all = TRUE) %>%
  merge(hebrew1_clean, all = TRUE) %>%
  merge(italian1_clean, all = TRUE) %>%
  merge(italian2_clean, all = TRUE) %>%
  merge(polish1_clean, all = TRUE) %>% 
  merge(polish2_clean, all = TRUE) %>% 
  merge(russian1_clean, all = TRUE) %>% 
  merge(russian2_clean, all = TRUE) %>% 
  merge(spanish1_clean, all = TRUE)

responses <- multi_all %>% group_by(set) %>%
  summarise(responseCount=n()) 
subs <- multi_all %>% group_by(set, ID) %>%
  summarise(subjectResponses=n())
subs_set <- subs %>% group_by(set) %>%
  summarise(subsBySet=n())

counts <- merge(responses, subs_set, by = "set") %>%
  rename("totalResponses" = "responseCount",
         "N" = "subsBySet") %>%
  select(set, N, totalResponses) %>% 
  write_excel_csv("countstable.csv")

#merging
arabic_all <- arabic1_clean %>% 
  write_excel_csv("merged/arabic_all.csv")

chinese_all <- chinese1_clean %>%
  merge(chinese2_clean, all = TRUE) %>%
  write_excel_csv("merged/chinese_all.csv")

dutch_all <- dutch1_clean %>%
  merge(dutch2_clean, all = TRUE) %>%
  merge(dutch3_clean, all = TRUE) %>%
  merge(dutch4_clean, all = TRUE) %>%
  write_excel_csv("merged/dutch_all.csv")

french_all <- french1_clean %>%
  merge(french2_clean, all = TRUE) %>%
  merge(french3_clean, all = TRUE) %>%
  merge(french4_clean, all = TRUE) %>%
  write_excel_csv("merged/french_all.csv")

german_all <- german1_clean %>%
  merge(german2_clean, all = TRUE) %>%
  merge(german3_clean, all = TRUE) %>%
  write_excel_csv("merged/german_all.csv")

hebrew_all <- hebrew1_clean %>%
  write_excel_csv("merged/hebrew_all.csv")

italian_all <- italian1_clean %>%
  merge(italian2_clean, all = TRUE) %>%
  write_excel_csv("merged/italian_all.csv")

polish_all <- polish1_clean %>%
  merge(polish2_clean, all = TRUE) %>%
  write_excel_csv("merged/polish_all.csv")

russian_all <- russian1_clean %>%
  merge(russian2_clean, all = TRUE) %>%
  write_excel_csv("merged/russian_all.csv")

spanish_all <- spanish1_clean %>%
  write_excel_csv("merged/spanish_all.csv")
