-- How many sessions reached a product page?
SELECT COUNT( DISTINCT website_session_id) AS session_reached_product
FROM website_pageviews
WHERE pageview_url LIKE '%products%';

-- How many sessions reached the cart?
SELECT COUNT( DISTINCT website_session_id) AS session_reached_product
FROM website_pageviews
WHERE pageview_url LIKE '%cart%';

-- How many sessions reached checkout?
SELECT COUNT( DISTINCT website_session_id) AS session_reached_product
FROM website_pageviews
WHERE pageview_url LIKE '%checkout%';

-- How many sessions completed an order?
SELECT COUNT(website_session_id) AS sessions_with_order
FROM orders;

-- Where do users drop off the most?
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
       