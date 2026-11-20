# ============================================================
# IT3081 STATISTICAL MODELLING GROUP ASSIGNMENT
# SUPERMARKET SALES ANALYSIS
# ============================================================

# ============================================================
# TASK 1 – UNDERSTANDING THE INDUSTRY PROBLEM
# ============================================================
# Report discussion task – no R analysis is required in this section.
# Introduce the selected retail/supermarket industry and the business problem.
# The report should explain the industry background and organizational context.
# Clearly describe the business problem and why solving it is important.
# Identify the main stakeholders affected by the problem.
# Explain the business decisions that could be influenced by the analysis.
# Finish the section by stating the consultancy objectives.

# ============================================================
# TASK 2 – RESEARCH LANDSCAPE
# ============================================================
# Literature-review task – no R analysis is required in this section.
# Critically review how researchers and organizations address the selected problem.
# Compare current industry practices, statistical approaches, and recent findings.
# Discuss strengths and weaknesses of previous studies instead of only summarizing them.
# Identify research gaps and justify the analytical approach used in this consultancy.
# Minimum literature requirements: 15 peer-reviewed papers, including at least
# 10 journal papers and at least 5 papers published within the last five years.

# ============================================================
# TASK 3 – DATASET UNDERSTANDING AND DESCRIPTIVE ANALYSIS
# ============================================================
# Understand the supermarket datasets, variables, structure, and overall data quality.
# Assess missing values, duplicates, unusual observations, and potential outliers.
# Calculate descriptive statistics and create appropriate visualizations.
# Interpret important patterns from an organizational and business perspective.
# Use the findings in this section to guide the later statistical analyses and models.
# This task explores the datasets, prepares variables, and summarizes important sales patterns.

#Import the five datasets
sales <- read.csv("data/train.csv")#Main sales dataset

stores <- read.csv("data/stores.csv")#Information about each store

transactions <- read.csv("data/transactions.csv")#Number of transactions at each store/day

holidays <- read.csv("data/holidays_events.csv")#Holidays and special events

oil <- read.csv("data/oil.csv")#Daily oil price

# Check the dimensions of each dataset
#number of rows × number of columns
# Check the dimensions to understand the number of rows and columns.
dim(sales)
dim(stores)
dim(transactions)
# Check the dimensions to understand the number of rows and columns.
dim(holidays)
dim(oil)

# Check column names
# Check the available variable/column names.
names(sales)
names(stores)
names(transactions)
# Check the available variable/column names.
names(holidays)
names(oil)

#Check the structure
 str(sales)
# Inspect the data structure and variable data types.
str(stores)
str(transactions)
str(holidays)
# Inspect the data structure and variable data types.
str(oil)

#Get the summary
# Display summary statistics/results for interpretation.
summary(sales)
summary(stores)
summary(transactions)
# Display summary statistics/results for interpretation.
summary(holidays)
summary(oil)

#check missing values
# Count missing values in each variable.
colSums(is.na(sales))
colSums(is.na(stores))
colSums(is.na(transactions))
# Count missing values in each variable.
colSums(is.na(holidays))
colSums(is.na(oil))

head(stores)
head(sales)

View(stores)
View(sales)

# ============================================================
# DATA PREPARATION
# ============================================================

# Convert date variables from character to Date

# Convert the sales date from text to a proper Date object for time-based analysis.
sales$date <- as.Date(sales$date)

transactions$date <- as.Date(transactions$date)

holidays$date <- as.Date(holidays$date)

oil$date <- as.Date(oil$date)

class(sales$date)
class(transactions$date)
class(holidays$date)
class(oil$date)

# Convert categorical variables to factors

sales$family <- as.factor(sales$family)

stores$city <- as.factor(stores$city)
stores$state <- as.factor(stores$state)
stores$type <- as.factor(stores$type)

holidays$type <- as.factor(holidays$type)
holidays$locale <- as.factor(holidays$locale)
holidays$transferred <- as.factor(holidays$transferred)

stores$cluster <- as.factor(stores$cluster)

# Inspect the data structure and variable data types.
str(sales)
str(stores)
str(transactions)
# Inspect the data structure and variable data types.
str(holidays)
str(oil)

#Check Duplicate
# Check for duplicate observations that could affect the analysis.
sum(duplicated(sales))
sum(duplicated(stores))
sum(duplicated(transactions))
# Check for duplicate observations that could affect the analysis.
sum(duplicated(holidays))
sum(duplicated(oil))

# sales should have one observation for each:
# date + store + product family
# Check for duplicate observations that could affect the analysis.
sum(duplicated(sales[c("date", "store_nbr", "family")]))

# stores should have one row per store
# Check for duplicate observations that could affect the analysis.
sum(duplicated(stores["store_nbr"]))

# transactions should have one row per date/store
# Check for duplicate observations that could affect the analysis.
sum(duplicated(transactions[c("date", "store_nbr")]))

# oil should have one row per date
# Check for duplicate observations that could affect the analysis.
sum(duplicated(oil["date"]))

# Check the observed range of dates in the dataset.
range(sales$date)
range(transactions$date)
range(holidays$date)
# Check the observed range of dates in the dataset.
range(oil$date)

# ============================================================
# DESCRIPTIVE STATISTICS
# ============================================================

# Sales descriptive statistics

# Calculate the mean as a measure of central tendency.
mean(sales$sales)
# Calculate the median, which is less sensitive to extreme values.
median(sales$sales)
# Calculate the standard deviation to measure variability.
sd(sales$sales)
min(sales$sales)
max(sales$sales)

# Calculate quartiles to understand the distribution and spread.
quantile(sales$sales)


# Promotion descriptive statistics

# Calculate the mean as a measure of central tendency.
mean(sales$onpromotion)
# Calculate the median, which is less sensitive to extreme values.
median(sales$onpromotion)
# Calculate the standard deviation to measure variability.
sd(sales$onpromotion)
min(sales$onpromotion)
max(sales$onpromotion)

# Calculate quartiles to understand the distribution and spread.
quantile(sales$onpromotion)

# Transaction descriptive statistics

# Calculate the mean as a measure of central tendency.
mean(transactions$transactions)
# Calculate the median, which is less sensitive to extreme values.
median(transactions$transactions)
# Calculate the standard deviation to measure variability.
sd(transactions$transactions)
min(transactions$transactions)
max(transactions$transactions)

# Calculate quartiles to understand the distribution and spread.
quantile(transactions$transactions)

#Sales Distribution
# Draw a histogram to examine the shape of the distribution.
hist(
  sales$sales,
  main = "Distribution of Supermarket Sales",
  xlab = "Sales",
  ylab = "Frequency",
  breaks = 50
)
#Make a log-transformed visualization
# Apply log(1 + sales) transformation to reduce right-skewness while retaining zero sales.
sales$log_sales <- log1p(sales$sales)
# Draw a histogram to examine the shape of the distribution.
hist(
  sales$log_sales,
  main = "Distribution of Log-Transformed Sales",
  xlab = "log(1 + Sales)",
  ylab = "Frequency",
  breaks = 50
)

#Boxplot for Sales
# Draw a boxplot to compare distributions and identify possible extreme values.
boxplot(
  sales$sales,
  main = "Boxplot of Supermarket Sales",
  ylab = "Sales"
)

# Draw a boxplot to compare distributions and identify possible extreme values.
boxplot(
  sales$log_sales,
  main = "Boxplot of Log-Transformed Sales",
  ylab = "log(1 + Sales)"
)

#How Many Zero-Sales Observations
sum(sales$sales == 0)
sum(sales$sales == 0) / nrow(sales) * 100

