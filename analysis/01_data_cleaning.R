# 01_data_cleaning.R
# Load raw survey data, validate columns, handle missing values, and write
# a cleaned dataset for downstream NLP and regression steps.

suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(readr)
  library(stringr)
})

source("config/config.R")

read_survey <- function(path = DATA_PATH) {
  if (!file.exists(path)) {
    stop("Survey data not found at: ", path,
         "\nProvide your own file or use data/sample_survey_data.csv.")
  }
  read_csv(path, show_col_types = FALSE)
}

required_columns <- c(
  "student_id", "gpa_score", "empathy_score", "self_awareness",
  "social_skills", "open_response"
)

validate_columns <- function(df, required = required_columns) {
  missing <- setdiff(required, names(df))
  if (length(missing) > 0) {
    stop("Missing required columns: ", paste(missing, collapse = ", "))
  }
  invisible(df)
}

clean_survey <- function(df) {
  df %>%
    validate_columns() %>%
    mutate(
      open_response = str_squish(open_response),
      across(c(gpa_score, empathy_score, self_awareness, social_skills),
             as.numeric)
    ) %>%
    filter(
      !is.na(gpa_score),
      !is.na(open_response),
      nchar(open_response) > 0
    ) %>%
    distinct(student_id, .keep_all = TRUE)
}

main <- function() {
  raw <- read_survey()
  cleaned <- clean_survey(raw)
  out_path <- file.path("data", "cleaned_survey_data.csv")
  write_csv(cleaned, out_path)
  message("Wrote cleaned data: ", out_path,
          " (", nrow(cleaned), " rows)")
  invisible(cleaned)
}

if (sys.nframe() == 0) {
  main()
}
