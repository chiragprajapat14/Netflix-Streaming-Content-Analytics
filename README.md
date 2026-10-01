# E-Commerce Retail Sales & Customer Analytics

## 📌 Project Overview
This repository implements a retail database analytics engine designed to extract financial and customer insights from corporate sales logs. The analysis tracks key commercial metrics including product inventory velocity, rolling sales trends, customer purchase triggers, and multi-tier revenue distribution percentages.

The project demonstrates production-grade SQL optimization queries utilized to streamline stock control and map customer acquisition value.

## 🛠️ Tech Stack & Advanced SQL Highlights
* **Core Framework**: MySQL Engine
* **Advanced Commands Demonstrated**:
  * Multi-Column Aggregate Joins (`INNER JOIN`, `LEFT JOIN`)
  * Rolling Trend Windows (`AVG(x) OVER (ORDER BY x ROWS BETWEEN ...)`)
  * Customer Event Triggers (`SUM(CASE WHEN DATE_FORMAT(...) THEN 1 ELSE 0 END)`)
  * Dynamic Revenue Contribution Percentages (`SUM(x) / SUM(SUM(x)) OVER(PARTITION BY ...)`)
  * Context Aggregation Triggers (`HAVING SUM(Quantity) > 0.80 * Stock`)

---

## 📊 Database Architecture Design
The layout maps transactional entries across two highly optimized tables:
1. **`retail_products`**: Core inventory catalog containing item names, prices, categories, and physical stock limits.
2. **`retail_sales`**: Transaction ledger logging quantities, purchase timestamps, client IDs, and gross bills.

---

## 🔍 Core Business Insights Addressed

### 1. Rolling Average Sales Velocity
* **Business Target**: Smooth out daily transaction spikes to track consistent baseline velocity. Uses frame modifiers (`ROWS BETWEEN 2 PRECEDING AND CURRENT ROW`) to compute a clean 3-day rolling sales monitor.

### 2. High-Risk Low-Inventory Alerts
* **Business Target**: Prevent catastrophic stock-outs on highly demanded items. Isolates products whose accumulated sales volume has drained over 80% of their warehouse stock limits.

### 3. Category Revenue Contribution Percentages
* **Business Target**: Identify core cash-cow items driving individual store sections. Divides item sales by the category total using partition windows (`OVER(PARTITION BY Category)`) to output exact asset ratios.

### 4. Cohort Acquisition & Activity Audits
* **Business Target**: Audit user retention after massive promotional blocks. Uses date-time switch flags (`CASE WHEN DATE_FORMAT(...)`) to instantly flag users who purchased during specific campaign timeframes.

---

## 🚀 Execution Instructions
1. Run the database setup commands located in `schema.sql` to build the physical layouts.
2. Populate the tables with transaction rows containing overlapping inventory numbers.
3. Open `queries.sql` to execute the production analytics scripts and look at item leadership metrics.
