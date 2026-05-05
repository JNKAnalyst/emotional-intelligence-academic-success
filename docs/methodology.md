# Methodology

## Research question

Does self-reported emotional intelligence (EI), combined with linguistic
features extracted from open-ended student reflections, predict academic
performance (GPA)?

## Constructs and measures

| Construct | Operationalization |
|---|---|
| Empathy | Likert composite (1–5) from a short EI questionnaire |
| Self-awareness | Likert composite (1–5) |
| Social skills | Likert composite (1–5) |
| Sentiment | `syuzhet` compound sentiment of free-text reflection |
| Emotional vocabulary | Count of tokens matching a curated emotion lexicon |
| Academic performance | Self-reported cumulative GPA (4.0 scale) |

## Pipeline

1. **Data cleaning** (`analysis/01_data_cleaning.R`) — schema validation,
   coercion of numeric columns, removal of rows missing GPA or open response,
   deduplication on `student_id`.
2. **NLP feature extraction** (`analysis/02_nlp_processing.R`) — sentiment
   scoring via the `syuzhet` package (configurable to `bing` or `afinn`),
   emotional vocabulary counts, response length.
3. **Regression modeling** (`analysis/03_regression_analysis.R`) — multiple
   linear regression with k-fold cross-validation via `caret`. Train/test
   split is 80/20 with a fixed seed.
4. **Visualization** (`analysis/04_visualization.R`) — scatter of EI vs GPA,
   sentiment distribution, and correlation heatmap.

## Statistical approach

- Primary model: ordinary least squares regression
  `gpa_score ~ empathy_score + self_awareness + social_skills +
   sentiment_compound + emotional_vocab_count`.
- Validation: 5-fold cross-validation (R^2, RMSE) plus a held-out 20% test set.
- Reported effect: Pearson correlation between predicted and observed GPA on
  the held-out set.

## Limitations

- Self-report bias for both EI and GPA.
- Lexicon-based sentiment is coarse and English-only.
- Sample dataset shipped in this repo is synthetic and intended only for
  pipeline demonstration; effect sizes there are not meaningful.

## Ethics

Real student survey data is not redistributed in this repository. If you run
this pipeline on real responses, anonymize identifiers, obtain appropriate
consent, and store raw data outside version control.
