# 🛒 Supermarket Sales Analytics & Statistical Modelling

### Transforming Supermarket Data into Strategic Business Decisions

**An end-to-end statistical modelling project using R to analyse supermarket sales, identify business patterns, develop predictive models, and support data-driven management decisions.**

---

## 📌 Project Overview

This project was completed as part of the **IT3081 – Statistical Modelling** module at SLIIT.

The main objective was to investigate the factors associated with supermarket sales performance and demonstrate how statistical modelling can support better business decisions.

The project involved analysing historical supermarket sales data, performing exploratory and inferential statistical analysis, developing predictive models, evaluating advanced statistical techniques, and proposing a supermarket sales analytics and decision-support solution.

The analysis uses the **Corporación Favorita Store Sales dataset** as a proxy dataset because the participating organization, KS Super, could not provide its internal sales data due to confidentiality and commercial sensitivity.

## 🎯 Project Objectives

- Understand the factors associated with variations in supermarket sales.
- Explore sales patterns across stores, product families, promotions, and time.
- Apply statistical hypothesis testing to investigate significant differences and relationships.
- Develop and compare predictive statistical models.
- Apply advanced statistical techniques, including Bayesian modelling and time-series forecasting.
- Translate analytical findings into practical supermarket management recommendations.
- Propose an integrated Sales Analytics and Decision Support Dashboard.

---

## 📊 Dataset Description

The project uses the historical Corporación Favorita supermarket dataset from Ecuador.

The main dataset contains approximately:

| Dataset characteristic | Description |
|---|---|
| Sales records | 3 million+ |
| Stores | 54 |
| Product families | 33 |
| Historical period | January 2013 – August 2017 |
| Programming language | R |

### Data Sources

The analysis integrates five datasets:

| Dataset | Description |
|---|---|
| `train.csv` | Daily sales by store and product family |
| `stores.csv` | Store information and characteristics |
| `transactions.csv` | Daily store transaction counts |
| `holidays_events.csv` | Holidays and special events |
| `oil.csv` | Historical oil prices |

**Note:** Raw dataset files are not included in this repository. Users should obtain the dataset from its original source and place the required CSV files inside the `data/` directory.

---

## 🛠️ Technologies & Tools

- **R Programming** – Statistical analysis and modelling
- **Data Cleaning** – Missing-value, duplicate and data-quality checks
- **Exploratory Data Analysis** – Statistical summaries and visualizations
- **Statistical Inference** – Hypothesis testing and correlation analysis
- **Predictive Modelling** – Regression and classification
- **Advanced Statistics** – PCA and Bayesian methods
- **Time-Series Analysis** – Trend, seasonality and ARIMA forecasting

---

## 🔬 Project Methodology

### 1. Data Understanding & Exploratory Data Analysis

- Examined dataset structures and variables.
- Performed data cleaning and preprocessing.
- Analysed missing values, duplicates and unusual observations.
- Generated descriptive statistics and visualizations.
- Investigated sales distributions and patterns.

### 2. Statistical Inference

Applied statistical tests to investigate supermarket sales relationships and differences.

- Welch ANOVA
- Kruskal-Wallis test
- Pearson correlation
- Spearman correlation
- Hypothesis testing
- Effect-size interpretation

### 3. Predictive Statistical Modelling

Developed and compared multiple regression models:

- Multiple Linear Regression
- Ridge Regression
- LASSO Regression
- Elastic Net Regression

Also applied:
- Forward selection
- Backward elimination
- Model evaluation
- Residual diagnostics

### 4. Principal Component Analysis (PCA)

- Evaluated dimensionality reduction.
- Examined explained variance.
- Assessed the usefulness of PCA for the available predictors.

### 5. Bayesian Statistical Methods

- Applied Naïve Bayes classification.
- Evaluated Laplace smoothing.
- Developed Bayesian regression using MCMC.
- Analysed posterior distributions and credible intervals.

### 6. Time-Series Analysis

- Examined historical sales trends.
- Investigated seasonality and stationarity.
- Applied Augmented Dickey-Fuller testing.
- Developed ARIMA forecasting models.
- Evaluated forecast uncertainty and residual diagnostics.

### 7. Experimental Design

Evaluated experimental approaches for investigating promotional strategies:

- Completely Randomized Design (CRD)
- Randomized Complete Block Design (RCBD)

### 8. Business Innovation Proposal

Proposed an integrated **Supermarket Sales Analytics and Decision Support Dashboard** to transform statistical findings into practical management insights.

---

## 📈 Key Statistical Findings

### Statistical Inference

