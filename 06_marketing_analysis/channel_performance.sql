-- How many sessions come from each marketing channel?
SELECT COALESCE(utm_source,'direct') AS market_channel, -- null -> direct
       COUNT(website_session_id) as sessions
FROM website_sessions
GROUP BY COALESCE(utm_source,'direct');

-- How many orders does each channel generate?
SELECT COALESCE(utm_source,'direct') AS market_channel,
	   COUNT(order_id) AS orders
FROM (SELECT ws.utm_source,
			 o.order_id
	  FROM website_sessions ws
      LEFT JOIN orders o
		ON ws.website_session_id = o.website_session_id
	) t
GROUP BY COALESCE(utm_source,'direct');

-- What is the conversion rate by channel?
SELECT COALESCE(utm_source,'direct') AS market_channel,
	   COUNT(order_id) / COUNT(website_session_id) AS convertion_rate
FROM( SELECT ws.website_session_id,
             ws.utm_source,
             o.order_id
	   FROM website_sessions ws
       LEFT JOIN orders o 
		ON ws.website_session_id = o.website_session_id
	) t
GROUP BY COALESCE(utm_source,'direct');
             

-- How much revenue does each channel generate per session?
WITH session_revenue AS (
	SELECT ws.website_session_id,
           COALESCE(ws.utm_source,'direct') AS market_channel,
           o.price_usd
	FROM website_sessions ws
    LEFT JOIN orders o
		ON ws.website_session_id = o.website_session_id
)
SELECT market_channel,
       SUM(price_usd) / COUNT(DISTINCT website_session_id) AS revenue_per_session
FROM session_revenue
GROUP BY market_channel
ORDER BY revenue_per_session DESC;
