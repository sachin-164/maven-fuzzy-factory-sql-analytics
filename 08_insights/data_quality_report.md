## Data Quality and Validation Summary

### 1. Data Completeness

All tables were successfully loaded and validated through row count checks. No missing or partially ingested tables were detected across sessions, pageviews, orders, order items, products, or refunds. This confirms the dataset is structurally complete and ready for analysis.

---

### 2. Primary Key Integrity

All primary key columns were checked for duplicates. No duplicate values were found for website sessions, pageviews, orders, order items, products, or refunds. This ensures that each business event is recorded only once and that metrics such as sessions, revenue, and units sold are not artificially inflated.

---

### 3. Referential Integrity

All foreign key relationships were validated across the database. Every pageview maps to a valid session, every order maps to a valid session, every order item maps to a valid order and product, and every refund maps to a valid order item. No orphan records were detected, confirming that all joins between tables are safe and logically consistent.

---

### 4. Null and Value Sanity Checks

Critical business fields such as timestamps and monetary values were examined for null, zero, or negative values. No invalid values were found in revenue or refund fields. Non-critical fields contained expected nulls and were retained, reflecting realistic website and marketing data collection.

---

### 5. Temporal Integrity

Event timestamps were checked to ensure the correct sequence of the customer journey. Pageviews always occurred after sessions began, orders occurred after sessions, order items were created after orders, and refunds occurred only after the corresponding items were purchased. No future-dated records were found. This confirms that the dataset follows a valid lifecycle for funnel and trend analysis.