sum(sales$onpromotion == 0)
sum(sales$onpromotion == 0) / nrow(sales) * 100


#Understand the Product Families
levels(sales$family)
table(sales$family)

family_sales <- aggregate(
  sales ~ family,
  data = sales,
  FUN = mean
)

family_sales

family_sales <- family_sales[
  order(family_sales$sales, decreasing = TRUE),
]

family_sales

#Store Type Analysis Preparation
sales_store <- merge(
  sales,
  stores,
  by = "store_nbr",
  all.x = TRUE
)
# Check the dimensions to understand the number of rows and columns.
dim(sales_store)

# Check the available variable/column names.
names(sales_store)

sum(is.na(sales_store$type))

#calculate sales by store type
sales_by_type <- aggregate(
  sales ~ type,
  data = sales_store,
  FUN = mean
)

sales_by_type

# Draw a boxplot to compare distributions and identify possible extreme values.
boxplot(
  log_sales ~ type,
  data = sales_store,
  main = "Sales Distribution by Store Type",
  xlab = "Store Type",
  ylab = "log(1 + Sales)"
)


# Calculate the mean as a measure of central tendency.
mean(sales$sales)
# Calculate the median, which is less sensitive to extreme values.
median(sales$sales)
# Calculate the standard deviation to measure variability.
sd(sales$sales)

sum(sales$sales == 0) / nrow(sales) * 100
sum(sales$onpromotion == 0) / nrow(sales) * 100

family_sales

# Check the dimensions to understand the number of rows and columns.
dim(sales_store)
sum(is.na(sales_store$type))

sales_by_type

# Create promotion status
# Create a promotion category based on whether at least one item is on promotion.
sales$promotion_status <- ifelse(
  sales$onpromotion > 0,
  "Promotion",
  "No Promotion"
)

sales$promotion_status <- as.factor(sales$promotion_status)

table(sales$promotion_status)

promotion_sales <- aggregate(
  sales ~ promotion_status,
  data = sales,
  FUN = mean
)

promotion_sales

promotion_median <- aggregate(
  sales ~ promotion_status,
  data = sales,
  FUN = median
)

promotion_median

# Draw a boxplot to compare distributions and identify possible extreme values.
boxplot(
  log1p(sales$sales) ~ sales$promotion_status,
  main = "Sales Distribution by Promotion Status",
  xlab = "Promotion Status",
  ylab = "log(1 + Sales)"
)

# Calculate correlation to measure the strength and direction of association.
cor(
  sales$sales,
  sales$onpromotion,
  method = "pearson"
)

# Calculate correlation to measure the strength and direction of association.
cor(
  sales$sales,
  sales$onpromotion,
  method = "spearman"
)

# ============================================================
# STORE-DAY SALES FOR TRANSACTION ANALYSIS
# ============================================================

# Aggregate product-family sales to store-day level so they match the transaction dataset grain.
daily_store_sales <- aggregate(
  sales ~ date + store_nbr,
  data = sales,
  FUN = sum
)

head(daily_store_sales)
# Check the dimensions to understand the number of rows and columns.
dim(daily_store_sales)

sales_transactions <- merge(
  daily_store_sales,
  transactions,
  by = c("date", "store_nbr")
)

# Check the dimensions to understand the number of rows and columns.
dim(sales_transactions)

head(sales_transactions)

sum(is.na(sales_transactions))

# Calculate correlation to measure the strength and direction of association.
cor(
  sales_transactions$sales,
  sales_transactions$transactions,
  method = "pearson"
)

# Calculate correlation to measure the strength and direction of association.
cor(
  sales_transactions$sales,
  sales_transactions$transactions,
  method = "spearman"
)

plot(
  sales_transactions$transactions,
  sales_transactions$sales,
  main = "Relationship Between Transactions and Daily Store Sales",
  xlab = "Number of Transactions",
  ylab = "Daily Store Sales",
  pch = 16,
  cex = 0.3
)

abline(
  lm(sales ~ transactions, data = sales_transactions),
  lwd = 2
)


#sales over time
# Aggregate all observations to obtain total supermarket sales for each date.
daily_sales <- aggregate(
  sales ~ date,
  data = sales,
  FUN = sum
)

head(daily_sales)
# Check the dimensions to understand the number of rows and columns.
dim(daily_sales)

plot(
  daily_sales$date,
  daily_sales$sales,
  type = "l",
  main = "Total Supermarket Sales Over Time",
  xlab = "Date",
  ylab = "Total Daily Sales"
)
sales$year_month <- format(sales$date, "%Y-%m")

# Aggregate sales into monthly totals to study the long-term sales trend.
monthly_sales <- aggregate(
  sales ~ year_month,
  data = sales,
  FUN = sum
)

head(monthly_sales)

plot(
  seq_len(nrow(monthly_sales)),
  monthly_sales$sales,
  type = "l",
  main = "Monthly Supermarket Sales Trend",
  xlab = "Month",
  ylab = "Total Monthly Sales",
  xaxt = "n"
)

axis(
  1,
  at = seq(1, nrow(monthly_sales), by = 6),
  labels = monthly_sales$year_month[
    seq(1, nrow(monthly_sales), by = 6)
  ],
  las = 2
)

#the missing oil values

oil[is.na(oil$dcoilwtico), ]
sum(is.na(oil$dcoilwtico))
# Calculate the mean as a measure of central tendency.
mean(is.na(oil$dcoilwtico)) * 100

# Check the dimensions to understand the number of rows and columns.
dim(daily_sales)
head(daily_sales)

head(monthly_sales)
tail(monthly_sales)

# Calculate the mean as a measure of central tendency.
mean(is.na(oil$dcoilwtico)) * 100

#Store type
barplot(
  sales_by_type$sales,
  names.arg = sales_by_type$type,
  main = "Average Sales by Store Type",
  xlab = "Store Type",
  ylab = "Average Sales"
)

#Promotion
barplot(
  promotion_sales$sales,
  names.arg = promotion_sales$promotion_status,
  main = "Average Sales by Promotion Status",
  xlab = "Promotion Status",
  ylab = "Average Sales"
)

#Product families
barplot(
  family_sales$sales,
  names.arg = family_sales$family,
  horiz = TRUE,
  las = 1,
  main = "Average Sales by Product Family",
  xlab = "Average Sales",
  cex.names = 0.6
)

#Transactions vs sales
plot(
  sales_transactions$transactions,
  sales_transactions$sales,
  main = "Transactions vs Daily Store Sales",
  xlab = "Number of Transactions",
  ylab = "Daily Store Sales",
  pch = 16,
  cex = 0.3
)

abline(
  lm(sales ~ transactions, data = sales_transactions),
  lwd = 2
)

#Monthly sales
monthly_sales_complete <- monthly_sales[
  monthly_sales$year_month != "2017-08",
]

plot(
  seq_len(nrow(monthly_sales_complete)),
  monthly_sales_complete$sales,
  type = "l",
  main = "Monthly Supermarket Sales Trend",
  xlab = "Month",
  ylab = "Total Monthly Sales",
  xaxt = "n"
)

axis(
  1,
  at = seq(1, nrow(monthly_sales_complete), by = 6),
  labels = monthly_sales_complete$year_month[
    seq(1, nrow(monthly_sales_complete), by = 6)
  ],
  las = 2
)

# ============================================================
# TASK 4 – STATISTICAL INFERENCE
# ============================================================
# Apply suitable inferential statistical tests to answer the research questions.
# For each analysis, define the null and alternative hypotheses in the written report.
# Justify why the selected test is appropriate and check relevant assumptions.
# Report and interpret the statistical results rather than presenting output alone.
# Explain the practical implications of significant or non-significant findings
# for supermarket and organizational decision-making.
# This task uses statistical inference to test the research questions and assess significant relationships.
#RQ1: Store Type and Sales

