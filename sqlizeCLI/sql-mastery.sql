-- SELECT o.order_date, o.order_id, c.first_name, os.name
-- FROM orders o
-- JOIN customers c
-- 	ON o.customer_id = c.customer_id
-- LEFT JOIN shippers sh
-- 	ON o.shipper_id = sh.shipper_id
-- JOIN order_statuses os
-- 	ON o.status = os.order_status_id
-- ORDER BY os.name

-- INSERT INTO customers (first_name, last_name, birth_date, address, city, state)
-- 	VALUES ('Tuan', 'Tran', '1990-06-24', '120/30', 'Nha Trang', "KH")

-- LAST_INSERTED_ID()

-- CREATE TABLE invoices_archived AS
-- SELECT 
-- 	i.invoice_id,
-- 	i.invoice_total,
--     i.number,
--     c.name AS client,
--     i.payment_date,
--     i.payment_total
-- FROM invoices i
-- JOIN clients c
-- 	USING (client_id)
-- WHERE i.payment_date IS NOT NULL

-- s5-v1
-- SELECT
-- 	'H1 2019' AS date_range,
--     SUM(invoice_total) AS total_sales,
--     SUM(payment_total) AS total_payment,
--     SUM(invoice_total-payment_total) AS expected
-- FROM invoices
-- WHERE invoice_date BETWEEN '2019-01-01' AND '2019-06-30'
-- UNION
-- SELECT
-- 	'H2 2019' AS date_range,
--     SUM(invoice_total) AS total_sales,
--     SUM(payment_total) AS total_payment,
--     SUM(invoice_total-payment_total) AS expected
-- FROM invoices
-- WHERE invoice_date BETWEEN '2019-07-01' AND '2019-12-31'

-- s5-v2
-- SELECT 
-- 	date,
--     pm.name,
--     SUM(amount)
-- FROM payments p
-- JOIN payment_methods pm
-- 	ON p.payment_method = pm.payment_method_id
-- GROUP BY date, pm.name
-- ORDER BY date

-- s5-v3
-- SELECT 
--     client_id,
--     SUM(invoice_total) AS total_sales,
--     COUNT(*) AS no_of_invoice
-- FROM invoices
-- GROUP BY client_id
-- HAVING no_of_invoice > 5 AND total_sales > 500
--
-- SELECT 
--     customer_id,
--     first_name,city,state,
--     SUM(quantity*unit_price) AS total_spent
-- FROM customers c
-- JOIN orders o USING(customer_id)
-- JOIN order_items oi USING(order_id)
-- -- WHERE state='VA'
-- GROUP BY customer_id
-- HAVING total_spent>100

-- s5-v4
-- SELECT 
-- 	pm.name,
--     SUM(amount)
-- FROM payments p
-- JOIN payment_methods pm ON pm.payment_method_id=p.payment_method
-- GROUP BY pm.name WITH ROLLUP

-- s6-v2
-- SELECT *
-- FROM employees
-- WHERE salary > (SELECT
-- 	AVG(salary) AS avg_sal
-- FROM employees)

-- s6-v3
-- SELECT product_id, name
-- FROM products
-- WHERE product_id NOT IN (
-- 	SELECT DISTINCT product_id
-- 	FROM order_items
-- )

-- s6-v4
-- SELECT customer_id, first_name, last_name
-- FROM customers
-- WHERE customer_id IN  (SELECT  customer_id
-- 	FROM orders
-- 	WHERE order_id  IN (SELECT  order_id
-- 		FROM order_items
-- 		WHERE product_id=3
-- 	)
-- )

-- SELECT *
-- FROM customers
-- JOIN orders USING(customer_id)
-- JOIN order_items USING(order_id)
-- WHERE product_id=3

-- s6-v7
-- SELECT *
-- FROM invoices i
-- WHERE invoice_total > (
-- 	SELECT AVG(invoice_total)
-- 	FROM invoices
-- 	WHERE client_id = i.client_id
-- )

-- s6-v8
-- SELECT *
-- FROM products p
-- WHERE NOT EXISTS (
-- 	SELECT product_id
-- 	FROM order_items
--     WHERE product_id = p.product_id
-- )

-- s6-v9
-- SELECT 
-- 	invoice_id,
--     invoice_total,
--     (SELECT AVG(invoice_total) FROM invoices) AS avg
-- FROM invoices

-- SELECT 
-- 	invoice_id,
--     client_id, 
--     SUM(invoice_total) AStotal,
--     AVG(invoice_total) AS avg_of_1client, COUNT(*),
--     (SELECT AVG(invoice_total) FROM invoices) AS avg_all_client
--     , SUM(invoice_total) - (SELECT avg_all_client)
-- FROM invoices
-- GROUP BY client_id