| Analysis | Result |
|---|---|
| Store-type differences | Welch ANOVA p = 0.000995 |
| Product-family differences | Welch ANOVA p < 0.001 |
| Promotion and sales | Pearson r = 0.4279 |
| Transaction volume and sales | Pearson r = 0.8374 |

The analysis identified statistically significant sales differences across store types and product families. Promotional activity and transaction volume also showed positive associations with sales.

### Predictive Model Comparison

Four regression models were evaluated using held-out test data.

| Model | Test R² |
|---|---:|
| Multiple Linear Regression | 0.8495 |
| Ridge Regression | 0.8461 |
| LASSO Regression | 0.8494 |
| Elastic Net Regression | 0.8494 |

**Best-performing explanatory baseline:** Multiple Linear Regression, with a test R² of approximately 0.8495.

LASSO was retained as a useful regularized benchmark.

### Advanced Modelling Results

- **PCA:** Two principal components explained 73.53% of the variance.
- **Naïve Bayes:** Accuracy improved from 79.01% to 85.99% after Laplace smoothing.
- **Bayesian Regression:** Used MCMC to estimate posterior distributions and credible intervals.
- **ARIMA:** ARIMA(5,0,0) was selected for the historical forecasting demonstration.

---

## 💡 Proposed Business Solution

### Supermarket Sales Analytics and Decision Support Dashboard (SSADSD)

The final business innovation proposal is an integrated analytics and decision-support framework designed to help supermarket management make evidence-based decisions.

Proposed dashboard components:

1. **Sales Performance Monitoring** – Monitor sales trends and compare branch performance.
2. **Product-Family Analytics** – Identify differences in product-category performance.
3. **Promotion Analytics** – Evaluate promotional activity alongside product and timing factors.
4. **Transaction Analytics** – Monitor transaction volume and average basket value.
5. **Predictive Analytics** – Provide statistical model predictions and insights.
6. **Demand Forecasting** – Support inventory planning, purchasing and budgeting.
7. **Management Alerts** – Identify unusual performance and potential stockout risks.

The dashboard is a conceptual business solution proposed by the project, not a deployed software application.

---

## 📁 Repository Structure

```text
Supermarket-Sales-Analytics-Statistical-Modelling/
│
├── code/
│   ├── README.md
│   └── Supermarket_Sales_Analysis.R
│
├── data/
│   └── README.md
│
├── presentation/
│   ├── README.md
│   └── Project_Presentation.pptx
│
├── report/
│   └── Consultancy_Report.docx
│
├── .gitignore
└── README.md
```

---

## ▶️ How to Run the Project

### Prerequisites

- R (latest compatible version recommended)
- RStudio (recommended)
- Required dataset CSV files

### Step 1: Clone the repository

```bash
git clone https://github.com/medhavi2003/Supermarket-Sales-Analytics-Statistical-Modelling.git
```

### Step 2: Obtain the datasets

Download the required Corporación Favorita dataset files and place them inside the `data/` directory.

The required files are:

- train.csv
- stores.csv
- transactions.csv
- holidays_events.csv
- oil.csv

### Step 3: Install the required R packages

Check the package dependencies in the R script and install any missing packages.

### Step 4: Run the R script

Open the project in RStudio and execute:

```r
source("code/Supermarket_Sales_Analysis.R")
```

Ensure the working directory is set to the repository's root folder and that the dataset paths match the script.

---

## ⚠️ Limitations

- The analysis uses historical proxy data rather than confidential KS Super internal data.
- The dataset represents a different geographical market and historical period.
- Observational associations do not establish causal relationships.
- The ARIMA forecast is a historical methodological demonstration, not a current business forecast.
- The proposed dashboard has not been implemented as a functioning application.
- All models require validation using recent organizational data before operational deployment.

---

## 🏁 Conclusion

This project demonstrates the application of statistical modelling to supermarket sales analytics, combining exploratory data analysis, statistical inference, predictive modelling, Bayesian methods and time-series forecasting.

The findings highlight the importance of understanding store-level, product-level, promotional and temporal sales patterns.

The proposed Sales Analytics and Decision Support Dashboard provides a conceptual framework for transforming supermarket data into actionable business insights, supporting more informed decisions in sales monitoring, promotion evaluation, inventory planning and demand forecasting.

---

## 👥 Project Information

**Module:** IT3081 – Statistical Modelling

**Institution:** Sri Lanka Institute of Information Technology (SLIIT)

**Project Type:** Academic Group Project

**Programming Language:** R

**Domain:** Retail Analytics / Statistical Modelling / Business Decision Support

---

⭐ If you find this project interesting, feel free to explore the R code, consultancy report and presentation included in this repository.