# Fit an ANOVA model to test for differences between group means.
aov(sales ~ type, data = sales_store)

#Create the store-level dataset
# Calculate one mean-sales value per store for the store-type comparison.
store_mean_sales <- aggregate(
  sales ~ store_nbr,
  data = sales,
  FUN = mean
)

head(store_mean_sales)
# Check the dimensions to understand the number of rows and columns.
dim(store_mean_sales)

#the store information
store_anova <- merge(
  store_mean_sales,
  stores,
  by = "store_nbr"
)

# Check the dimensions to understand the number of rows and columns.
dim(store_anova)
head(store_anova)

table(store_anova$type)

aggregate(
  sales ~ type,
  data = store_anova,
  FUN = mean
)

#First visualization for ANOVA
# Draw a boxplot to compare distributions and identify possible extreme values.
boxplot(
  sales ~ type,
  data = store_anova,
  main = "Store-Level Mean Sales by Store Type",
  xlab = "Store Type",
  ylab = "Mean Sales per Store"
)

# Check the dimensions to understand the number of rows and columns.
dim(store_anova)

table(store_anova$type)

aggregate(
  sales ~ type,
  data = store_anova,
  FUN = mean
)

aggregate(
  sales ~ type,
  data = store_anova,
  FUN = sd
)

#Fit the ANOVA model
anova_model <- aov(
  sales ~ type,
  data = store_anova
)


#Check normality visually
par(mfrow = c(1, 2))

# Draw a histogram to examine the shape of the distribution.
hist(
  residuals(anova_model),
  main = "Histogram of ANOVA Residuals",
  xlab = "Residuals"
)

qqnorm(
  residuals(anova_model),
  main = "Normal Q-Q Plot"
)

qqline(residuals(anova_model))

par(mfrow = c(1, 1))

#Shapiro-Wilk test
# Use the Shapiro-Wilk test to assess the normality assumption.
shapiro.test(residuals(anova_model))

#Check equal variances
#Bartlett's test
# Use Bartlett’s test to assess the equal-variance assumption.
bartlett.test(
  sales ~ type,
  data = store_anova
)

# Run Welch’s ANOVA, which does not assume equal group variances.
oneway.test(
  sales ~ type,
  data = store_anova,
  var.equal = FALSE
)

anova_model <- aov(
  sales ~ type,
  data = store_anova
)

# Use the Shapiro-Wilk test to assess the normality assumption.
shapiro.test(residuals(anova_model))

# Use Bartlett’s test to assess the equal-variance assumption.
bartlett.test(
  sales ~ type,
  data = store_anova
)

#Welch's One-Way ANOVA
welch_anova <- oneway.test(
  sales ~ type,
  data = store_anova,
  var.equal = FALSE
)

welch_anova

#the Kruskal-Wallis test
kruskal_result <- kruskal.test(
  sales ~ type,
  data = store_anova
)

kruskal_result

#post-hoc comparisons
pairwise_result <- pairwise.t.test(
  store_anova$sales,
  store_anova$type,
  p.adjust.method = "holm",
  pool.sd = FALSE
)

pairwise_result

#calculate effect size
grand_mean <- mean(store_anova$sales)

ss_between <- sum(
  tapply(
    store_anova$sales,
    store_anova$type,
    function(x) length(x) * (mean(x) - grand_mean)^2
  )
)

ss_total <- sum(
  (store_anova$sales - grand_mean)^2
)

# Calculate eta-squared to measure the magnitude of the store-type effect.
eta_squared <- ss_between / ss_total

eta_squared


#Promotional Activity and Sales Performance
#Formal correlation tests
pearson_test <- cor.test(
  sales$sales,
  sales$onpromotion,
  method = "pearson"
)

pearson_test

spearman_test <- cor.test(
  sales$sales,
  sales$onpromotion,
  method = "spearman",
  exact = FALSE
)

spearman_test

#Simple regression
promotion_model <- lm(
  sales ~ onpromotion,
  data = sales
)

#Get model fit
# Display summary statistics/results for interpretation.
summary(promotion_model)

#RQ3:sales differ across product families
# Calculate mean sales for each store and product family for product-family comparisons.
family_store_sales <- aggregate(
  sales ~ store_nbr + family,
  data = sales,
  FUN = mean
)

# Check the dimensions to understand the number of rows and columns.
dim(family_store_sales)

head(family_store_sales)

table(family_store_sales$family)

#Descriptive statistics at this level
family_means <- aggregate(
  sales ~ family,
  data = family_store_sales,
  FUN = mean
)

family_means <- family_means[
  order(family_means$sales, decreasing = TRUE),
]

family_means

family_sd <- aggregate(
  sales ~ family,
  data = family_store_sales,
  FUN = sd
)

family_sd <- family_sd[
  order(family_sd$sales, decreasing = TRUE),
]

family_sd

#Create the preliminary ANOVA model
family_anova_model <- aov(
  sales ~ family,
  data = family_store_sales
)

# Use the Shapiro-Wilk test to assess the normality assumption.
shapiro.test(
  residuals(family_anova_model)
)

qqnorm(
  residuals(family_anova_model),
  main = "Q-Q Plot of Product-Family ANOVA Residuals"
)

qqline(
  residuals(family_anova_model)
)

#Equal variance assumption
# Use Bartlett’s test to assess the equal-variance assumption.
bartlett.test(
  sales ~ family,
  data = family_store_sales
)
family_store_sales <- aggregate(
  sales ~ store_nbr + family,
  data = sales,
  FUN = mean
)

# Check the dimensions to understand the number of rows and columns.
dim(family_store_sales)

table(family_store_sales$family)

family_anova_model <- aov(
  sales ~ family,
  data = family_store_sales
)

# Use the Shapiro-Wilk test to assess the normality assumption.
shapiro.test(
  residuals(family_anova_model)
)

# Use Bartlett’s test to assess the equal-variance assumption.
bartlett.test(
  sales ~ family,
  data = family_store_sales
)

#Run Welch ANOVA
family_welch <- oneway.test(
  sales ~ family,
  data = family_store_sales,
  var.equal = FALSE
)

family_welch

#Kruskal-Wallis sensitivity check
family_kw <- kruskal.test(
  sales ~ family,
  data = family_store_sales
)

family_kw

#Get the descriptive means
family_summary <- aggregate(
  sales ~ family,
  data = family_store_sales,
  FUN = function(x) c(
    mean = mean(x),
    sd = sd(x),
    median = median(x)
  )
)

family_summary

family_mean <- aggregate(
  sales ~ family,
  data = family_store_sales,
  FUN = mean
)

family_sd <- aggregate(
  sales ~ family,
  data = family_store_sales,
  FUN = sd
)

family_median <- aggregate(
  sales ~ family,
  data = family_store_sales,
  FUN = median
)

# Check the available variable/column names.
names(family_mean)[2] <- "mean_sales"
names(family_sd)[2] <- "sd_sales"
names(family_median)[2] <- "median_sales"

family_stats <- merge(
  family_mean,
  family_sd,
  by = "family"
)

family_stats <- merge(
  family_stats,
  family_median,
  by = "family"
)

family_stats <- family_stats[
  order(family_stats$mean_sales, decreasing = TRUE),
]

family_stats

#calculate effect magnitude
grand_mean_family <- mean(family_store_sales$sales)

ss_between_family <- sum(
  tapply(
    family_store_sales$sales,
    family_store_sales$family,
    function(x) length(x) *
      (mean(x) - grand_mean_family)^2
  )
)