-- s6-v9-v10
-- SELECT *
-- FROM (
-- 	SELECT
-- 		client_id,
-- 		name,
-- 		(SELECT 
-- 			SUM(invoice_total) 
-- 		FROM invoices 
-- 		WHERE client_id = c.client_id) AS total_sale
-- 		, (SELECT 
-- 			AVG(invoice_total) 
-- 		FROM invoices ) AS average,
-- 		(SELECT 
-- 			AVG(invoice_total) 
-- 		FROM invoices
-- 		WHERE client_id = c.client_id) AS avg_client
-- 	FROM clients c
-- ) AS sale_sum
-- WHERE total_sale IS NOT NULL

-- s7-v7
-- SELECT 
-- 	product_id, name, quantity_in_stock,
--     COUNT(*) AS num,
--     IF(COUNT(*) > 1, 'many','once')
-- FROM products
-- JOIN order_items
-- 	USING(product_id)
-- GROUP BY product_id

-- s7-v8
-- SELECT 
-- 	customer_id,
-- 	CONCAT(first_name, last_name),
--     points,
--     CASE
-- 		WHEN points >3000 THEN 'gold'
--         WHEN points >=2000 THEN 'silver'
--         ELSE '...'
-- 	END AS c_rank
-- FROM customers

-- s8-v1
-- CREATE OR REPLACE VIEW clients_balance AS
-- SELECT 
--     client_id,
-- 	name,
--     SUM(invoice_total) as total_pay,
--     SUM(payment_total) as total_paid,
--     SUM(invoice_total - payment_total) as balance
-- FROM clients
-- LEFT JOIN invoices
-- 	USING(client_id)
-- GROUP BY name

-- s9-v2
-- DROP PROCEDURE IF EXISTS get_invoices_with_balance

-- DELIMITER $$
-- CREATE PROCEDURE get_invoices_with_balance()
-- BEGIN
-- 	SELECT *
--     FROM invoices
--     WHERE invoice_total-payment_total > 0;
-- END $$
-- DELIMITER ;

-- s9-v51
-- DROP PROCEDURE IF EXISTS get_client_by_state

-- DELIMITER $$
-- CREATE PROCEDURE get_client_by_state(
-- 	state CHAR(2)
-- )
-- BEGIN
-- 	SELECT *
--     FROM clients c
--     WHERE c.state = state;
-- END $$
-- DELIMITER ;

-- s9-v52
-- DROP PROCEDURE IF EXISTS get_invoice_by_client

-- DELIMITER $$
-- CREATE PROCEDURE get_invoice_by_client(
-- 	client_id INT
-- )
-- BEGIN
-- 	IF client_id IS NULL THEN
-- 		SELECT * 
--         FROM invoices i;
-- 	ELSE
-- 		SELECT * 
--         FROM invoices i
-- 		WHERE i.client_id = client_id;
-- 	END IF;
-- END $$
-- DELIMITER ;

-- s9-v61
-- DROP PROCEDURE IF EXISTS get_invoice_by_client

-- DELIMITER $$
-- CREATE PROCEDURE get_invoice_by_client(
-- 	client_id INT
-- )
-- BEGIN
-- 		SELECT * 
--         FROM invoices i
-- 		WHERE i.client_id = IFNULL(client_id, i.client_id);
-- END $$
-- DELIMITER ;

-- s9-v62
-- DROP PROCEDURE IF EXISTS get_payments

-- DELIMITER $$
-- CREATE PROCEDURE get_payments(
-- 	client_id INT,
--     payment_medthod_id TINYINT
-- )
-- BEGIN
-- 		SELECT * 
--         FROM payments p
-- 		WHERE p.client_id = IFNULL(client_id, p.client_id)
-- 				AND p.payment_method = IFNULL(payment_medthod_id, p.payment_method);
-- END $$
-- DELIMITER ;

-- s9-v7
-- DROP PROCEDURE IF EXISTS make_payment

-- DELIMITER $$
-- CREATE PROCEDURE make_payment(
-- 	invoice_id INT,
--     amount DECIMAL(9,2),
--     payment_date DATE
-- )
-- BEGIN
-- 	IF amount < 0 THEN
-- 		SIGNAL SQLSTATE '22003' SET MESSAGE_TEXT = 'Invalid payment amount';
--     END IF;
--     
-- 	UPDATE invoices i
-- 	SET
-- 		i.payment_total = amount,
-- 		i.payment_date = payment_date
-- 	WHERE i.invoice_id = invoice_id;
-- END $$
-- DELIMITER ;

-- s9-v8
-- DROP PROCEDURE IF EXISTS get_unpaid_invoice_4client

-- DELIMITER $$
-- CREATE PROCEDURE get_unpaid_invoice_4client(
-- 	client_id INT,
--     OUT invoice_count INT,
--     OUT invoices_total DECIMAL(9,2)
-- )
-- BEGIN
--     SELECT COUNT(*), SUM(invoice_total)
-- 	INTO invoice_count, invoices_total
-- 	FROM invoices i
--     WHERE i.client_id = client_id
-- 		AND i.payment_total = 0;
-- END $$
-- DELIMITER ;

