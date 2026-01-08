USE maven_fuzzy_factory;

-- Enable Local Infile
SET GLOBAL local_infile = 1;

SHOW variables LIKE "local_infile";

-- Helps to avoid referential integrity
SET FOREIGN_KEY_CHECKS=0;

/* 
Load website_sessions data
- Skips header row
*/
LOAD DATA LOCAL INFILE 'C:\\project data\\maven fuzzy factory\\website_sessions.csv'
INTO TABLE website_sessions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    website_session_id,
    created_at,
    user_id,
    is_repeated_session,
    @utm_source,
    @utm_campaign,
    @utm_content,
	device_type,
    @http_referer
)
SET
  utm_source = NULLIF(@utm_source,''),
  utm_campaign = NULLIF(@utm_campaign,''),
  utm_content = NULLIF(@utm_content,''),
  http_referer = NULLIF(@http_referer,'');


/* 
Load website_pageviews data
- Skips header row
*/
LOAD DATA LOCAL INFILE 'C:\\project data\\maven fuzzy factory\\website_pageviews.csv'
INTO TABLE website_pageviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    website_pageview_id,
    @created_at,
    website_session_id,
    pageview_url
)
SET
  created_at = NULLIF(@created_at,'');


/* 
Load products data
- Skips header row
*/
LOAD DATA LOCAL INFILE 'C:\\project data\\maven fuzzy factory\\products.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    product_id,
    created_at,
    product_name
);

/* 
Load orders data
- Skips header row
*/
LOAD DATA LOCAL INFILE 'C:\\project data\\maven fuzzy factory\\orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    order_id,
    created_at,
    website_session_id,
    user_id,
    primary_product_id,
    items_purchased,
    price_usd,
    cogs_usd
);


/* 
Load order_items data
- Skips header row
*/
LOAD DATA LOCAL INFILE "C:\\project data\\maven fuzzy factory\\order_items.csv"
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
	order_item_id,
    created_at,
    order_id,
    product_id,
    is_primary_item,
    price_usd,
    cogs_usd
);


/* 
Load order_item_refunds data
- Skips header row
*/
LOAD DATA LOCAL INFILE "C:\\project data\\maven fuzzy factory\\order_item_refunds.csv"
INTO TABLE order_item_refunds
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
	order_item_refund_id,
    created_at,
    order_item_id,
    order_id,
    refund_amount_usd
);



SELECT COUNT(*) FROM website_sessions;
SELECT COUNT(*) FROM website_pageviews;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM order_item_refunds;
