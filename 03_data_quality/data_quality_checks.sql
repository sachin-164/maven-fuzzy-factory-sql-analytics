-- Row counts per table
select count(*) from website_sessions;
select count(*) from website_pageviews;
select count(*) from products;
select count(*) from orders;
select count(*) from order_items;
select count(*) from order_item_refunds;

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

-- Orphan foreign keys check
SELECT wp.website_session_id
FROM website_pageviews wp
LEFT JOIN website_sessions ws
	ON wp.website_session_id = ws.website_session_id
WHERE ws.website_session_id is NULL;   -- for unmatched

SELECT o.website_session_id
FROM orders o
LEFT JOIN website_sessions ws
	ON o.website_session_id = ws.website_session_id
WHERE o.website_session_id IS NULL;

SELECT oi.order_id 
FROM order_items oi
LEFT JOIN orders o
	ON oi.order_id = o.order_id
WHERE oi.order_id IS NULL;

SELECT oi.product_id
FROM order_items oi
LEFT JOIN products p
	ON oi.product_id = p.product_id
WHERE oi.product_id IS NULL;

SELECT oii.order_item_id 
FROM order_item_refunds oii
LEFT JOIN order_items oi
	ON oii.order_item_id = oi.order_item_id
WHERE oii.order_item_id IS NULL;

-- Null and Range Checks
SELECT COUNT(*) FROM website_sessions WHERE created_at IS NULL;
SELECT COUNT(*) FROM orders WHERE price_usd <= 0 OR price_usd IS NULL;
SELECT COUNT(*) FROM order_items WHERE price_usd <= 0 OR price_usd IS NULL;
SELECT COUNT(*) FROM order_item_refunds WHERE refund_amount_usd <= 0 OR refund_amount_usd IS NULL;

-- Temporal Sanity Checks
-- Pageviews before session
SELECT COUNT(*) 
FROM website_pageviews wp
JOIN website_sessions ws
	ON wp.website_session_id = ws.website_session_id
WHERE wp.created_at < ws.created_at;

-- Orders before session
SELECT COUNT(*) 
FROM orders o
JOIN website_sessions ws
	ON o.website_session_id = ws.website_session_id
WHERE o.created_at < ws.created_at;

-- Order items before order
SELECT COUNT(*) 
FROM order_items oi
JOIN orders o 
	ON oi.order_id = o.order_id
WHERE oi.created_at < o.created_at;

-- Refunds before order item
SELECT COUNT(*) 
FROM order_item_refunds oir
JOIN order_items oi
	ON oir.order_item_id = oi.order_item_id
WHERE oir.created_at < oi.created_at;

-- check for future dates
SELECT COUNT(*) FROM website_sessions WHERE created_at > NOW();
SELECT COUNT(*) FROM website_pageviews WHERE created_at > NOW();
SELECT COUNT(*) FROM products WHERE created_at > NOW();
SELECT COUNT(*) FROM orders WHERE created_at > NOW();
SELECT COUNT(*) FROM order_items WHERE created_at > NOW();
SELECT COUNT(*) FROM order_item_refunds WHERE created_at > NOW();