-- s9-v9
-- DROP PROCEDURE IF EXISTS get_risk_factor

-- DELIMITER $$
-- CREATE PROCEDURE get_risk_factor()
-- BEGIN
-- 	DECLARE invoice_count INT DEFAULT 0;
--     DECLARE invoices_total DECIMAL(9, 2);
--     DECLARE risk_factor DECIMAL(9, 2);

--     SELECT COUNT(*), SUM(invoice_total)
-- 	INTO invoice_count, invoices_total
-- 	FROM invoices i;
--     
--     SET risk_factor = invoices_total / invoice_count * 5;
--     
--     SELECT risk_factor;
-- END $$
-- DELIMITER ;

-- s9-v10
-- DROP FUNCTION IF EXISTS get_risk_factor_by_client;

-- DELIMITER $$
-- CREATE FUNCTION get_risk_factor_by_client(
-- 	client_id INT
-- )
-- RETURNS INTEGER
-- READS SQL DATA
-- BEGIN
-- 	DECLARE invoice_count INT;
--     DECLARE invoices_total DECIMAL(9, 2);
--     DECLARE risk_factor DECIMAL(9, 2) DEFAULT 0;

--     SELECT COUNT(*), SUM(invoice_total)
-- 	INTO invoice_count, invoices_total
-- 	FROM invoices i
--     WHERE i.client_id = client_id;
--     
--     SET risk_factor = invoices_total / invoice_count * 5;
--     -- RETURN risk_factor;
--     RETURN IFNULL(risk_factor, 0);
-- END $$
-- DELIMITER ;

-- s10-v1.1
-- DELIMITER $$
-- DROP TRIGGER IF EXISTS payments_after_insert;

-- CREATE TRIGGER payments_after_insert
-- 	AFTER INSERT ON payments
-- 	FOR EACH ROW
-- BEGIN
-- 	UPDATE invoices
-- 	SET payment_total = payment_total + NEW.amount
--     WHERE invoice_id = NEW.invoice_id;
--     
--     INSERT INTO payments_audit
--     VALUES(NEW.payment_id, NEW.date, NEW.amount, 'Insert', NOW());
-- END $$
-- DELIMITER ;

-- s10-v1.2
-- DELIMITER $$
-- DROP TRIGGER IF EXISTS payments_after_delete;

-- CREATE TRIGGER payments_after_delete
-- 	AFTER DELETE ON payments
-- 	FOR EACH ROW
-- BEGIN
-- 	UPDATE invoices
-- 	SET payment_total = payment_total - OLD.amount
--     WHERE invoice_id = OLD.invoice_id;
--     
--     INSERT INTO payments_audit
--     VALUES(OLD.payment_id, OLD.date, OLD.amount, 'DELETE', NOW());
-- END $$
-- DELIMITER ;

-- s10-v5
-- DELIMITER $$
-- DROP EVENT IF EXISTS yearly_delete_stale_audit_rows;

-- CREATE EVENT yearly_delete_stale_audit_rows
-- 	ON SCHEDULE EVERY 1 YEAR STARTS '2020-01-01' ENDS '2029-01-01'
-- DO BEGIN
-- 	DELETE FROM payments_audit
--     WHERE action_date < NOW() - INTERVAL 1 YEAR;
-- END $$
-- DELIMITER ;

-- s11-v2
-- START TRANSACTION;

-- INSERT INTO orders (customer_id, order_date, status)
-- VALUES(1, DATE(NOW()), 2);

-- INSERT INTO order_items
-- VALUES
-- 	(LAST_INSERT_ID(), 3, 1, 3.1),
-- 	(LAST_INSERT_ID(), 4, 2, 4.1);

-- COMMIT;


-- s14-v3
-- EXPLAIN SELECT customer_id FROM customers WHERE points > 1000

-- CREATE INDEX idx_point ON customers (points)

-- SHOW INDEXES IN customers

-- s14-v5
-- CREATE INDEX idx_last_name ON customers (last_name(5))

-- SELECT 
-- 	COUNT(DISTINCT LEFT(last_name, 1)),
--     COUNT(DISTINCT LEFT(last_name, 5))
-- FROM customers

-- s14-v6
-- CREATE FULLTEXT INDEX idx_title_body ON posts (title, body)

-- SELECT *, MATCH(title, body) AGAINST ('react redux') FROM posts
-- WHERE MATCH(title, body) AGAINST ('react -redux +form' IN BOOLEAN MODE)

-- s14-v6
-- CREATE INDEX idx_state_points ON customers (state, points);

-- EXPLAIN SELECT customer_id FROM customers WHERE state = 'CA' AND points > 1000

