# Toy Store E-Commerce SQL Analytics

**Maven Fuzzy Factory**

## Problem Statement

The objective of this project is to analyze a real-world e-commerce dataset from Maven Fuzzy Factory in order to understand website traffic, customer conversion behavior, marketing channel effectiveness, product performance, and refund patterns.

The analysis focuses on identifying where users drop out of the purchasing funnel, which marketing channels generate the most valuable traffic, and which products contribute to or hurt overall revenue, so that the business can make data-driven decisions to improve growth and profitability.

---

## Dataset

This project uses the **Toy Store E-Commerce Database (Maven Fuzzy Factory)** provided by Maven Analytics.

The dataset includes:

* Website sessions and marketing attribution
* Page-level website activity
* Orders and revenue
* Product-level sales
* Refund and return information

This dataset represents a realistic online retail environment and supports full funnel, marketing, and product performance analysis.

---

## Tech Stack

* MySQL
* SQL (CTEs, subqueries, joins, aggregations)
* MySQL Workbench
* Git & GitHub

---

## Database Schema Overview

The database is designed to track the full customer journey from the first website visit to purchase and potential refund.

Main tables include:

* website_sessions
* website_pageviews
* orders
* order_items
* products
* order_item_refunds

Primary keys, foreign keys, and indexes were defined to ensure data integrity, enforce correct relationships, and enable efficient analytical queries.

---

## Data Preparation & Validation

Before running any analysis, the data was validated to ensure accuracy and reliability.

This included:

* Verifying row counts for all tables
* Checking for duplicate primary keys
* Validating foreign key relationships
* Performing null and value sanity checks
* Conducting temporal integrity checks across the customer journey

These steps ensured the dataset was clean, consistent, and suitable for business analysis.

---

## Analysis Scope

The analysis was conducted entirely using SQL and focused on the following areas:

* Core business performance (sessions, orders, revenue, conversion rate)
* Website conversion funnel
* Marketing channel efficiency
* Revenue per session by channel
* Product performance and sales volume
* Refund rates and revenue loss

CTEs and subqueries were used to structure complex queries and produce clean, reusable analytical outputs.

---

## Key Questions Answered

* How many users visit the website and how many convert into buyers?
* Where do users drop off in the purchase funnel?
* Which marketing channels generate the most efficient traffic?
* How much revenue does each channel generate per session?
* Which products drive the most revenue and unit sales?
* Which products experience high refund rates?
* How much revenue is lost due to refunds?

---

## Key Insights

Detailed business insights and recommendations are documented in:
`12_insights/key_findings.md`

---

## Repository Structure

01_schema/
02_ingestion/
03_data_quality/
04_core_metrics/
05_funnel_analysis/
06_marketing_analysis/
07_product_analysis/
08_views/
09_Insights/
README.md