ss_total_family <- sum(
  (family_store_sales$sales - grand_mean_family)^2
)

# Calculate eta-squared to measure the magnitude of product-family differences.
eta_squared_family <-
  ss_between_family / ss_total_family

eta_squared_family

#post-hoc analysis
family_pairwise <- pairwise.t.test(
  family_store_sales$sales,
  family_store_sales$family,
  p.adjust.method = "holm",
  pool.sd = FALSE
)

family_pairwise

p_matrix <- family_pairwise$p.value

pairwise_results <- data.frame()

for (i in 1:nrow(p_matrix)) {
  for (j in 1:ncol(p_matrix)) {
    
    if (!is.na(p_matrix[i, j])) {
      
      pairwise_results <- rbind(
        pairwise_results,
        data.frame(
          family1 = rownames(p_matrix)[i],
          family2 = colnames(p_matrix)[j],
          adjusted_p = p_matrix[i, j]
        )
      )
      
    }
  }
}

significant_pairs <- pairwise_results[
  pairwise_results$adjusted_p < 0.05,
]

nrow(pairwise_results)
nrow(significant_pairs)

head(
  significant_pairs[
    order(significant_pairs$adjusted_p),
  ],
  20
)
eta_squared_family
nrow(pairwise_results)
nrow(significant_pairs)

head(
  significant_pairs[
    order(significant_pairs$adjusted_p),
  ],
  20
)

#RQ4 — Transactions and Sales
#Formal Pearson correlation test
transaction_pearson <- cor.test(
  sales_transactions$sales,
  sales_transactions$transactions,
  method = "pearson"
)

transaction_pearson

#Spearman correlation
transaction_spearman <- cor.test(
  sales_transactions$sales,
  sales_transactions$transactions,
  method = "spearman",
  exact = FALSE
)

transaction_spearman

#Simple linear regression
transaction_model <- lm(
  sales ~ transactions,
  data = sales_transactions
)

# Display summary statistics/results for interpretation.
summary(transaction_model)

#Check regression residuals visually
par(mfrow = c(1, 2))

plot(
  transaction_model$fitted.values,
  residuals(transaction_model),
  xlab = "Fitted Values",
  ylab = "Residuals",
  main = "Residuals vs Fitted"
)

abline(h = 0, lty = 2)

qqnorm(
  residuals(transaction_model),
  main = "Normal Q-Q Plot"
)

qqline(residuals(transaction_model))

par(mfrow = c(1, 1))


# ============================================================
# TASK 5 – PREDICTIVE STATISTICAL MODELLING
# ============================================================
# Develop and compare predictive statistical models for supermarket sales.
# Justify the choice of each model and evaluate model assumptions and performance.
# Compare alternative approaches such as Multiple Linear Regression, Ridge, LASSO,
# Elastic Net, and stepwise variable-selection methods where appropriate.
# Discuss strengths and limitations and recommend a suitable model in the report.
# Model quality should be judged using both statistical performance and business usefulness.
# This task builds and evaluates predictive models for supermarket sales.
#Create the modelling dataset
model_data <- sales
model_data <- merge(
  model_data,
  stores,
  by = "store_nbr",
  all.x = TRUE
)

# Check the dimensions to understand the number of rows and columns.
dim(model_data)

# Check the available variable/column names.
names(model_data)

head(model_data)

#Check missing transactions
sum(is.na(model_data$transactions))

# Calculate the mean as a measure of central tendency.
mean(is.na(model_data$transactions)) * 100

#Create temporal predictors
# Extract year from the date as a temporal predictor.
model_data$year <- as.integer(
  format(model_data$date, "%Y")
)

# Extract month as a categorical predictor to capture monthly seasonal effects.
model_data$month <- as.factor(
  format(model_data$date, "%m")
)

# Extract weekday as a categorical predictor to capture day-of-week effects.
model_data$weekday <- as.factor(
  weekdays(model_data$date)
)

table(model_data$year)

table(model_data$month)

table(model_data$weekday)

#categorical predictors are factors
model_data$family <- as.factor(model_data$family)
model_data$type <- as.factor(model_data$type)
model_data$cluster <- as.factor(model_data$cluster)
model_data$store_nbr <- as.factor(model_data$store_nbr)
model_data$month <- as.factor(model_data$month)
model_data$weekday <- as.factor(model_data$weekday)

model_data$year <- as.integer(
  format(model_data$date, "%Y")
)

model_data$month <- as.factor(
  format(model_data$date, "%m")
)

model_data$weekday <- as.factor(
  weekdays(model_data$date)
)
#Create the first modelling dataset
# Check the available variable/column names.
names(model_data)
required_cols <- c(
  "sales",
  "transactions",
  "onpromotion",
  "family",
  "type",
  "cluster",
  "year",
  "month",
  "weekday"
)

setdiff(required_cols, names(model_data))

model_data$date <- as.Date(model_data$date)

model_data$year <- as.integer(
  format(model_data$date, "%Y")
)

model_data$month <- as.factor(
  format(model_data$date, "%m")
)

model_data$weekday <- as.factor(
  weekdays(model_data$date)
)
setdiff(required_cols, names(model_data))

# Check the available variable/column names.
names(transactions)
# Check the dimensions to understand the number of rows and columns.
dim(transactions)
head(transactions)
class(model_data$date)
class(transactions$date)
model_data <- merge(
  model_data,
  transactions,
  by = c("date", "store_nbr"),
  all.x = TRUE
)
"transactions" %in% names(model_data)

# Check the available variable/column names.
names(model_data)

sum(is.na(model_data$transactions))

# Calculate the mean as a measure of central tendency.
mean(is.na(model_data$transactions)) * 100

setdiff(required_cols, names(model_data))
ml_data <- model_data[, required_cols]

# Check the dimensions to understand the number of rows and columns.
dim(ml_data)
head(ml_data)

# Keep complete observations required for modelling.
ml_data_complete <- na.omit(ml_data)

# Check the dimensions to understand the number of rows and columns.
dim(ml_data)
dim(ml_data_complete)

sum(is.na(ml_data_complete))

# Check the dimensions to understand the number of rows and columns.
dim(ml_data)
dim(ml_data_complete)

sum(is.na(model_data$transactions))
# Calculate the mean as a measure of central tendency.
mean(is.na(model_data$transactions)) * 100

# Display summary statistics/results for interpretation.
summary(ml_data_complete$sales)

ml_data_complete$log_sales <- log1p(
  ml_data_complete$sales
)
# Display summary statistics/results for interpretation.
summary(ml_data_complete$log_sales)

# Draw a histogram to examine the shape of the distribution.
hist(
  ml_data_complete$log_sales,
  breaks = 50,
  main = "Distribution of Log(1 + Sales)",
  xlab = "log(1 + Sales)"
)

#Split training and testing data
# Set a random seed so sampling and modelling results are reproducible.
set.seed(123)

n <- nrow(ml_data_complete)

train_index <- sample(
  seq_len(n),
  size = floor(0.80 * n)
)

train_data <- ml_data_complete[
  train_index,
]

test_data <- ml_data_complete[
  -train_index,
]

# Check the dimensions to understand the number of rows and columns.
dim(train_data)
dim(test_data)

#Fit the first Multiple Linear Regression
mlr_model <- lm(
  log_sales ~
    transactions +
    onpromotion +
    family +
    type +
    cluster +
    year +
    month +
    weekday,
  data = train_data
)
# Display summary statistics/results for interpretation.
summary(mlr_model)

summary(mlr_model)$r.squared
# Display summary statistics/results for interpretation.
summary(mlr_model)$adj.r.squared

