# E-Commerce Time-Series Analysis Report
**Analyst:** Jineen Hourani  
**Date:** April 2026

## 1. Executive Summary
This report provides a comprehensive analysis of e-commerce performance using advanced SQL techniques. By leveraging **PostgreSQL Window Functions**, we analyzed customer retention, revenue growth, and category-level trends to identify key business drivers.

## 2. Key Performance Insights

### A. Customer Loyalty (Cohort Analysis)
* **High Initial Retention:** The April 2025 cohort started with **524 customers**, maintaining a strong retention rate above **50%** in the first 30 days.
* **Stable Engagement:** Across most cohorts (May–September), there is a consistent pattern where approx **40-45%** of customers return within 90 days, indicating a healthy product-market fit.
* **October Surge:** We noticed a spike in new customer acquisition in October (**479 new customers**), which correlates with the revenue growth observed in the same period.

### B. Revenue Growth Analysis
* **Consistent Growth:** Monthly revenue showed a steady upward trajectory, starting at **$229,540** in April and reaching **$864,010** by October.
* **Peak Growth Rate:** The highest month-over-month growth occurred in May (**34.26%**) and October (**32.69%**). 
* **Scaling Success:** The significant revenue jump in October suggests successful seasonal promotions or marketing expansions.

### C. Category Trends (Combined Analysis)
* **Dominant Category:** **Electronics** is the primary revenue driver, contributing **$112,646** (nearly **49%**) of the total revenue in the first month alone.
* **Steady Performers:** Clothing and Home & Kitchen maintain consistent performance, while Books show growth potential, increasing their 3-month moving average steadily.

## 3. Technical Implementation
* **Infrastructure:** The environment was managed using **Docker** with a **PostgreSQL 15-alpine** container.
* **Methods:** Used `DATE_TRUNC` for time-series grouping, `LAG()` for growth calculations, and `OVER(PARTITION BY ...)` for categorical comparisons.
* **Efficiency:** All data processing was performed server-side within the database to ensure performance at scale.

Manual data validation was performed to ensure SQL result accuracy against raw CSV counts.

