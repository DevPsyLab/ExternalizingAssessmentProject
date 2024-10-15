

# Install and load necessary packages
install.packages("googlesheets4")
install.packages("dplyr")
install.packages("tidyr")
install.packages("purrr")
install.packages("tibble")

library(googlesheets4)
library(dplyr)
library(tidyr)
library(purrr)
library(tibble)

# Read the first spreadsheet (Question Items)
sheet1_url <- "https://docs.google.com/spreadsheets/d/1sRYBIRvqLvuXzQyngoaQC_nv-eT85VRig4zxwWPLvFs/edit?gid=0#gid=0"
sheet1 <- read_sheet(sheet1_url, sheet = "Child Items - Short List")

# Read the second spreadsheet (Target Spreadsheet)
sheet2_url <- "https://docs.google.com/spreadsheets/d/1sRYBIRvqLvuXzQyngoaQC_nv-eT85VRig4zxwWPLvFs/edit?gid=1523097369#gid=1523097369"
sheet2 <- read_sheet(sheet2_url, sheet = "Item Crosswalk")

## Step 1

# Ensure that ageMin and ageMax are numeric and replace any remaining NA with 0s
sheet1 <- sheet1 %>%
  mutate(
    ageMin = as.numeric(ageMin),
    ageMax = as.numeric(ageMax)
  )

sheet1[is.na(sheet1)] <- 0

# Create columns for self, parent, and teacher applicable ages
sheet1 <- sheet1 %>%
  rowwise() %>%
  mutate(
    self_ages = ifelse(selfReport == 1 & !is.na(ageMin) & !is.na(ageMax) & ageMin <= ageMax, 
                       list(paste0("s", seq(ageMin, ageMax, by = 1))), list(NA)),
    parent_ages = ifelse(parentReport == 1 & !is.na(ageMin) & !is.na(ageMax) & ageMin <= ageMax, 
                         list(paste0("p", seq(ageMin, ageMax, by = 1))), list(NA)),
    teacher_ages = ifelse(teacherReport == 1 & !is.na(ageMin) & !is.na(ageMax) & ageMin <= ageMax, 
                          list(paste0("t", seq(ageMin, ageMax, by = 1))), list(NA))
  ) %>%
  ungroup()

# Unnest the columns to create one row per applicable age per item
sheet1 <- sheet1 %>%
  unnest(cols = c(self_ages, parent_ages, teacher_ages))


## Step 2
sheet2 <- sheet1 %>%
  dplyr::select(facet, item) %>%
  distinct() %>%
  rename(wording_self = item)

# Add columns for all the ages you expect in sheet2 based on self, parent, and teacher reports
# Assuming ages range from 1 to 17 for teacher and parent reports, and 11 to 17 for self report
self_cols <- paste0("s", 11:17)
teacher_cols <- paste0("t", 1:17)
parent_cols <- paste0("p", 1:17)

# Add these columns to sheet2, initialized with NA
sheet2 <- sheet2 %>%
  add_column(!!!setNames(rep(list(NA_character_), length(c(self_cols, teacher_cols, parent_cols))), 
                         c(self_cols, teacher_cols, parent_cols)))


for (i in seq_len(nrow(sheet1))) {
  item_name <- sheet1$item[i]
  self_age <- sheet1$self_ages[i]
  parent_age <- sheet1$parent_ages[i]
  teacher_age <- sheet1$teacher_ages[i]
  
  # Find the matching row in sheet2
  match_row <- which(sheet2$wording_self == item_name)
  
  # Add 'x' in the appropriate columns for self, parent, and teacher reports
  if (!is.na(self_age) && self_age %in% colnames(sheet2)) {
    sheet2[match_row, self_age] <- "x"
  }
  
  if (!is.na(parent_age) && parent_age %in% colnames(sheet2)) {
    sheet2[match_row, parent_age] <- "x"
  }
  
  if (!is.na(teacher_age) && teacher_age %in% colnames(sheet2)) {
    sheet2[match_row, teacher_age] <- "x"
  }
}



sheet_write(sheet2, ss = sheet2_url, sheet = "Sheet1")









