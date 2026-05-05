# 04_visualization.R
# Produce diagnostic and result plots: EI vs GPA scatter, correlation
# heatmap, sentiment distribution, and residual diagnostics.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
  library(corrplot)
})

source("config/config.R")

OUT_DIR <- "reports/output"
dir.create(OUT_DIR, showWarnings = FALSE, recursive = TRUE)

save_plot <- function(plot, filename, width = 7, height = 5) {
  path <- file.path(OUT_DIR, filename)
  ggsave(path, plot, width = width, height = height, dpi = 200)
  message("Saved: ", path)
}

plot_ei_vs_gpa <- function(df) {
  ggplot(df, aes(x = empathy_score, y = gpa_score)) +
    geom_point(alpha = 0.6) +
    geom_smooth(method = "lm", se = TRUE) +
    labs(
      title = "Empathy Score vs GPA",
      x = "Empathy Score",
      y = "GPA"
    ) +
    theme_minimal()
}

plot_sentiment_distribution <- function(df) {
  ggplot(df, aes(x = sentiment_compound)) +
    geom_histogram(bins = 30, fill = "steelblue", colour = "white") +
    labs(
      title = "Distribution of Compound Sentiment Scores",
      x = "Compound sentiment",
      y = "Count"
    ) +
    theme_minimal()
}

plot_correlation_matrix <- function(df) {
  vars <- c(EI_PREDICTORS, TARGET_VAR)
  m <- cor(df[, vars], use = "complete.obs")
  path <- file.path(OUT_DIR, "correlation_matrix.png")
  png(path, width = 800, height = 800, res = 150)
  corrplot(m, method = "color", addCoef.col = "black",
           tl.col = "black", tl.cex = 0.8, number.cex = 0.7)
  dev.off()
  message("Saved: ", path)
}

main <- function() {
  features <- read_csv("data/features.csv", show_col_types = FALSE)
  save_plot(plot_ei_vs_gpa(features), "ei_vs_gpa.png")
  save_plot(plot_sentiment_distribution(features), "sentiment_distribution.png")
  plot_correlation_matrix(features)
  invisible(NULL)
}

if (sys.nframe() == 0) {
  main()
}
