-- How many total website sessions were generated during the analysis period?
SELECT COUNT(DISTINCT website_session_id) AS total_website_sessions
FROM website_sessions;

-- How many total orders were placed by users?
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM orders;

-- What is the total revenue generated from all orders?
SELECT SUM(price_usd) AS total_revenue
FROM order_items;

-- 4. What percentage of sessions converted into orders?
SELECT COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id) AS convertion_rate
FROM orders o
LEFT JOIN website_sessions ws 
	ON o.website_session_id = ws.website_session_id;
    
-- 5. What is the average order value (AOV)?
SELECT 
	SUM(price_usd) / COUNT(DISTINCT order_id) AS avg_order_value
FROM orders;

-- 6. How much revenue does each website session generate on average?
SELECT 
	SUM(o.price_usd) / COUNT(DISTINCT ws.website_session_id) AS revenue_per_session
FROM website_sessions ws
LEFT JOIN orders o
	ON ws.website_session_id = o.website_session_id;

