use maven_fuzzy_factory;

-- Creating Table1 website_sessions
-- Represents one website visit.
create table website_sessions(
	website_session_id INT PRIMARY KEY NOT NULL,
    created_at DATETIME NOT NULL,
    user_id INT,
    is_repeated_session TINYINT,
    utm_source VARCHAR(50),
    utm_campaign VARCHAR(50),
    utm_content VARCHAR(50),
    device_type VARCHAR(30),
    http_referer VARCHAR(255),
    INDEX idx_website_sessions_created_at (created_at)
);
    
-- Table2 website_pageview
-- Represents one page view inside a session.
CREATE TABLE website_pageviews(
    website_pageview_id INT PRIMARY KEY NOT NULL,
    created_at DATETIME NOT NULL,
    website_session_id INT NOT NULL,
    pageview_url VARCHAR(255),
    CONSTRAINT fk_pageviews_sessions
		FOREIGN KEY(website_session_id) 
        REFERENCES website_sessions(website_session_id) ,
	INDEX idx_pageviews_session_id (website_session_id),
    INDEX idx_pageviews_created_at (created_at)
);
        
-- Table3 orders
-- Represents one completed order.
CREATE TABLE orders(
	order_id INT PRIMARY KEY NOT NULL,
    created_at DATETIME NOT NULL,
    website_session_id INT NOT NULL,
    user_id INT,
    primary_product_id TINYINT,
    items_purchased TINYINT,
    price_usd DECIMAL(10,2) NOT NULL,
    cogs_usd DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_orders_sessions
		FOREIGN KEY(website_session_id)
        REFERENCES website_sessions(website_session_id),
	INDEX idx_orders_session_id (website_session_id),
    INDEX idx_orders_created_at (created_at),
    INDEX idx_orders_user_id (user_id)
);

-- Table4 products
-- Represents product catalog.
CREATE TABLE products(
	product_id INT PRIMARY KEY NOT NULL,
    created_at DATETIME NOT NULL,
    product_name VARCHAR(100),
    INDEX idx_products_created_at (created_at)
);
        
-- Table5 order_items
-- Represents products inside an order.
CREATE TABLE order_items(
	order_item_id INT PRIMARY KEY NOT NULL,
    created_at DATETIME NOT NULL,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    is_primary_item TINYINT NOT NULL,
    price_usd DECIMAL(10,2) NOT NULL,
    cogs_usd DECIMAL(10,2)NOT NULL,
    CONSTRAINT fk_items_order FOREIGN KEY(order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_items_product FOREIGN KEY(product_id) REFERENCES products(product_id),
    INDEX idx_items_order_id (order_id),
    INDEX idx_items_product_id(product_id)
);


-- Table 6 Order item refunds
-- Represents refunded items.
CREATE TABLE order_item_refunds(
	order_item_refund_id INT PRIMARY KEY NOT NULL,
    created_at DATETIME NOT NULL,
    order_item_id INT NOT NULL,
    order_id INT NOT NULL,
    refund_amount_usd DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_refunds_order_item
		FOREIGN KEY(order_item_id)	
        REFERENCES order_items(order_item_id),
	INDEX idx_refunds_item_id (order_item_id),
    INDEX idx_refunds_created_at (created_at)

);