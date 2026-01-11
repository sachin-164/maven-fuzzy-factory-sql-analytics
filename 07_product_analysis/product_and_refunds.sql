-- Which products generate the most revenue?
SELECT p.product_name,
       SUM(oi.price_usd) AS total_revenue
FROM order_items oi
LEFT JOIN products p
	ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;
	
-- Which products sell the highest number of units?
SELECT p.product_name,
       COUNT(oi.order_item_id) AS units_sold
FROM products p
LEFT JOIN order_items oi
	ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY units_sold DESC;

-- Which products have the highest refund rates?
SELECT p.product_name,
       COUNT(r.order_item_id) / COUNT(oi.order_item_id) AS refund_rate
FROM order_items oi
JOIN products p
	ON oi.product_id = p.product_id
LEFT JOIN order_item_refunds r
	ON r.order_item_id = oi.order_item_id
GROUP BY p.product_name
ORDER BY refund_rate DESC;


-- How much total revenue is lost due to refunds?
SELECT SUM(refund_amount_usd) AS revenue_lost
FROM order_item_refunds;


