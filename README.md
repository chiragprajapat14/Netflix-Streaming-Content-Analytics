# Netflix Content Catalog & Viewer Engagement Analytics

## 📌 Project Overview
This repository houses an end-to-end data analytics project mapping the content metrics and consumer watch profiles for Netflix. The analysis breaks down asset engaging benchmarks, sequential movie binging behaviors, and active platform retention metrics using structured media data pipelines.

The codebase targets enterprise business problems such as regional viewership health, viewer churn warnings, and consumer device app optimization patterns.

## 🛠️ Tech Stack & Advanced SQL Highlights
* **Core Framework**: MySQL Engine
* **Advanced Commands Demonstrated**:
  * Sequential Window Tracking (`LEAD() OVER (PARTITION BY ... ORDER BY)`)
  * Grouped Cross-Aggregate Ratios (`SUM(x) / SUM(SUM(x)) OVER()`)
  * String Manipulation & Text Stripping (`CAST`, `SUBSTRING_INDEX`)
  * Aggregate Conditional Metrics (`SUM(CASE WHEN ... THEN 1 ELSE 0 END)`)
  * Multi-Table Relational Data Joins (`INNER JOIN`)

---

## 📊 Database Blueprint & Architecture
The system functions across three decoupled tables:
1. **`netflix_titles`**: Core media library catalog storing runtime logs, genres, classifications, and countries.
2. **`netflix_users`**: Active global subscriber logs containing user names, nationalities, and billing tiers.
3. **`netflix_watch_history`**: Live stream telemetry logging user clicks, duration counters, and device types.

---

## 🔍 Strategic Business Queries Resolved

### 1. Movie Binge Completion Logs
* **Business Target**: Identify highly sticky features where users finished more than 100% of the listed runtime length. Evaluates textual variables (`duration`) against physical viewing thresholds using text mining rules.

### 2. Device App Usage Market Share
* **Business Target**: Isolate total streaming load metrics partitioned dynamically across hardware interfaces (Smart TV vs Mobile). Generates instant budget distribution insight for software product design teams.

### 3. Chronological Viewing Binge Flow
* **Business Target**: Feed recommendation algorithms with user consumption sequences. Utilizes sequential window lookup arrays (`LEAD()`) to view exactly which video title an active user clicked on *next* in their session journey.

### 4. Categorical Taste Summary Profile
* **Business Target**: Combine vast historical show labels into a single unified customer profile list. Uses clean string concatenations (`GROUP_CONCAT`) to map consumer genre tastes without text row flooding.

### 5. Dynamic Viewership Retention Status
* **Business Target**: Isolate active profile sessions from inactive profiles. Evaluates aggregate calendar time bounds (`MAX(watch_date)`) to flag users requiring immediate discount coupon intervention.

---

## 🚀 Execution Instructions
1. Establish a test schema connection in your database panel.
2. Execute the data blueprints located in `schema.sql` to construct tables and populate the transaction tables.
3. Run the analytical checks written inside `queries.sql` to view instant product performance and retention grids.

---

## 🚀 Execution Instructions
1. Run the database setup commands located in `schema.sql` to build the physical layouts.
2. Populate the tables with transaction rows containing overlapping inventory numbers.
3. Open `queries.sql` to execute the production analytics scripts and look at item leadership metrics.
