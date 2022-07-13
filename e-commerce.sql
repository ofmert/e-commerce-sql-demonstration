--DROP TABLE transactions;
--DROP TABLE productCatalog;

-- Here I create the transactions table
CREATE TABLE transactions (
    productID INT PRIMARY KEY,
    reportDATE TIMESTAMP(6),
    lineQuantity INT,
    salesValue NUMERIC(18,0)
);

-- Here I create the productCatalog table
CREATE TABLE productCatalog (
    productID INT PRIMARY KEY,
    productType VARCHAR(255),
    productColor VARCHAR(255)
);

-- Here I insert some transactions into the transactions table
INSERT INTO transactions VALUES(1, '2022-01-01 10:00:00', 1, 30);
INSERT INTO transactions VALUES(2, '2022-01-02 10:00:00', 2, 40);
INSERT INTO transactions VALUES(3, '2022-01-03 10:00:00', 3, 80);
INSERT INTO transactions VALUES(4, '2022-02-01 10:00:00', 5, 400);
INSERT INTO transactions VALUES(5, '2022-02-01 10:00:00', 3, 250);
INSERT INTO transactions VALUES(6, '2022-02-01 10:00:00', 2, 150);
INSERT INTO transactions VALUES(7, '2022-02-01 10:00:00', 10, 3000);
INSERT INTO transactions VALUES(8, '2022-02-01 10:00:00', 1, 280);
INSERT INTO transactions VALUES(9, '2022-02-17 10:00:00', 1, 50);
INSERT INTO transactions VALUES(10, '2022-04-01 10:00:00', 3, 150);
INSERT INTO transactions VALUES(11, '2022-04-03 10:00:00', 2, 100);
INSERT INTO transactions VALUES(12, '2022-04-04 10:00:00', 5, 250);
INSERT INTO transactions VALUES(13, '2022-04-05 10:00:00', 6, 480);
INSERT INTO transactions VALUES(14, '2022-04-06 10:00:00', 7, 550);
INSERT INTO transactions VALUES(15, '2022-04-07 10:00:00', 3, 240);
INSERT INTO transactions VALUES(16, '2022-04-08 10:00:00', 9, 4800);
INSERT INTO transactions VALUES(17, '2022-04-09 10:00:00', 3, 640);
INSERT INTO transactions VALUES(18, '2022-04-10 10:00:00', 1, 200);
INSERT INTO transactions VALUES(19, '2022-04-11 10:00:00', 4, 350);
INSERT INTO transactions VALUES(20, '2022-04-11 10:00:00', 3, 90);
INSERT INTO transactions VALUES(21, '2022-04-11 10:00:00', 2, 50);

-- Checking if everything has been inserted correctly
SELECT * FROM transactions;

-- Here I insert some products into the productCatalog table
INSERT INTO productCatalog VALUES(1, 'Handbag', 'Green');
INSERT INTO productCatalog VALUES(2, 'Handbag', 'Yellow');
INSERT INTO productCatalog VALUES(3, 'Handbag', 'Blue');
INSERT INTO productCatalog VALUES(4, 'Shoe', 'Brown');
INSERT INTO productCatalog VALUES(5, 'Shoe', 'Black');
INSERT INTO productCatalog VALUES(6, 'Shoe', 'Navy Blue');
INSERT INTO productCatalog VALUES(7, 'Jacket', 'Yellow');
INSERT INTO productCatalog VALUES(8, 'Jacket', 'Purple');
INSERT INTO productCatalog VALUES(9, 'T-shirt', 'Black');
INSERT INTO productCatalog VALUES(10, 'T-shirt', 'Red');
INSERT INTO productCatalog VALUES(11, 'T-shirt', 'Green');
INSERT INTO productCatalog VALUES(12, 'T-shirt', 'Blue');
INSERT INTO productCatalog VALUES(13, 'Long sleeve', 'Multicolor');
INSERT INTO productCatalog VALUES(14, 'Long sleeve', 'Red');
INSERT INTO productCatalog VALUES(15, 'Long sleeve', 'Brown');
INSERT INTO productCatalog VALUES(16, 'Necklace', 'Gold');
INSERT INTO productCatalog VALUES(17, 'Necklace', 'Silver');
INSERT INTO productCatalog VALUES(18, 'Necklace', 'Bronze');
INSERT INTO productCatalog VALUES(19, 'Bracelet', 'Black');
INSERT INTO productCatalog VALUES(20, 'Earring', 'Purple');
INSERT INTO productCatalog VALUES(21, 'Nose ring', 'Silver');

-- Checking if everything has been inserted correctly
SELECT * FROM productCatalog;

-- Show variables like "sql_mode";
SET sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- Below I answer some example questions regarding the transactions and the productCatalog tables.

-- What is the total items sold per product type per week?
SELECT sum(transactions.lineQuantity) as TotalQuantity, productCatalog.productType, WEEK(reportDate) as weekDate
FROM transactions
JOIN productCatalog
ON transactions.productID = productCatalog.productID
GROUP BY productCatalog.productType, weekDate;

-- What is the average price of all sold products per product type?
SELECT productCatalog.productType, transactions.salesValue, (sum(transactions.salesValue) / sum(transactions.lineQuantity)) as avg_item_price
FROM transactions
JOIN productCatalog
ON transactions.productID = productCatalog.productID
GROUP BY productCatalog.productType;

-- What is the most sold color of the productType 'T-shirt'?
SELECT productCatalog.productType, productCatalog.productColor, transactions.lineQuantity
FROM transactions
JOIN productCatalog
ON transactions.productID = productCatalog.productID
WHERE productCatalog.productType = 'T-shirt'
ORDER BY transactions.lineQuantity DESC
LIMIT 1;

-- Which days have more than 8 items sold?
SELECT reportDate, SUM(transactions.lineQuantity) as sum_quantity_per_day
FROM transactions
JOIN productCatalog
ON transactions.productID = productCatalog.productID
GROUP BY reportDate
HAVING SUM(transactions.lineQuantity) > 8;
