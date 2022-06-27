arabic1_clean <- read_csv("proc-w-valid/arabic1.csv") %>%
  select(ID, prompt, response, set, lab, rater1) 
chinese1_clean <- read_csv("proc-w-valid/chinese1.csv") %>%
  select(ID, prompt, response, set, lab, rater1, rater2, rater3, rater4) 
chinese2_clean <- read_csv("proc-w-valid/chinese2.csv") %>%
  select(ID, prompt, response, set, lab, rater1, rater2, rater3, rater4)
dutch1_clean <- read_csv("proc-w-valid/dutch1.csv") %>%
  select(ID, prompt, response, set, lab, rater1, rater2)
dutch2_clean <- read_csv("proc-w-valid/dutch2.csv") %>%
  select(ID, prompt, response, set, lab, rater1, rater2)
dutch3_clean <- read_csv("proc-w-valid/dutch3.csv") %>%
  select(ID, prompt, response, set, lab, rater1, rater2)
dutch4_clean <- read_csv("proc-w-valid/dutch4.csv") %>%
  select(ID, prompt, response, set, lab, rater1, rater2, rater3)
french1_clean <- read_csv("proc-w-valid/french1.csv") %>%
  select(ID, prompt, response, set, lab, rater1, rater2, rater3, rater4)
french2_clean <- read_csv("proc-w-valid/french2.csv") %>%
  select(ID, prompt, response, set, lab, rater1, rater2, rater3)
french3_clean <- read_csv("proc-w-valid/french3.csv") %>%
  select(ID, prompt, response, set, lab, rater1, rater2, rater3)
french4_clean <- read_csv("proc-w-valid/french4.csv") %>%
  select(ID, prompt, response, set, lab, rater1, rater2, rater3)
german1_clean <- read_csv("proc-w-valid/german1.csv") %>%
  select(ID, prompt, response, set, lab, rater1, rater2, rater3, rater4)
german2_clean <- read_csv("proc-w-valid/german2.csv") %>%
  select(ID, prompt, response, set, lab, rater1, rater2, rater3)
german3_clean <- read_csv("proc-w-valid/german3.csv") %>%
  select(ID, prompt, response, set, lab, rater1, rater2, rater3)
hebrew1_clean <- read_csv("proc-w-valid/hebrew1.csv") %>%
  select(ID, prompt, response, set, lab, rater1:rater45)
italian1_clean <- read_csv("proc-w-valid/italian1.csv") %>%
  select(ID, prompt, response, set, lab, rater1, rater2)
italian2_clean <- read_csv("proc-w-valid/italian2.csv") %>%
  select(ID, prompt, response, set, lab, rater1, rater2)
polish1_clean <- read_csv("proc-w-valid/polish1.csv") %>%
  select(ID, prompt, response, set, lab, rater1:rater3)
polish2_clean <- read_csv("proc-w-valid/polish2.csv") %>%
  select(ID, prompt, response, set, lab, rater1:rater3)
russian1_clean <- read_csv("proc-w-valid/russian1.csv") %>%
  select(ID, prompt, response, set, lab, rater1:rater3)
russian2_clean <- read_csv("proc-w-valid/russian2.csv") %>%
  select(ID, prompt, response, set, lab, rater1:rater3)
spanish1_clean <- read_csv("proc-w-valid/spanish1.csv") %>%
  select(ID, prompt, response, set, lab, rater1:rater3)

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
prompts <- multi_all %>% group_by(set) %>% 
  summarise(levels(as.factor(prompt)))
  

counts <- merge(responses, subs_set, by = "set") %>%
  rename("totalResponses" = "responseCount",
         "N" = "subsBySet") %>%
  select(set, N, totalResponses) %>% 
  write_excel_csv("countstable.csv")

responses_by_p <- multi_all %>%
  count(set, ID, .drop = FALSE) %>%
  na.omit()

count <- multi_all %>%
  group_by(set) %>% tally()

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

length(unique(spanish1_clean$ID))
