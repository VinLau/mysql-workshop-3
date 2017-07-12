DROP DATABASE IF EXISTS store;

CREATE DATABASE store;

USE store;

CREATE TABLE manufacturerLookUpTable (
   id INT AUTO_INCREMENT PRIMARY KEY  NOT NULL,
   manufacturerName VARCHAR(150)  NOT NULL
);

CREATE TABLE inventory (
   id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
   itemName VARCHAR(150) NOT NULL,
   priceCents INT NOT NULL,
   inStock INT NOT NULL,
   manufacturerID INT NOT NULL,
   FOREIGN KEY (manufacturerID) REFERENCES manufacturerLookUpTable(id)
);

CREATE TABLE customers (
   id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
   custName VARCHAR(150) NOT NULL,
   country VARCHAR(150) NOT NULL
);

CREATE TABLE invoices (
   id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
   customerID INT NOT NULL,
   FOREIGN KEY (customerID) REFERENCES customers(id),
   invoiceDATE TIMESTAMP NOT NULL,
   status ENUM("purchase", "refund", "pending") NOT NULL
);

CREATE TABLE soldProducts (
   id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
   invoiceID INT NOT NULL,
   FOREIGN KEY (invoiceID) REFERENCES invoices(id),
   inventoryID INT NOT NULL,
   FOREIGN KEY (inventoryID) REFERENCES inventory(id),
   quantity INT NOT NULL
);

INSERT INTO manufacturerLookUpTable
   (manufacturerName)
VALUES
   ("Komoko cars"),
   ("ACUS"),
   ("Pear Computers");

INSERT INTO inventory
   (itemName, priceCents, inStock, manufacturerID)
VALUES
   ("koko car 2000", 200000, 100, 1),
   ("koco car 1000", 10000, 50, 1),
   ("PC 1500", 100000, 250, 2),
   ("pearbook", 120000, 500, 3),
   ("ipear", 15000, 100, 3);

INSERT INTO customers
   (custName, country)
VALUES
   ("James Jeb", "Canada"),
   ("Fouzad Abi", "UAE"),
   ("Jacqueline Sergazri", "Greece"),
   ("Xie Xin Yun", "Singapore");

INSERT INTO invoices
   (invoiceDATE, customerID, status)
VALUES
   ("2010-05-10", 1, "purchase"),
   ("2011-08-12", 4, "purchase"),
   ("2014-06-30", 3, "purchase"),
   ("2013-02-15", 2, "purchase"),
   ("2015-10-20", 4, "pending"),
   ("2014-02-05", 1, "refund");

INSERT INTO soldProducts --NOTE: that not invoices were accounted for here... below just shown as example
   (invoiceID, inventoryID, quantity)
VALUES
   (2, 1, 2),
   (3, 2, 2),
   (4, 3, 3),
   (3, 1, 5),
   (1, 1, 1),
   (2, 1, 3),
   (6, 2, 3);

SELECT inventory.itemName, soldproducts.quantity, inventory.priceCents, soldproducts.quantity * inventory.priceCents AS total FROM soldproducts JOIN inventory ON soldproducts.inventoryid = inventory.id;

SELECT SUM(soldproducts.quantity * inventory.priceCents) FROM soldproducts JOIN inventory ON soldproducts.inventoryid = inventory.id;

SELECT AVG(soldproducts.quantity), inventory.itemName FROM soldproducts JOIN inventory ON soldproducts.inventoryid = inventory.id GROUP BY inventory.itemName ASC;

SELECT AVG(soldproducts.quantity), manufacturerLookUpTable.manufacturerName FROM soldproducts JOIN inventory ON soldproducts.inventoryid = inventory.id JOIN manufacturerLookUpTable ON manufacturerLookUpTable.id = inventory.manufacturerID GROUP BY manufacturerLookUpTable.manufacturerName;

SELECT * FROM invoices JOIN soldproducts ON soldproducts.invoiceID = invoices.id JOIN inventory ON soldproducts.inventoryid = inventory.id WHERE invoices.status = "refund";

SELECT manufacturerLookUpTable.manufacturerName, count(invoices.status) FROM invoices JOIN soldproducts ON soldproducts.invoiceID = invoices.id JOIN inventory ON soldproducts.inventoryid = inventory.id  JOIN manufacturerLookUpTable ON inventory.manufacturerID =  manufacturerLookUpTable.id WHERE invoices.status = "refund" GROUP BY manufacturerLookUpTable.manufacturerName;

SELECT * FROM inventory WHERE inStock < 0;

SELECT manufacturerLookUpTable.manufacturerName, count(soldProducts.quantity) FROM invoices JOIN soldproducts ON soldproducts.invoiceID = invoices.id JOIN inventory ON soldproducts.inventoryid = inventory.id  JOIN manufacturerLookUpTable ON inventory.manufacturerID =  manufacturerLookUpTable.id WHERE invoices.status = "purchase" GROUP BY manufacturerLookUpTable.manufacturerName;

SELECT count(country), country FROM customers group by country ORDER BY country="canada" DESC;
SELECT count(country) AS international FROM customers WHERE NOT country="canada";
SELECT count(country) AS national FROM customers WHERE country="canada";

SELECT SUM(soldproducts.quantity), inventory.instock, inventory.itemName FROM inventory JOIN soldproducts ON inventory.id = soldproducts.inventoryid JOIN invoices ON soldproducts.invoiceID = invoices.id WHERE invoiceDATE < "2017-07-12" AND status = "purchase" GROUP BY inventory.itemName;
