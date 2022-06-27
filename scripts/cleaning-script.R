library(tidyverse)
library(readxl)
library(dplyr)

#English
english1 <- read_excel("raw-data/Chinese/AUT_materialBase.xlsx", sheet = 2) 
english1 <- english1 %>% dplyr::rename("ID" = "id",
                                       "prompt" = "item") %>%
  dplyr::select(ID, prompt, response, rater1, rater2, rater3, rater4) %>%
  write_excel_csv("processed-data/english1.csv")

english2_aut <- read_csv("raw-data/English/english2/english2_aut.csv") %>% 
  rename("ID" = "id",
         "prompt" = "item") %>%
  select(ID:average)
english2_val <- read_excel("raw-data/English/english2/english2_val.xlsx")
english2 <- merge(english2_aut, english2_val, all = TRUE)
write_excel_csv(english2, "processed-data/english2.csv")

english3_aut <- read_csv("raw-data/English/english3/english3_aut.csv") %>%
  rename("ID" = "id",
         "prompt" = "item")
english3_val <- read_excel("raw-data/English/english3/english3_val.xlsx") %>%
  rename("ID" = "id")
english3 <- merge(english3_aut, english3_val, all = TRUE)
write_excel_csv(english3, "processed-data/english3.csv")

english4_aut <- read_csv("raw-data/English/english4/english4_aut.csv") %>%
  rename("ID" = "id",
         "prompt" = "item")
english4_val <- read_excel("raw-data/English/english4/english4_val.xlsx") %>%
  rename("ID" = "id",
         "openness_avg" = "o_average")
english4 <- merge(english4_aut, english4_val, all = TRUE)
write_excel_csv(english4, "processed-data/english4.csv")

english5_aut <- read_csv("raw-data/English/english5/english5_aut.csv") %>%
  rename("ID" = "id",
         "prompt" = "item")
english5_val <- read_excel("raw-data/English/english5/english5_val.xlsx") %>%
  rename("ID" = "id",
         "openness" = "o_ffi")
english5 <- merge(english5_aut, english5_val, all = TRUE)
write_excel_csv(english5, "processed-data/english5.csv")

english6_aut <- read_csv("raw-data/English/english6/english6_aut.csv") %>%
  rename("ID" = "id",
         "prompt" = "item")
english6_val <- read_excel("raw-data/English/english6/english6_val.xlsx") %>%
  rename("ID" = "subject")
english6 <- merge(english6_aut, english6_val, all = TRUE)
write_excel_csv(english6, "processed-data/english6.csv")

#Arabic
arabic1 <- read_excel("raw-data/Arabic/Arabic SemDis data .xlsx")