ml_data_complete$log_sales <- log1p(
  ml_data_complete$sales
)

# Display summary statistics/results for interpretation.
summary(ml_data_complete$log_sales)

set.seed(123)

n <- nrow(ml_data_complete)

train_index <- sample(
  seq_len(n),
  size = floor(0.80 * n)
)

train_data <- ml_data_complete[train_index,]
test_data <- ml_data_complete[-train_index,]

# Check the dimensions to understand the number of rows and columns.
dim(train_data)
dim(test_data)

mlr_model <- lm(
  log_sales ~
    transactions +
    onpromotion +
    family +
    type +
    cluster +
    year +
    month +
    weekday,
  data = train_data
)

# Display summary statistics/results for interpretation.
summary(mlr_model)$r.squared
summary(mlr_model)$adj.r.squared

#Predict the test set
pred_log <- predict(
  mlr_model,
  newdata = test_data
)
rmse_log <- sqrt(
  mean(
    (test_data$log_sales - pred_log)^2
  )
)

rmse_log

mae_log <- mean(
  abs(
    test_data$log_sales - pred_log
  )
)

mae_log

ss_res <- sum(
  (test_data$log_sales - pred_log)^2
)

ss_tot <- sum(
  (test_data$log_sales -
     mean(test_data$log_sales))^2
)

test_r2 <- 1 - (ss_res / ss_tot)

test_r2

# Transform predicted log-sales back to the original sales scale.
pred_sales <- expm1(pred_log)
pred_sales <- pmax(
  0,
  expm1(pred_log)
)

rmse_sales <- sqrt(
  mean(
    (test_data$sales - pred_sales)^2
  )
)

mae_sales <- mean(
  abs(
    test_data$sales - pred_sales
  )
)

rmse_sales
mae_sales

mlr_performance <- data.frame(
  Model = "Multiple Linear Regression",
  Train_R2 = summary(mlr_model)$r.squared,
  Test_R2 = test_r2,
  RMSE_Log = rmse_log,
  MAE_Log = mae_log,
  RMSE_Sales = rmse_sales,
  MAE_Sales = mae_sales
)

mlr_performance

rmse_log
mae_log
test_r2
rmse_sales
mae_sales
mlr_performance

# 1. Predict log-sales on the test set
pred_log <- predict(
  mlr_model,
  newdata = test_data
)

# 2. RMSE on log scale
rmse_log <- sqrt(
  mean((test_data$log_sales - pred_log)^2)
)

# 3. MAE on log scale
mae_log <- mean(
  abs(test_data$log_sales - pred_log)
)

# 4. Test R-squared
ss_res <- sum(
  (test_data$log_sales - pred_log)^2
)

ss_tot <- sum(
  (test_data$log_sales -
     mean(test_data$log_sales))^2
)

test_r2 <- 1 - (ss_res / ss_tot)

# 5. Convert predictions back to sales scale
pred_sales <- pmax(
  0,
  expm1(pred_log)
)

# 6. RMSE on original sales scale
rmse_sales <- sqrt(
  mean((test_data$sales - pred_sales)^2)
)

# 7. MAE on original sales scale
mae_sales <- mean(
  abs(test_data$sales - pred_sales)
)

# 8. Create model performance table
mlr_performance <- data.frame(
  Model = "Multiple Linear Regression",
  Train_R2 = summary(mlr_model)$r.squared,
  Test_R2 = test_r2,
  RMSE_Log = rmse_log,
  MAE_Log = mae_log,
  RMSE_Sales = rmse_sales,
  MAE_Sales = mae_sales
)

mlr_performance

# Extract residuals
mlr_residuals <- residuals(mlr_model)

# 1. Residuals vs fitted
plot(
  fitted(mlr_model),
  mlr_residuals,
  pch = ".",
  xlab = "Fitted log(1 + sales)",
  ylab = "Residuals",
  main = "Residuals vs Fitted"
)

abline(h = 0, lty = 2)

set.seed(123)

res_sample <- sample(
  mlr_residuals,
  5000
)

qqnorm(
  res_sample,
  main = "Q-Q Plot of MLR Residuals"
)

qqline(res_sample)

# Use the Shapiro-Wilk test to assess the normality assumption.
shapiro.test(res_sample)

# Display summary statistics/results for interpretation.
summary(mlr_model)

sum(is.na(coef(mlr_model)))

alias(mlr_model)




mlr_model2 <- lm(
  log_sales ~
    transactions +
    onpromotion +
    family +
    type +
    year +
    month +
    weekday,
  data = train_data
)

# Display summary statistics/results for interpretation.
summary(mlr_model2)

sum(is.na(coef(mlr_model2)))

# Display summary statistics/results for interpretation.
summary(mlr_model2)$r.squared
summary(mlr_model2)$adj.r.squared

pred_log2 <- predict(
  mlr_model2,
  newdata = test_data
)

rmse_log2 <- sqrt(
  mean((test_data$log_sales - pred_log2)^2)
)

mae_log2 <- mean(
  abs(test_data$log_sales - pred_log2)
)

ss_res2 <- sum(
  (test_data$log_sales - pred_log2)^2
)

ss_tot2 <- sum(
  (test_data$log_sales -
     mean(test_data$log_sales))^2
)

test_r2_2 <- 1 - ss_res2 / ss_tot2

pred_sales2 <- pmax(
  0,
  expm1(pred_log2)
)

rmse_sales2 <- sqrt(
  mean((test_data$sales - pred_sales2)^2)
)

mae_sales2 <- mean(
  abs(test_data$sales - pred_sales2)
)

mlr_comparison <- data.frame(
  Model = c(
    "MLR with Type + Cluster",
    "MLR without Cluster"
  ),
  
  Train_R2 = c(
    summary(mlr_model)$r.squared,
    summary(mlr_model2)$r.squared
  ),
  
  Test_R2 = c(
    test_r2,
    test_r2_2
  ),
  
  RMSE_Log = c(
    rmse_log,
    rmse_log2
  ),
  
  MAE_Log = c(
    mae_log,
    mae_log2
  ),
  
  RMSE_Sales = c(
    rmse_sales,
    rmse_sales2
  ),
  
  MAE_Sales = c(
    mae_sales,
    mae_sales2
  )
)

mlr_comparison


requireNamespace("glmnet", quietly = TRUE)
library(glmnet)


# Create the training design matrix, including dummy variables for categorical predictors.
x_train <- model.matrix(
  ~ transactions +
    onpromotion +
    family +
    type +
    year +
    month +
    weekday,
  data = train_data
)[, -1]

# Create the matching test design matrix for model evaluation.
x_test <- model.matrix(
  ~ transactions +
    onpromotion +
    family +
    type +
    year +
    month +
    weekday,
  data = test_data
)[, -1]

y_train <- train_data$log_sales
y_test <- test_data$log_sales


# Check the dimensions to understand the number of rows and columns.
dim(x_train)
dim(x_test)

length(y_train)
length(y_test)

ncol(x_train) == ncol(x_test)

set.seed(123)

cv_index <- sample(
  seq_len(nrow(x_train)),
  size = 200000
)

x_cv <- x_train[cv_index, ]
y_cv <- y_train[cv_index]

# Check the dimensions to understand the number of rows and columns.
dim(x_cv)
length(y_cv)

set.seed(123)

# Use 5-fold cross-validation to select the best lambda for Ridge Regression.
cv_ridge <- cv.glmnet(
  x = x_cv,
  y = y_cv,
  alpha = 0,
  family = "gaussian",
  nfolds = 5,
  standardize = TRUE
)

