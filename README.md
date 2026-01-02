# 🛍️ Customer Shopping Behavior Analytics

## 📝 Overview
This project is an end-to-end data analytics study designed to understand customer purchasing habits. The workflow involves an ETL (Extract, Transform, Load) process where raw data is cleaned and enriched in **Python**, migrated to a **SQL Server** database for warehousing, and finally visualized in **Power BI** to drive business decisions.

**Key Business Goal:** Analyze spending trends, subscription impact, and regional preferences to optimize marketing strategies.

## 📂 Dataset
* **Source:** `customer_shopping_behavior.csv`
* **Volume:** 3,900 Records | 19 Columns
* **Key Attributes:**
    * **Customer Demographics:** Age, Gender, Location.
    * **Purchase Details:** Item Purchased, Category, Purchase Amount (USD).
    * **Behavioral Metrics:** Review Rating, Subscription Status, Frequency of Purchases.

## 🛠️ Tools & Technologies
* **Python (Google Colab):** Pandas, NumPy, SQLAlchemy, PyODBC (Data Cleaning & ETL).
* **Microsoft SQL Server:** Data storage and management.
* **Ngrok:** Exposing local SQL Server to Google Colab for remote data insertion.
* **Power BI:** Interactive Dashboarding & Data Modeling.
* **Gamma:** AI-powered presentation generation.

## 🔄 Project Steps

### 1. Data Cleaning & Preprocessing (Python)
The raw dataset underwent a rigorous cleaning process in Jupyter Notebook:
* **Missing Values:** Handled nulls in the `Review Rating` column using median imputation.
* **Standardization:** Renamed columns to snake_case (e.g., `Purchase Amount (USD)` → `purchase_amount`) for consistency.
* **Redundancy Removal:** Dropped the `promo_code_used` column after confirming a 100% correlation with `discount_applied`.

### 2. Feature Engineering
To enable deeper analysis, new features were created:
* **`age_group`:** Segmented customers into 4 quartiles: *Young Adult, Adult, Middle-Age, Senior*.
* **`purchase_frequency_days`:** Mapped categorical frequencies (e.g., "Fortnightly", "Weekly") to numeric values (e.g., 14, 7) for time-series analysis.

### 3. Database Migration (SQL)
* Established a connection to a local SQL Server instance using `sqlalchemy` and `pyodbc` via Ngrok.
* Exported the processed DataFrame into the `customer_behavior` database under the table name `customer`.

### 4. Visualization (Power BI)
* Connected Power BI to the SQL Server database.
* Built an interactive dashboard focusing on:
    * Sales performance by Region and Season.
    * Impact of Subscriptions on Purchase Frequency.
    * Customer Segmentation by Age Group.

## 📈 Dashboard Insights
*(Placeholder: Insert your Power BI screenshot here)*

**Key Findings:**
* **Demographics:** The "Middle-Age" group contributes to the highest volume of purchases.
* **Logistics:** "Express" shipping is the preferred method for Subscription users.
* **Seasonality:** Sales peak during Spring and Winter, driven largely by the Clothing category.

## 💻 How to Run
1.  **Python ETL:**
    * Open `customer_behavior.ipynb` in Google Colab or Jupyter.
    * Update the `host` and `port` variables in the SQL Connection cell with your current Ngrok configuration.
    * Run all cells to clean data and push it to SQL Server.
2.  **SQL Setup:**
    * Ensure SQL Server is running and the database `customer_behavior` exists.
3.  **Power BI:**
    * Open the `.pbix` file.
    * Refresh the data source to pull the latest data from your SQL table.

## 📽️ Presentation
The final report and slide deck were generated using Gamma.
[Link to Presentation / PDF]

---
**Author:** [Your Name]