arabic1 <- arabic1 %>% rename("prompt" = "AUT item",
                              "response" = "AUT response",
                              "rater1" = "AUT rating",
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
  group_by(ID) %>% mutate("order" = 1:n()) %>% mutate(lab = 1) %>% mutate(set = 1) %>%
  select(ID, prompt, response, set, lab, order, rater1:CAQTotal) %>%
  write_excel_csv("processed-data/arabic1.csv")

write_excel_csv(arabic1, "processed/merged/arabic_all.csv")

#Chinese 
chinese1 <- read_excel("raw-data/Chinese/AUT_materialBase.xlsx", sheet = 1) 
english1 <- read_excel("raw-data/Chinese/AUT_materialBase.xlsx", sheet = 2) 
chinese3 <- read_excel("raw-data/Chinese/chineseaut_withopencaq.xlsx")

chinese1 <- chinese1 %>% dplyr::rename("ID" = "subID",
                                       "prompt" = "item",
                                       "response" = "res") %>%
  dplyr::select(ID, prompt, response, itemID, rater1, rater2, rater3, rater4) %>%
  mutate(set = 2) %>% mutate(lab = 2) %>%
  write_excel_csv("processed-data/chinese1.csv")

#chinese2 is actually English from Beaty/Johnson DO NOT USE
# chinese2 <- chinese2 %>% dplyr::rename("ID" = "id",
#                                        "prompt" = "item") %>%
#   dplyr::select(ID, prompt, response, rater1, rater2, rater3, rater4) %>%
#   mutate(set = 2) %>%
#   write_excel_csv("processed/chinese2.csv")

chinese2 <- chinese3 %>% dplyr::rename("ID" = "subID",
                                       "prompt" = "item") %>%
  dplyr::select(ID, prompt, response, item_english, rater1, rater2, rater3, rater4, openness, CAQ) %>%
  mutate(set = 3) %>% mutate(lab = 2) %>% 
  write_excel_csv("processed-data/chinese2.csv")

chineseMergeCols <- c("ID", "prompt", "response", "set", "lab", "rater1", "rater2", "rater3", "rater4")
chinese_all <- merge(chinese1, chinese2, all = TRUE)
write_excel_csv(chinese_all, "processed/merged/chinese_all.csv")

#Dutch
dutch1 <- read.csv("raw-data/Dutch/StevensonBaas_ERB6990_aut.csv")
dutch2 <- read.csv("raw-data/Dutch/StevensonBaas_ERB8309_aut.csv")
dutch3 <- read.csv("raw-data/Dutch/StevensonBaas_ERB8684_aut.csv")
dutch3_data <- read.csv("raw-data/Dutch/StevensonBaas_ERB8684_caq_tcttJS_ttctPI.csv")
dutch4 <- read.csv("raw-data/Dutch/StevensonBaas_ERB11501_aut.csv")
dutch4_data <- read.csv("raw-data/Dutch/StevensonBaas_ERB11501_caq_kdocs.csv")

dutch1 <- dutch1 %>% dplyr::rename("ID" = "respondent_id",
                                   "prompt" = "object",
                                   "response" = "original_response",
                                   "response_cleaned" = "cleaned_response",
                                   "rater1" = "originality_rater01",
                                   "rater2" = "originality_rater02") %>%
  mutate(set = 4, lab = 3) %>%
  dplyr::select(ID, prompt, response, set, lab, response_cleaned, rater1, rater2) %>%
  write_excel_csv("processed-data/dutch1.csv")
  
dutch2 <- dutch2 %>% dplyr::rename("ID" = "respondent_id",
                                   "prompt" = "object",
                                   "response" = "original_response",
                                   "response_cleaned" = "cleaned_response",
                                   "rater1" = "originality_rater01",
                                   "rater2" = "originality_rater02") %>%
  mutate(set = 5, lab = 3) %>%
  dplyr::select(ID, prompt, response, set, lab, response_cleaned, rater1, rater2) %>%
  write_excel_csv("processed-data/dutch2.csv")

dutch3_data <- dutch3_data %>% dplyr::rename("ID" = "respondent_id") %>%
  select(ID, Total_CAQ, PI_originalityMean, JS_originalityMean) 

dutch3_data <- unique(dutch3_data)
  
dutch3 <- dutch3 %>% dplyr::rename("ID" = "respondent_id",
                                   "prompt" = "object",
                                   "response" = "original_response",
                                   "response_cleaned" = "cleaned_response",
                                   "rater1" = "originality_rater01",
                                   "rater2" = "originality_rater02") %>%
  mutate(set = 6, lab = 3) %>%
  dplyr::select(ID, prompt, response, set, lab, response_cleaned, rater1, rater2)

dutch3_merged <- dutch3 %>% merge(dutch3_data, by = "ID") %>%
  write_excel_csv("processed-data/dutch3.csv")

dutch4 <- dutch4 %>% dplyr::rename("ID" = "respondent_id",
                                   "prompt" = "object",
                                   "response" = "original_response",
                                   "response_cleaned" = "cleaned_response",
                                   "rater1" = "originality_rater01",
                                   "rater2" = "originality_rater02",
                                   "rater3" = "originality_rater03") %>%
  mutate(set = 7, lab = 3) %>%
  dplyr::select(ID, prompt, response, set, lab, response_cleaned, rater1, rater2, rater3)

dutch4_data <- dutch4_data %>% dplyr::rename("ID" = "respondent_id") %>%
  select(ID, Total_CAQ, Total_KDOCS)

dutch4_data <- unique(dutch4_data)

dutch4_merged <- dutch4 %>% full_join(dutch4_data, by = "ID") %>%
  write_excel_csv("processed-data/dutch4.csv")

dutch_all <- merge(dutch1, dutch2, all = TRUE)
dutch_all <- merge(dutch_all, dutch3_merged, all = TRUE)
dutch_all <- merge(dutch_all, dutch4_merged, all = TRUE) %>%
  write_excel_csv("processed/merged/dutch_all.csv")

#French
french1 <- read_excel("raw-data/French/Volle_AUT_CREAFLEX_data4Beaty_V2.xlsx", sheet = 2)

french1 <- french1 %>% dplyr::rename("ID" = "ID...1",
                                    "prompt" = "item",
                                    "response" = "idea",
                                     "rater1" = "coder1",
                                     "rater2" = "coder2",
                                     "rater3" = "coder3",
                                     "rater4" = "coder4") %>%
  mutate(set = 8, lab = 4) %>%
  dplyr::select(ID, prompt, response, set, lab, rater1, rater2, rater3, rater4, "C-act", "C-ach") %>%
  write_excel_csv("processed-data/french1.csv")

french2 <- read.csv("raw-data/French/AUTbelgium.csv")
french2 <- french2 %>% dplyr::rename("ID" = "ï..userid",
                                     "age" = "AgeNum",
                                     "sex" = "sexe",
                                     "condition" = "Condition",
                                     "response" = "value",
                                     "rater1" = "J1",
                                     "rater2" = "J2",
                                     "rater3" = "J3") %>%
  mutate(set = 9, lab = 5, prompt = "chapeau") %>%
  dplyr::select(ID, prompt, response, set, lab, rater1, rater2, rater3, age, sex, condition, timebegin, timeend, Valid, CAT) %>%
  write_excel_csv("processed-data/french2.csv")

french3_ceinture <- read_excel("raw-data/French/data_survey.xlsx", sheet = 1) %>% mutate("prompt" = "ceinture", "lab" = 6, "set" = 10)
french3_brouette <- read_excel("raw-data/French/data_survey.xlsx", sheet = 2) %>% mutate("prompt" = "brouette", "lab" = 6, "set" = 10)
french3_data <- read_excel("raw-data/French/data_survey.xlsx", sheet = 3) %>%
  rename("ppt_id" = "id")

french3_task <- merge(french3_brouette, french3_ceinture, all = TRUE)
french3 <- merge(french3_task, french3_data, by = "ppt_id")
french3 <- french3 %>% dplyr::rename("ID" = "ppt_id",
                                     "response" = "idea",
                                     "rater1" = "Judge_A",
                                     "rater2" = "Judge_B",
                                     "rater3" = "Judge_C") %>%
  select(ID, prompt, response, set, lab, rater1, rater2, rater3, Fluency_Ceinture, Fluency_Brouette, Fluency_avrg, Orig_Ceinture, Orig_Brouette, Orig_avrg, CSE, CPI, Openness, Gender, Nationality, Age) %>%
  write_excel_csv("processed-data/french3.csv")
                                    
french4_ceinture <- read_excel("raw-data/French/data_expe.xlsx", sheet = 1) %>% mutate("prompt" = "ceinture", "lab" = 6, "set" = 11)
french4_brouette <- read_excel("raw-data/French/data_expe.xlsx", sheet = 2) %>% mutate("prompt" = "brouette", "lab" = 6, "set" = 11)
french4_data <- read_excel("raw-data/French/data_expe.xlsx", sheet = 3) %>%
  rename("ppt_id" = "id")

french4_task <- merge(french4_brouette, french4_ceinture, all = TRUE)
french4 <- merge(french4_task, french4_data, by = "ppt_id")
french4 <- french4 %>% dplyr::rename("ID" = "ppt_id",
                                     "response" = "idea",
                                     "rater1" = "Judge_A",
                                     "rater2" = "Judge_B",
                                     "rater3" = "Judge_C",
                                     "native_french" = "Fr_mat") %>%
  select(ID, prompt, response, set, lab, rater1, rater2, rater3, Fluency_Ceinture, Fluency_Brouette, Fluency_avrg, Orig_Ceinture, Orig_brouette, Orig_avrg, CSE, CPI, Openness,
         Age, Gender, native_french) %>%
  write_excel_csv("processed-data/french4.csv")


#German
german1_konservendose <- read_excel("raw-data/German/NEMOData_DT.xls", sheet = 1) %>% mutate("prompt" = "konservendose", "set" = 12, "lab" = 7)
german1_messer <- read_excel("raw-data/German/NEMOData_DT.xls", sheet = 2) %>% mutate("prompt" = "messer", "set" = 12, "lab" = 7)
german1_haarfoehn <- read_excel("raw-data/German/NEMOData_DT.xls", sheet = 3) %>% mutate("prompt" = "haarfoehn", "set" = 12, "lab" = 7)

german1_data <- read_excel("raw-data/German/NEMOData_Scores.xlsx")

german1_data <- german1_data %>% rename("ID" = "NEMO_Nr")

german1 <- do.call("rbind", list(german1_konservendose, german1_messer, german1_haarfoehn)) %>% 
  rename("ID" = "Person", "response" = "Response...1", "responseorder" = "Response...3",
         "rating" = "Rating",
         "rater1" = "R1",
         "rater2" = "R2",
         "rater3" = "R3",
         "rater4" = "R4") %>%
  select(ID, prompt, response, set, lab, responseorder, rating, rater1, rater2, rater3, rater4)

german1_all <- merge(german1, german1_data, by = "ID")
write_excel_csv(german1_all, "processed-data/german1.csv")

load("raw-data/German/german2.rda")
load("raw-data/German/german2_dat.rda")

ori.dat <- ori.dat %>% rename("ID" = "subject_id",
                              "prompt" = "object",
                              "response" = "idea",
                              "rater1" = "Rater1",
                              "rater2" = "Rater2",
                              "rater3" = "Rater3") %>%
  mutate("set" = 13, "lab" = 8)
dat.rwa <- dat.rwa %>% rename("ID" = "subject_id")

german2 <- merge(ori.dat, dat.rwa, by = "ID")
german2 <- as.data.frame(german2)
write_excel_csv(german2, "processed-data/german2.csv")

german1 <- read_csv("processed/german1.csv")
german2 <- read_csv("processed/german2.csv")

load("raw-data/German/serial_order_data.rda")

german3 <- dat %>% rename("ID" = "subject_id",
                          "prompt" = "object", 
                          "order" = "trialnum",
                          "response" = "idea",
                          "rater1" = "quality.ruben",
                          "rater2" = "quality.karin",
                          "rater3" = "quality.paula") %>%
  mutate("set" = 14, "lab" = 8) %>%
  select(ID, prompt, response, set, lab, order, rater1, rater2, rater3, latency, X1, blockcode:fbin) %>%
  write_excel_csv("processed-data/german3.csv")

#Hebrew
hebrew1 <- read_csv("raw-data/Hebrew/FINAL_OBJECT_USE_SCORES-2.csv")
hebrew1 <- hebrew1 %>% rename("ID" = "participant ID",
                              "prompt" = "object",
                              "order" = "use_number",
                              "response" = "use",
                              "rater1" = "rater_1",
                              "rater2" = "rater_2",
                              "rater3" = "rater_3",
                              "rater4" = "rater_4",
                              "rater5" = "rater_5",
                              "rater6" = "rater_6",
                              "rater7" = "rater_7",
                              "rater8" = "rater_8",
                              "rater9" = "rater_9",
                              "rater10" = "rater_10",
                              "rater11" = "rater_11",
                              "rater12" = "rater_12",
                              "rater13" = "rater_13",
                              "rater14" = "rater_14",
                              "rater15" = "rater_15",
                              "rater16" = "rater_16",
                              "rater17" = "rater_17",
                              "rater18" = "rater_18",
                              "rater19" = "rater_19",
                              "rater20" = "rater_20",
                              "rater21" = "rater_21",
                              "rater22" = "rater_22",
                              "rater23" = "rater_23",
                              "rater24" = "rater_24",
                              "rater25" = "rater_25",
                              "rater26" = "rater_26",
                              "rater27" = "rater_27",
                              "rater28" = "rater_28",
                              "rater29" = "rater_29",
                              "rater30" = "rater_30",
                              "rater31" = "rater_31",
                              "rater32" = "rater_32",
                              "rater33" = "rater_33",
                              "rater34" = "rater_34",
                              "rater35" = "rater_35",
                              "rater36" = "rater_36",
                              "rater37" = "rater_37",
                              "rater38" = "rater_38",
                              "rater39" = "rater_39",
                              "rater40" = "rater_40",
                              "rater41" = "rater_41",
                              "rater42" = "rater_42",
                              "rater43" = "rater_43",
                              "rater44" = "rater_44",
                              "rater45" = "rater_45") %>%
  mutate(set = 15, lab = 9) %>%
  select(ID, prompt, response, set, lab, order, rater1:rater45) %>%
  write_excel_csv("processed-data/hebrew1.csv")

#Italian
italian1 <- read_excel("raw-data/Italian/italian1.xlsx")
italian2 <- read_excel("raw-data/Italian/italian2.xlsx")

italian1 <- italian1 %>% dplyr::rename("prompt" = "Item", "response" = "ALTERNATIVERESPONSE",
                                       "rater1" = "Coder1", "rater2" = "Coder2") %>%
  mutate(set = 16) %>% mutate(lab = 10) %>%
  dplyr::select(ID, prompt, response, set, lab, rater1, rater2, CAAC_TOT, NEO_OPEN) %>%
  write_excel_csv("processed-data/italian1.csv")

italian2 <- italian2 %>% dplyr::rename("prompt" = "Item", "response" = "Alternativeresponse",
                                       "rater1" = "Coder1", "rater2" = "Coder2") %>%
  mutate(set = 17) %>% mutate(lab = 10) %>%
  dplyr::select(ID, prompt, response, set, lab, rater1, rater2, CAAC_TOT, Openness) %>%
  write_excel_csv("processed-data/italian2.csv")

italian_all <- merge(italian1, italian2, all = TRUE)
write_excel_csv(italian_all, "processed/merged/italian_all.csv")

#Polish
polish1 <- read_excel("raw-data/Polish/Can-Brick-complete(S1).xlsx")
polish2 <- read_excel("raw-data/Polish/String-Can-Brick(S2).xlsx")

polish1 <- polish1 %>% dplyr::rename("ID" = "id", "prompt" = "item",
                                     "rater1" = "coder1", "rater2" = "coder2", "rater3" = "coder3") %>%
  mutate(set = 18, lab = 11) %>%
  dplyr::select(ID, prompt, response, set, lab, lp, order, rater1, rater2, rater3, iq_all:lnmusic) %>%
  write_excel_csv("processed-data/polish1.csv")

polish2 <- polish2 %>% dplyr::rename("prompt" = "item",
                                     "rater1" = "coder1", "rater2" = "coder2", "rater3" = "coder3", "rater4" = "coder4") %>%
  mutate(set = 19, lab = 11) %>%
  dplyr::select(ID, prompt, response, set, lab, lp, order, rater1, rater2, rater3, rater4, Extr:age) %>%
  write_excel_csv("processed-data/polish2.csv")

# polish3 <- read_excel("raw-data/Polish/within_subject_dt.xlsx")
# polish3_responses <- polish3 %>% select(ID:ideas_ovulat)
#   pivot_longer(cols = "ideas_period": "ideas_ovulat",
#                                     names_to = c("response", "cyclephase"),
#                                     names_sep = "_") %>%
  

polish_all <- merge(polish1, polish2, all = TRUE) %>%
  select(ID, prompt, response, set, lp, order, rater1, rater2, rater3, rater4, "iq_all":"age") %>%
  write_excel_csv("processed/merged/polish_all.csv")

#Portugese
portugese1 <- read_excel("raw-data/Portugese/data_br_primi - Ricardo Primi.xlsx")
portugese1 <- portugese1 %>% dplyr::rename("ID" = "id",
                            "order" = "resp_num",
                            "prompt" = "ativi",
                            "response" = "resposta",
                            "rater1" = "scr_carol",
                            "rater2" = "scr_karina",
                            "rater3" = "scr_cibelle",
                            "rater4" = "scr_yara",
                            "sd_raters" = "desv_pad",
                            "max_min_raters" = "max_min",
                            "n_judges" = "num_correções") %>%
  mutate("set" = 20, "lab" = 12) %>% mutate(prompt = replace(prompt, prompt == 1, "caixa de papelão"),
                                            prompt = replace(prompt, prompt == 2, "tijolo")) %>%
  select(ID, prompt, response, set, lab, order, rater1, rater2, rater3, rater4, 
         pre_pos, grp20, grp60, grp80, sd_raters, max_min_raters, n_judges) %>%
  write_excel_csv("processed/portugese1.csv")

#Russian
russian1 <- read_excel("raw-data/Russian/russian_thisone.xlsx", sheet = 1)
russian2 <- read_excel("raw-data/Russian/russian_thisone.xlsx", sheet = 2)

russian1 <- russian1 %>% dplyr::rename("ID" = "id", "prompt" = "item",
                                       "rater1" = "coder1", "rater2" = "coder2", "rater3" = "coder3") %>%
  mutate(set = 21, lab = 13) %>%
  dplyr::select(ID, prompt, response, set, lab, rater1, rater2, rater3) %>%
  write_excel_csv("processed-data/russian1.csv")

russian2 <- russian2 %>% dplyr::rename("ID" = "id", "prompt" = "item",
                                       "rater1" = "coder1", "rater2" = "coder2", "rater3" = "coder3") %>%
  mutate(set = 22, lab = 13) %>%
  dplyr::select(ID, prompt, response, set, lab, rater1, rater2, rater3, "RAPM-Gf":"BFI-Neuroticism") %>%
  write_excel_csv("processed-data/russian2.csv")

russian_all <- merge(russian1, russian2, all = TRUE) %>%
  write_excel_csv("processed/merged/russian_all.csv")

#Spanish
spanish1 <- read.csv("raw-data/Spanish/spanish1.csv", na.strings = c("", "NA"))

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
                                values_to = "ratings", values_drop_na = TRUE) %>%
  pivot_wider(names_from = rater, values_from = ratings)

spanish1_demog <- spanish1 %>% rename("ID" = "ï..ID") %>% select(ID, age, sex, starts_with("cse"))

spanish1_validation <- merge(spanish1_ratings, spanish1_demog, by = "ID")

spanish1_all <- merge(spanish1_responses, spanish1_validation, by = c("ID", "order")) %>%
  mutate(lab = 14, set = 23)%>%
  select(ID, prompt, response, set, lab, order, rater1:cse11) %>% arrange(ID, order)

write_excel_csv(spanish1_all, "processed-data/spanish1.csv")