cv_ridge$lambda.min
cv_ridge$lambda.1se

best_lambda_ridge <- cv_ridge$lambda.min

best_lambda_ridge

plot(cv_ridge)

# Fit the final Ridge Regression model using the selected lambda.
ridge_model <- glmnet(
  x = x_train,
  y = y_train,
  alpha = 0,
  lambda = best_lambda_ridge,
  family = "gaussian",
  standardize = TRUE
)

ridge_pred_log <- as.numeric(
  predict(
    ridge_model,
    newx = x_test,
    s = best_lambda_ridge
  )
)

length(ridge_pred_log)

ridge_rmse_log <- sqrt(
  mean((y_test - ridge_pred_log)^2)
)

ridge_mae_log <- mean(
  abs(y_test - ridge_pred_log)
)

ridge_ss_res <- sum(
  (y_test - ridge_pred_log)^2
)

ridge_ss_tot <- sum(
  (y_test - mean(y_test))^2
)

ridge_test_r2 <- 1 -
  ridge_ss_res / ridge_ss_tot

ridge_pred_sales <- pmax(
  0,
  expm1(ridge_pred_log)
)

ridge_rmse_sales <- sqrt(
  mean(
    (test_data$sales - ridge_pred_sales)^2
  )
)

ridge_mae_sales <- mean(
  abs(
    test_data$sales - ridge_pred_sales
  )
)

model_comparison <- data.frame(
  Model = c(
    "Multiple Linear Regression",
    "Ridge Regression"
  ),
  
  Test_R2 = c(
    test_r2_2,
    ridge_test_r2
  ),
  
  RMSE_Log = c(
    rmse_log2,
    ridge_rmse_log
  ),
  
  MAE_Log = c(
    mae_log2,
    ridge_mae_log
  ),
  
  RMSE_Sales = c(
    rmse_sales2,
    ridge_rmse_sales
  ),
  
  MAE_Sales = c(
    mae_sales2,
    ridge_mae_sales
  )
)

model_comparison

cv_ridge$lambda.min
cv_ridge$lambda.1se

model_comparison

set.seed(123)

# Use 5-fold cross-validation to select the best lambda for LASSO Regression.
cv_lasso <- cv.glmnet(
  x = x_cv,
  y = y_cv,
  alpha = 1,
  family = "gaussian",
  nfolds = 5,
  standardize = TRUE
)

cv_lasso$lambda.min
cv_lasso$lambda.1se

plot(cv_lasso)

best_lambda_lasso <- cv_lasso$lambda.min

best_lambda_lasso

# Fit the final LASSO model; coefficients can shrink to zero for feature selection.
lasso_model <- glmnet(
  x = x_train,
  y = y_train,
  alpha = 1,
  lambda = best_lambda_lasso,
  family = "gaussian",
  standardize = TRUE
)

lasso_coef <- coef(
  lasso_model,
  s = best_lambda_lasso
)

lasso_coef

sum(lasso_coef != 0)


nonzero_predictors <- sum(lasso_coef[-1, ] != 0)

nonzero_predictors

selected_lasso <- rownames(lasso_coef)[
  as.vector(lasso_coef != 0)
]

selected_lasso

removed_lasso <- rownames(lasso_coef)[
  as.vector(lasso_coef == 0)
]

removed_lasso

lasso_pred_log <- as.numeric(
  predict(
    lasso_model,
    newx = x_test,
    s = best_lambda_lasso
  )
)

length(lasso_pred_log)

lasso_rmse_log <- sqrt(
  mean((y_test - lasso_pred_log)^2)
)

lasso_mae_log <- mean(
  abs(y_test - lasso_pred_log)
)

lasso_ss_res <- sum(
  (y_test - lasso_pred_log)^2
)

lasso_ss_tot <- sum(
  (y_test - mean(y_test))^2
)

lasso_test_r2 <- 1 -
  lasso_ss_res / lasso_ss_tot


lasso_pred_sales <- pmax(
  0,
  expm1(lasso_pred_log)
)

lasso_rmse_sales <- sqrt(
  mean(
    (test_data$sales - lasso_pred_sales)^2
  )
)

lasso_mae_sales <- mean(
  abs(
    test_data$sales - lasso_pred_sales
  )
)


model_comparison <- data.frame(
  Model = c(
    "Multiple Linear Regression",
    "Ridge Regression",
    "LASSO Regression"
  ),
  
  Test_R2 = c(
    test_r2_2,
    ridge_test_r2,
    lasso_test_r2
  ),
  
  RMSE_Log = c(
    rmse_log2,
    ridge_rmse_log,
    lasso_rmse_log
  ),
  
  MAE_Log = c(
    mae_log2,
    ridge_mae_log,
    lasso_mae_log
  ),
  
  RMSE_Sales = c(
    rmse_sales2,
    ridge_rmse_sales,
    lasso_rmse_sales
  ),
  
  MAE_Sales = c(
    mae_sales2,
    ridge_mae_sales,
    lasso_mae_sales
  )
)

model_comparison


set.seed(123)

# Use cross-validation to tune the Elastic Net regularization parameter.
cv_enet <- cv.glmnet(
  x = x_cv,
  y = y_cv,
  alpha = 0.5,
  family = "gaussian",
  nfolds = 5,
  standardize = TRUE
)

cv_enet$lambda.min
cv_enet$lambda.1se

plot(cv_enet)


best_lambda_enet <- cv_enet$lambda.min

best_lambda_enet

# Fit the Elastic Net model, combining Ridge and LASSO penalties.
enet_model <- glmnet(
  x = x_train,
  y = y_train,
  alpha = 0.5,
  lambda = best_lambda_enet,
  family = "gaussian",
  standardize = TRUE
)

enet_coef <- coef(
  enet_model,
  s = best_lambda_enet
)

nonzero_enet <- sum(
  enet_coef[-1, ] != 0
)

nonzero_enet


removed_enet <- rownames(enet_coef)[
  as.vector(enet_coef == 0)
]

removed_enet

enet_pred_log <- as.numeric(
  predict(
    enet_model,
    newx = x_test,
    s = best_lambda_enet
  )
)



enet_rmse_log <- sqrt(
  mean((y_test - enet_pred_log)^2)
)

enet_mae_log <- mean(
  abs(y_test - enet_pred_log)
)

enet_ss_res <- sum(
  (y_test - enet_pred_log)^2
)

enet_ss_tot <- sum(
  (y_test - mean(y_test))^2
)

enet_test_r2 <- 1 -
  enet_ss_res / enet_ss_tot



enet_pred_sales <- pmax(
  0,
  expm1(enet_pred_log)
)

enet_rmse_sales <- sqrt(
  mean(
    (test_data$sales - enet_pred_sales)^2
  )
)

enet_mae_sales <- mean(
  abs(
    test_data$sales - enet_pred_sales
  )
)


model_comparison <- data.frame(
  Model = c(
    "Multiple Linear Regression",
    "Ridge Regression",
    "LASSO Regression",
    "Elastic Net"
  ),
  
  Test_R2 = c(
    test_r2_2,
    ridge_test_r2,
    lasso_test_r2,
    enet_test_r2
  ),
  
  RMSE_Log = c(
    rmse_log2,
    ridge_rmse_log,
    lasso_rmse_log,
    enet_rmse_log
  ),
  
  MAE_Log = c(
    mae_log2,
    ridge_mae_log,
    lasso_mae_log,
    enet_mae_log
  ),
  
  RMSE_Sales = c(
    rmse_sales2,
    ridge_rmse_sales,
    lasso_rmse_sales,
    enet_rmse_sales
  ),
  
  MAE_Sales = c(
    mae_sales2,
    ridge_mae_sales,
    lasso_mae_sales,
    enet_mae_sales
  )
)

