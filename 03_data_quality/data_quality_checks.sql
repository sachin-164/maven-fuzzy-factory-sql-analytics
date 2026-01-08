-- Row counts per table
SELECT COUNT(*) FROM website_sessions;
SELECT COUNT(*) from website_pageviews;
SELECT COUNT(*) from products;
SELECT COUNT(*) from orders;
SELECT COUNT(*) from order_items;
SELECT COUNT(*) from order_item_refunds;

-- Duplicate primary keys
SELECT website_session_id,
	COUNT(*) AS duplicate_primarykey_count
FROM website_sessions
GROUP BY website_session_id
HAVING COUNT(*) > 1;

SELECT website_pageview_id,
	COUNT(*) AS duplicate_primarykey_count
FROM website_pageviews
GROUP BY website_pageview_id
HAVING COUNT(*) > 1;

SELECT product_id,
	COUNT(*) AS duplicate_primarykey_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT order_id,
	COUNT(*) AS duplicate_primarykey_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT order_item_id,
	COUNT(*) AS duplicate_primarykey_count
FROM order_items
GROUP BY order_item_id
HAVING COUNT(*) > 1;

SELECT order_item_refund_id,
	COUNT(*) AS duplicate_primarykey_count
FROM order_item_refunds
GROUP BY order_item_refund_id
HAVING COUNT(*) > 1;

-- Orphan foreign keys
