# 03_regression_analysis.R
# Fit a multiple linear regression using EI indicators and NLP-derived
# features to predict academic performance (GPA). Reports correlation,
# coefficients, and cross-validated R^2.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(caret)
  library(lmtest)
})

source("config/config.R")

set.seed(RANDOM_SEED)

split_data <- function(df, test_split = TEST_SPLIT) {
  idx <- createDataPartition(df[[TARGET_VAR]], p = 1 - test_split, list = FALSE)
  list(train = df[idx, ], test = df[-idx, ])
}

build_formula <- function() {
  rhs <- paste(EI_PREDICTORS, collapse = " + ")
  as.formula(paste(TARGET_VAR, "~", rhs))
}

fit_model <- function(train) {
  ctrl <- trainControl(method = "cv", number = CV_FOLDS)
  train(
    build_formula(),
    data    = train,
    method  = "lm",
    trControl = ctrl
  )
}

evaluate_model <- function(model, test) {
  preds <- predict(model, test)
  observed <- test[[TARGET_VAR]]
  list(
    correlation = cor(preds, observed),
    rmse        = sqrt(mean((preds - observed)^2)),
    r_squared   = cor(preds, observed)^2
  )
}

main <- function() {
  features <- read_csv("data/features.csv", show_col_types = FALSE)
  parts    <- split_data(features)
  model    <- fit_model(parts$train)
  metrics  <- evaluate_model(model, parts$test)

  message("Cross-validated metrics from caret:")
  print(model$results)

  message("\nHold-out test set:")
  message(sprintf("  correlation = %.3f", metrics$correlation))
  message(sprintf("  R^2         = %.3f", metrics$r_squared))
  message(sprintf("  RMSE        = %.3f", metrics$rmse))

  saveRDS(model, file.path("reports/output", "ei_regression_model.rds"))
  invisible(list(model = model, metrics = metrics))
}

if (sys.nframe() == 0) {
  main()
}