model_comparison


selection_data <- train_data[cv_index, ]
# Check the dimensions to understand the number of rows and columns.
dim(selection_data)

selection_full <- lm(
  log_sales ~ transactions +
    onpromotion +
    family +
    type +
    year +
    month +
    weekday,
  data = selection_data
)

# Apply backward stepwise selection to remove predictors that do not improve AIC.
backward_model <- step(
  selection_full,
  direction = "backward",
  trace = TRUE
)

formula(backward_model)

# Display summary statistics/results for interpretation.
summary(backward_model)

formula(backward_model)


forward_null <- lm(
  log_sales ~ 1,
  data = selection_data
)

full_formula <- formula(selection_full)

full_formula

# Apply forward stepwise selection to add predictors that improve AIC.
forward_model <- step(
  forward_null,
  scope = list(
    lower = ~1,
    upper = full_formula
  ),
  direction = "forward",
  trace = TRUE
)

formula(forward_model)

AIC(selection_full)
AIC(forward_model)

# Calculate the mean as a measure of central tendency.
mean(ml_data_complete$sales == 0) * 100

sum(
  ml_data_complete$sales %% 1 != 0
)

# Calculate the mean as a measure of central tendency.
mean(
  ml_data_complete$sales %% 1 != 0
) * 
  
  pca_check <- ml_data_complete[, c(
    "transactions",
    "onpromotion",
    "year"
  )]

# Calculate correlation to measure the strength and direction of association.
cor(pca_check, use = "complete.obs")  

# ============================================================
# TASK 6 – CRITICAL EVALUATION OF EXPERIMENTAL DESIGN
# ============================================================
# Critical discussion task – conducting an experiment is not required.
# Evaluate whether future supermarket investigations could use experimental designs.
# Discuss Completely Randomized Design (CRD) and Randomized Complete Block Design (RCBD).
# Explain situations where each design could be useful, expected advantages, limitations,
# implementation challenges, and practical feasibility in a supermarket environment.
# Support the written evaluation with relevant research literature.

# ============================================================
# TASK 7 – CRITICAL EVALUATION OF PRINCIPAL COMPONENT ANALYSIS (PCA)
# ============================================================
# Evaluate whether dimensionality reduction is actually necessary for this dataset.
# Discuss the potential advantages and limitations of PCA for supermarket sales analysis.
# Consider how PCA could affect predictive modelling and model interpretability.
# Explain situations where PCA should and should not be used.
# The PCA calculations below provide empirical evidence to support this critical discussion.

# Perform PCA on standardized numeric predictors to examine dimensionality reduction.
pca_result <- prcomp(
  pca_check,
  center = TRUE,
  scale. = TRUE
)

# Display summary statistics/results for interpretation.
summary(pca_result)

pca_result$rotation

# Convert PCA standard deviations into component variances.
pca_variance <- pca_result$sdev^2

variance_percent <- 
  pca_variance / sum(pca_variance) * 100

variance_percent

cumsum(variance_percent)


packages <- c(
  "e1071",
  "naivebayes",
  "rstanarm",
  "brms"
)

sapply(packages, function(x) {
  if (requireNamespace(x, quietly = TRUE)) {
    as.character(packageVersion(x))
  } else {
    "NOT INSTALLED"
  }
})


set.seed(123)

nb_index <- sample(
  seq_len(nrow(ml_data_complete)),
  size = 100000
)

nb_data <- ml_data_complete[nb_index, ]

# Check the dimensions to understand the number of rows and columns.
dim(nb_data)

set.seed(123)

nb_train_index <- sample(
  seq_len(nrow(nb_data)),
  size = 0.80 * nrow(nb_data)
)

nb_train <- nb_data[nb_train_index, ]

nb_test <- nb_data[-nb_train_index, ]

# Check the dimensions to understand the number of rows and columns.
dim(nb_train)
dim(nb_test)

# Use the training-set median as the cutoff for Low and High sales classes.
sales_threshold <- median(nb_train$sales)

sales_threshold

nb_train$sales_class <- ifelse(
  nb_train$sales > sales_threshold,
  "High",
  "Low"
)

nb_test$sales_class <- ifelse(
  nb_test$sales > sales_threshold,
  "High",
  "Low"
)

nb_train$sales_class <- factor(
  nb_train$sales_class,
  levels = c("Low", "High")
)

nb_test$sales_class <- factor(
  nb_test$sales_class,
  levels = c("Low", "High")
)
table(nb_train$sales_class)
prop.table(table(nb_train$sales_class))

table(nb_test$sales_class)
prop.table(table(nb_test$sales_class))

# ============================================================
# TASK 8 – CRITICAL EVALUATION OF BAYESIAN STATISTICAL METHODS
# ============================================================
# Evaluate the applicability of Bayesian methods to the supermarket business problem.
# Consider Naive Bayes, Bayesian Regression, and Bayesian Decision Making.
# Discuss whether these approaches are appropriate, including their advantages and limitations.
# Explain situations where Bayesian methods may perform better than traditional approaches.
# Support the critical discussion with published research.
# The following Naive Bayes and Bayesian regression analyses provide practical evidence.

library(e1071)

# Train the Naive Bayes classifier to predict Low versus High sales.
nb_model <- naiveBayes(
  sales_class ~ transactions +
    onpromotion +
    family +
    type +
    year +
    month +
    weekday,
  data = nb_train
)

nb_model

nb_pred <- predict(
  nb_model,
  newdata = nb_test,
  type = "class"
)

# Build a confusion matrix to compare actual and predicted sales classes.
cm <- table(
  Actual = nb_test$sales_class,
  Predicted = nb_pred
)

cm

# Calculate overall classification accuracy.
accuracy <- sum(diag(cm)) / sum(cm)

accuracy

TN <- cm["Low", "Low"]
FP <- cm["Low", "High"]
FN <- cm["High", "Low"]
TP <- cm["High", "High"]

TN
FP
FN
TP

sensitivity <- TP / (TP + FN)

specificity <- TN / (TN + FP)

precision <- TP / (TP + FP)

f1_score <- 2 * (
  precision * sensitivity
) / (
  precision + sensitivity
)

accuracy
sensitivity
specificity
precision
f1_score

nb_prob <- predict(
  nb_model,
  newdata = nb_test,
  type = "raw"
)

head(nb_prob)


# Fit a second Naive Bayes model with Laplace smoothing to handle zero-frequency probabilities.
nb_model_laplace <- naiveBayes(
  sales_class ~ transactions +
    onpromotion +
    family +
    type +
    year +
    month +
    weekday,
  data = nb_train,
  laplace = 1
)

nb_pred_laplace <- predict(
  nb_model_laplace,
  newdata = nb_test,
  type = "class"
)

cm_laplace <- table(
  Actual = nb_test$sales_class,
  Predicted = nb_pred_laplace
)

cm_laplace

TN_L <- cm_laplace["Low", "Low"]
FP_L <- cm_laplace["Low", "High"]
FN_L <- cm_laplace["High", "Low"]
TP_L <- cm_laplace["High", "High"]

accuracy_L <- (TP_L + TN_L) / sum(cm_laplace)

sensitivity_L <- TP_L / (TP_L + FN_L)

specificity_L <- TN_L / (TN_L + FP_L)

precision_L <- TP_L / (TP_L + FP_L)

f1_L <- 2 * (
  precision_L * sensitivity_L
) / (
  precision_L + sensitivity_L
)

accuracy_L
sensitivity_L
specificity_L
precision_L
f1_L

