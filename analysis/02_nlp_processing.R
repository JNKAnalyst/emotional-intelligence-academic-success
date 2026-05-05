# 02_nlp_processing.R
# Apply NLP techniques to open-ended survey responses: tokenization,
# sentiment scoring, emotional vocabulary counts, and term-document features.

suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(readr)
  library(stringr)
  library(tidytext)
  library(syuzhet)
})

source("config/config.R")

EMOTION_LEXICON <- c(
  "happy", "sad", "anxious", "frustrated", "calm", "proud",
  "ashamed", "hopeful", "angry", "grateful", "lonely", "confident",
  "overwhelmed", "motivated", "discouraged", "curious"
)

score_sentiment <- function(text, method = SENTIMENT_METHOD) {
  if (method == "syuzhet") {
    get_sentiment(text, method = "syuzhet")
  } else if (method == "bing") {
    get_sentiment(text, method = "bing")
  } else if (method == "afinn") {
    get_sentiment(text, method = "afinn")
  } else {
    stop("Unknown SENTIMENT_METHOD: ", method)
  }
}

count_emotional_vocab <- function(text, lexicon = EMOTION_LEXICON) {
  tokens <- str_split(str_to_lower(text), "\\W+")[[1]]
  sum(tokens %in% lexicon)
}

extract_nrc_emotions <- function(text) {
  emo <- get_nrc_sentiment(text)
  as_tibble(emo)
}

build_features <- function(df) {
  df %>%
    mutate(
      sentiment_compound    = vapply(open_response, score_sentiment, numeric(1)),
      emotional_vocab_count = vapply(open_response, count_emotional_vocab, integer(1)),
      response_length       = str_count(open_response, "\\w+")
    )
}

main <- function() {
  cleaned <- read_csv("data/cleaned_survey_data.csv", show_col_types = FALSE)
  features <- build_features(cleaned)
  out_path <- file.path("data", "features.csv")
  write_csv(features, out_path)
  message("Wrote NLP feature table: ", out_path)
  invisible(features)
}

if (sys.nframe() == 0) {
  main()
}
