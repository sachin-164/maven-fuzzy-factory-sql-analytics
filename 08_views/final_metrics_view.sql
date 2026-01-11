/*Core Business KPIs */
CREATE OR REPLACE VIEW core_kpis AS
SELECT
    COUNT(DISTINCT ws.website_session_id) AS total_sessions,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.price_usd) AS total_revenue,
    COUNT(DISTINCT o.order_id) / COUNT(DISTINCT ws.website_session_id) AS conversion_rate,
    SUM(o.price_usd) / COUNT(DISTINCT o.order_id) AS average_order_value,
    SUM(o.price_usd) / COUNT(DISTINCT ws.website_session_id) AS revenue_per_session
FROM website_sessions ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id;
    
SELECT*FROM core_kpis;

-- Funnel Performance View 
CREATE OR REPLACE VIEW funnel_performance AS
WITH funnel AS (
	SELECT 
		COUNT(DISTINCT ws.website_session_id) AS total_sessions,
        COUNT(DISTINCT CASE WHEN wp.pageview_url LIKE '%products%' THEN ws.website_session_id END) AS product_sessions,
        COUNT(DISTINCT CASE WHEN wp.pageview_url LIKE '%cart%' THEN ws.website_session_id END) AS cart_sessions,
        COUNT(DISTINCT CASE WHEN wp.pageview_url LIKE '%checkout%' THEN ws.website_session_id END) AS checkout_sessions,
        COUNT(DISTINCT o.website_session_id) AS order_sessions
	FROM website_sessions ws
    LEFT JOIN website_pageviews wp
		ON ws.website_session_id = wp.website_session_id
	LEFT JOIN orders o
		ON ws.website_session_id = o.website_session_id
)
SELECT total_sessions,
	   product_sessions,
       cart_sessions,
       checkout_sessions,
       order_sessions,

       (product_sessions / total_sessions) AS pct_reached_products,
       (cart_sessions / product_sessions) AS pct_product_to_cart,
       (checkout_sessions / cart_sessions) AS pct_cart_to_checkout,
       (order_sessions / checkout_sessions) AS pct_checkout_to_order
FROM funnel;

SELECT * FROM funnel_performance;


-- Channel Performance View 
CREATE OR REPLACE VIEW channel_performance AS
WITH session_revenue AS (
    SELECT
        ws.website_session_id,
        COALESCE(ws.utm_source, 'direct') AS marketing_channel,
        o.price_usd
    FROM website_sessions ws
    LEFT JOIN orders o
        ON ws.website_session_id = o.website_session_id
)
SELECT
    marketing_channel,
    COUNT(DISTINCT website_session_id) AS sessions,
    COUNT(price_usd) AS orders,
    COUNT(price_usd) / COUNT(DISTINCT website_session_id) AS conversion_rate,
    SUM(price_usd) / COUNT(DISTINCT website_session_id) AS revenue_per_session
FROM session_revenue
GROUP BY marketing_channel;

SELECT * FROM channel_performance;


-- Product and Refund Performance View */
CREATE OR REPLACE VIEW product_performance AS
SELECT
    p.product_name,
    COUNT(oi.order_item_id) AS units_sold,
    SUM(oi.price_usd) AS product_revenue,
    COUNT(r.order_item_id) / COUNT(oi.order_item_id) AS refund_rate
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN order_item_refunds r
    ON oi.order_item_id = r.order_item_id
GROUP BY p.product_name;

SELECT * FROM product_performance;
       
       

