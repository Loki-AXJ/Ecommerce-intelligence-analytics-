# 🛒 Enterprise E-Commerce Data Warehouse & BI Analytics

> **An end-to-end relational database analytics suite built using MySQL 8.0, CTEs, Window Functions, and RFM Customer Segmentation across 5,000+ transaction records.**

---

## 📌 Executive Summary

This repository contains a full-stack relational database project (`ecommerce_intelligence`) designed to simulate multi-channel enterprise retail operations. The analysis evaluates product performance, customer lifetime value (LTV), transaction fulfillment health, and time-series growth metrics.

All analytical queries are strictly compliant with ANSI SQL standards and MySQL `ONLY_FULL_GROUP_BY` modes.

---

## 📊 Business KPIs At A Glance

| Metric | Total Value |
| :--- | :--- |
| **Gross Processed Revenue** | **$7,803,865.98** |
| **Total Completed Orders** | **5,000** |
| **Total Line Items Sold** | **12,532** |
| **Average Order Value (AOV)** | **$1,560.77** |
| **Active Customer Base** | **1,000** |

---

## 📐 Schema & Architecture

The database model follows a normalized snowflake schema centered on customer transactions:

+---------------+       +-----------------+       +---------------+
|   CUSTOMERS   |------>|     ORDERS      |<------|   PAYMENTS    |
+---------------+       +-----------------+       +---------------+
|
v
+-----------------+
|   ORDER_ITEMS   |
+-----------------+
|
v
+-----------------+
|    PRODUCTS     |
+-----------------+

### 📂 Relational Datasets (`/data`)
* **`customers.csv`** (1,000 records): Customer profiles, acquisition channels (`Paid Ads`, `Email`, `Organic Search`, `Social Media`, `Referral`).
* **`products.csv`** (120 records): Product catalog, categories (`Electronics`, `Home`, `Fashion`), unit prices.
* **`orders.csv`** (5,000 records): Timestamps and fulfillment statuses (`Completed`, `Cancelled`, `Returned`, `Pending`).
* **`order_items.csv`** (12,532 records): Transaction line items specifying quantities and exact pricing.
* **`payments.csv`** (5,000 records): Gateway payment methods (`Credit Card`, `UPI`, `Net Banking`, `Debit Card`).

---

## 🔍 Analytical Modules & Key Insights

### 🛍️ 1. Revenue & Product Performance (`sql/03_module1_revenue_product.sql`)
* **Top Revenue Category:** **Electronics** generated **$5,999,140.06** (76.8% of total gross revenue) across 10,174 units sold.
* **Top Individual Product:** *Dell Laptops 3* generated **$349,024.62** across 238 units sold.

### 👥 2. Customer Lifecycle & RFM Segmentation (`sql/04_module2_rfm_segmentation.sql`)
* **VIP Tier (>= $10,000 spend):** 294 high-value customers drove **$4,033,164.38** (51.6% of gross revenue) with an average spend of **$13,718.25** per account.
* **Top Acquisition Channel:** **Social Media** sign-ups achieved the highest total revenue ($1,805,015.31) and highest LTV ($8,356.55/customer).

### 💳 3. Payment Gateways & Fulfillment Health (`sql/05_module3_payments_order_health.sql`)
* Gateway processed revenue was balanced across Credit Card ($1.99M), UPI ($1.96M), Net Banking ($1.92M), and Debit Card ($1.92M).
* Reconciled order status metrics across Completed (82.5%), Cancelled (9.3%), Returned (4.6%), and Pending (3.6%) transactions.

### 📈 4. Cohort Growth & Window Functions (`sql/06_module4_cohorts_window_functions.sql`)
* Utilized `LAG()` to track Month-over-Month (MoM) revenue variance.
* Applied `SUM() OVER()` to build cumulative revenue trajectories scaling from $2,866.06 in Jan 2024 to $7,803,865.98 in Aug 2026.

---

## 🛠️ How To Run Locally

### 1. Database Setup
Execute schema creation and table definitions:
```sql
SOURCE sql/01_schema_setup.sql;