nb_comparison <- data.frame(
  Model = c(
    "Naive Bayes",
    "Naive Bayes + Laplace"
  ),
  
  Accuracy = c(
    accuracy,
    accuracy_L
  ),
  
  Sensitivity = c(
    sensitivity,
    sensitivity_L
  ),
  
  Specificity = c(
    specificity,
    specificity_L
  ),
  
  Precision = c(
    precision,
    precision_L
  ),
  
  F1 = c(
    f1_score,
    f1_L
  )
)

nb_comparison


packages_bayes <- c(
  "arm",
  "MCMCpack",
  "BayesReg",
  "BAS",
  "LearnBayes"
)

sapply(packages_bayes, function(x) {
  if (requireNamespace(x, quietly = TRUE)) {
    as.character(packageVersion(x))
  } else {
    "NOT INSTALLED"
  }
})


library(MCMCpack)

set.seed(123)

bayes_index <- sample(
  seq_len(nrow(train_data)),
  size = 20000
)

bayes_data <- train_data[bayes_index, ]

# Check the dimensions to understand the number of rows and columns.
dim(bayes_data)

set.seed(123)

# Fit Bayesian multiple regression using MCMC sampling.
bayes_model <- MCMCregress(
  log_sales ~ transactions +
    onpromotion +
    family +
    type +
    year +
    month +
    weekday,
  data = bayes_data,
  burnin = 2000,
  mcmc = 10000,
  thin = 5,
  b0 = 0,
  B0 = 0.001
)
# Display summary statistics/results for interpretation.
summary(bayes_model)

# Calculate posterior mean estimates for the Bayesian model parameters.
posterior_means <- colMeans(bayes_model)

posterior_means

# Calculate 95% credible intervals for Bayesian parameter estimates.
credible_intervals <- apply(
  bayes_model,
  2,
  quantile,
  probs = c(0.025, 0.975)
)

credible_intervals


important_parameters <- c(
  "transactions",
  "onpromotion"
)

bayes_results <- data.frame(
  Parameter = important_parameters,
  
  Posterior_Mean =
    posterior_means[important_parameters],
  
  Lower_95 =
    credible_intervals[
      "2.5%",
      important_parameters
    ],
  
  Upper_95 =
    credible_intervals[
      "97.5%",
      important_parameters
    ]
)

bayes_results

plot(bayes_model[, c(
  "transactions",
  "onpromotion"
)])

effectiveSize(
  bayes_model[, c(
    "transactions",
    "onpromotion"
  )]
)
geweke.diag(
  bayes_model[, c(
    "transactions",
    "onpromotion"
  )]
)

promotion_draws <- bayes_model[, "onpromotion"]

prob_promotion_positive <- mean(
  promotion_draws > 0
)

prob_promotion_positive

prob_promotion_above_005 <- mean(
  promotion_draws > 0.005
)

prob_promotion_above_005

promotion_effect_10 <- (
  exp(10 * promotion_draws) - 1
) * 100


# Calculate the mean as a measure of central tendency.
mean(promotion_effect_10)

# Calculate quartiles to understand the distribution and spread.
quantile(
  promotion_effect_10,
  probs = c(0.025, 0.5, 0.975)
)

prob_effect_above_5pct <- mean(
  promotion_effect_10 > 5
)

prob_effect_above_5pct


prob_promotion_positive

prob_promotion_above_005

# Calculate the mean as a measure of central tendency.
mean(promotion_effect_10)

# Calculate quartiles to understand the distribution and spread.
quantile(
  promotion_effect_10,
  probs = c(0.025, 0.5, 0.975)
)

prob_effect_above_5pct


# ============================================================
# TASK 9 – TIME SERIES ANALYSIS: CRITICAL EVALUATION
# ============================================================
# The assignment requires a critical discussion rather than mandatory time-series modelling.
# Discuss how historical time-dependent supermarket sales data could support trend analysis,
# seasonal analysis, forecasting, and ARIMA modelling.
# Explain possible business applications such as demand planning, inventory decisions,
# promotion planning, staffing, and sales forecasting, together with organizational benefits.
# Support the discussion with recent literature.
# The exploratory time-series analysis below can be used as additional supporting evidence.

sales$year <- as.integer(
  format(sales$date, "%Y")
)

sales$month_num <- as.integer(
  format(sales$date, "%m")
)

monthly_sales_ts <- aggregate(
  sales ~ year + month_num,
  data = sales,
  FUN = sum
)

head(monthly_sales_ts)
tail(monthly_sales_ts)

# Remove the incomplete final month so it does not distort time-series analysis.
monthly_complete <- subset(
  monthly_sales_ts,
  !(year == 2017 & month_num == 8)
)

tail(monthly_complete)

nrow(monthly_complete)

# Convert monthly sales into a time-series object with 12 observations per year.
sales_ts <- ts(
  monthly_complete$sales,
  start = c(2013, 1),
  frequency = 12
)

sales_ts

start(sales_ts)
end(sales_ts)
frequency(sales_ts)
length(sales_ts)

plot(
  sales_ts,
  main = "Monthly Supermarket Sales",
  xlab = "Year",
  ylab = "Total Sales",
  type = "l",
  lwd = 2
)

# Decompose monthly sales into trend, seasonal, and random components.
sales_decomp <- decompose(
  sales_ts,
  type = "additive"
)

plot(sales_decomp)


seasonal_means <- aggregate(
  monthly_complete$sales,
  by = list(
    Month = monthly_complete$month_num
  ),
  FUN = mean
)

seasonal_means

seasonal_means[
  order(
    seasonal_means$x,
    decreasing = TRUE
  ),
]

acf(
  sales_ts,
  main = "ACF of Monthly Supermarket Sales"
)

time_index <- seq_along(sales_ts)

# Fit a linear trend model to quantify the overall change in sales over time.
trend_model <- lm(
  as.numeric(sales_ts) ~ time_index
)

# Display summary statistics/results for interpretation.
summary(trend_model)

requireNamespace("tseries", quietly = TRUE)

library(tseries)

adf_original <- adf.test(
  sales_ts,
  alternative = "stationary"
)

adf_original


sales_diff <- diff(sales_ts)

plot(
  sales_diff,
  main = "First-Differenced Monthly Sales",
  xlab = "Year",
  ylab = "Change in Sales",
  type = "l"
)

adf_diff <- adf.test(
  sales_diff,
  alternative = "stationary"
)

adf_diff


sales_seasonal_diff <- diff(
  sales_ts,
  lag = 12
)

plot(
  sales_seasonal_diff,
  main = "Seasonally Differenced Monthly Sales",
  xlab = "Year",
  ylab = "Year-on-Year Change",
  type = "l"
)

adf_seasonal <- adf.test(
  sales_seasonal_diff,
  alternative = "stationary"
)

adf_seasonal

acf(
  sales_diff,
  main = "ACF - First-Differenced Sales"
)

pacf(
  sales_diff,
  main = "PACF - First-Differenced Sales"
)

acf(
  sales_seasonal_diff,
  main = "ACF - Seasonally Differenced Sales"
)

pacf(
  sales_seasonal_diff,
  main = "PACF - Seasonally Differenced Sales"
)

library(forecast)

auto_model <- auto.arima(
  sales_ts,
  seasonal = TRUE,
  stepwise = FALSE,
  approximation = FALSE,
  trace = TRUE
)

auto_model

checkresiduals(auto_model)

sales_forecast <- forecast(
  auto_model,
  h = 12
)

sales_forecast


plot(
  sales_forecast,
  main = "12-Month ARIMA Forecast of Monthly Sales",
  xlab = "Year",
  ylab = "Total Sales"
)
