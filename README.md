# Customer-Personality-Analysis
This project explores a marketing dataset to understand customer behavior based on demographics, product spending, and campaign engagement. It involves SQL-based data preprocessing, segmentation, and visual storytelling in Power BI.
📁 Dataset
# Source: Customer Personality CSV Dataset
# Attributes: Demographics, product purchase history, campaign responses, and registration date.
# Size: 2241 rows

🧰 Tools Used
# PostgreSQL (pgAdmin 4): Data cleaning and querying
# Power BI: Interactive dashboard creation
# GitHub: Code and project versioning

🧹 Data Preprocessing (SQL)
# Removed duplicates
# Handled NULL and negative values in income
# Created Total_Spending and Spending_Category columns
# Grouped and analyzed by marital_status, education, year, and product spending

🎯 Key Business Questions Answered

| Question                                                            | Visual Type       |
| ------------------------------------------------------------------- | ----------------- |
| What is the average customer spending by marital status?            | Bar Chart         |
| How are customers segmented by spending behavior (Low/High)?        | Donut Chart       |
| How did customer acquisition trend year-over-year?                  | Line/Bar Chart    |
| Which education levels spend the most on average?                   | Bar Chart         |
| Which campaigns performed best in terms of engagement or income?    | Bar Chart + Joins |
| How does average income trend across years?                         | KPI + Line Chart  |
| Are spending levels increasing over time?                           | KPI & Trend Chart |

📈 Dashboard Overview
# KPI Cards: Total Spending, Avg Income, New Customers (2013 vs 2014)
# Spending Segmentation: By education, marital status, and behavior
# Trend Analysis: Yearly acquisition and income growth
# Customer Insights: Who spends more? Who responds to campaigns?

📎 Power BI Dashboard Link
https://app.powerbi.com/groups/me/reports/cfed35ce-c7b7-4f00-8103-6eee8434656b/97acad337c572ae49580?experience=power-bi

📚 Insights & Conclusions
# Married and Together customers have slightly higher spending.
# Higher education levels (Graduation, PhD) show stronger purchasing behavior.
# Spending increased significantly from 2013 to 2014.
# Most customers fall into the High spending category.
