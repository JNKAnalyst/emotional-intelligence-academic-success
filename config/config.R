# ── Configuration for EI Academic Success Analysis ──

# Data paths
DATA_PATH      <- "data/survey_data.csv"
OUTPUT_PATH    <- "reports/output/"

# NLP settings
SENTIMENT_METHOD  <- "syuzhet"   # Options: "syuzhet", "bing", "afinn"
MIN_WORD_FREQ     <- 3

# Model settings
TEST_SPLIT        <- 0.2
RANDOM_SEED       <- 42
CV_FOLDS          <- 5

# Target variable
TARGET_VAR        <- "gpa_score"
EI_PREDICTORS     <- c("empathy_score", "self_awareness", "social_skills",
                        "sentiment_compound", "emotional_vocab_count")
