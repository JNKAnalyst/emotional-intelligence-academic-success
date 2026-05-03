# Emotional Intelligence as a Predictor of Academic Success

> R-based NLP and advanced statistical analysis measuring emotional intelligence as a predictor of academic performance

## Overview

This project transforms unstructured student sentiment data into quantifiable behavioral indicators using R and NLP. Regression analysis demonstrated a significant EI-to-performance correlation coefficient of **0.68**, validating emotional intelligence as a meaningful predictor of academic outcomes.

**Key Result:** Correlation coefficient of **r = 0.68** between EI indicators and academic performance scores.

## Tools & Technologies

| Tool | Purpose |
|------|---------|
| R | Core analysis language |
| tidytext / tm | NLP and text mining |
| ggplot2 | Data visualization |
| caret | Regression modeling |
| dplyr / tidyr | Data wrangling |
| RMarkdown | Reproducible reporting |

## Repository Structure

```
emotional-intelligence-academic-success/
├── README.md
├── analysis/
│   ├── 01_data_cleaning.R
│   ├── 02_nlp_processing.R
│   ├── 03_regression_analysis.R
│   └── 04_visualization.R
├── reports/
│   └── ei_academic_report.Rmd     # Full RMarkdown report
├── data/
│   └── sample_survey_data.csv     # Sample anonymized dataset
├── config/
│   └── config.R                   # Central configuration file
├── renv.lock                      # Reproducible R environment
└── .Rprofile
```

## Environment Setup

### Prerequisites
- R 4.3+ ([Download](https://cran.r-project.org/))
- RStudio ([Download](https://posit.co/download/rstudio-desktop/)) — recommended
- `renv` package for reproducible environments

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/JNKAnalyst/emotional-intelligence-academic-success.git
   cd emotional-intelligence-academic-success
   ```

2. **Open the project in RStudio**
   - Open `emotional-intelligence-academic-success.Rproj` (or open RStudio and set this as working directory)

3. **Restore the R environment**
   ```r
   install.packages("renv")
   renv::restore()
   ```
   This installs all required packages at the exact versions used in the project.

4. **Manual package install (alternative to renv)**
   ```r
   install.packages(c(
     "tidytext", "tm", "ggplot2", "caret",
     "dplyr", "tidyr", "rmarkdown", "knitr",
     "syuzhet", "corrplot", "lmtest"
   ))
   ```

## Configuration

### `config/config.R`
```r
# Data paths
DATA_PATH      <- "data/survey_data.csv"
OUTPUT_PATH    <- "reports/output/"

# NLP settings
SENTIMENT_METHOD  <- "syuzhet"   # Options: "syuzhet", "bing", "afinn"
MIN_WORD_FREQ     <- 3           # Minimum word frequency for term matrix

# Model settings
TEST_SPLIT        <- 0.2
RANDOM_SEED       <- 42
CV_FOLDS          <- 5

# Target variable
TARGET_VAR        <- "gpa_score"
EI_PREDICTORS     <- c("empathy_score", "self_awareness", "social_skills",
                        "sentiment_compound", "emotional_vocab_count")
```

## Running the Analysis

```r
# Run scripts in order from RStudio or terminal:
source("analysis/01_data_cleaning.R")
source("analysis/02_nlp_processing.R")
source("analysis/03_regression_analysis.R")
source("analysis/04_visualization.R")

# Or render the full RMarkdown report:
rmarkdown::render("reports/ei_academic_report.Rmd")
```

## Key Packages

| Package | Version | Purpose |
|---------|---------|---------|
| tidytext | 0.4.1 | Text mining in tidy format |
| syuzhet | 1.0.7 | Sentiment extraction |
| caret | 6.0-94 | Regression modeling |
| ggplot2 | 3.4.4 | Visualization |
| tm | 0.7-11 | Text preprocessing |

## Results Summary

| Metric | Value |
|--------|-------|
| Correlation (r) | 0.68 |
| p-value | < 0.001 |
| R² (regression) | 0.46 |
| Method | Multiple linear regression with NLP-derived features |

## Author

**Joash** | MS Business Analytics  
[GitHub](https://github.com/JNKAnalyst) | [Portfolio](https://jnkanalyst.github.io/portfolio/)
