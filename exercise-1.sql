CREATE TABLE account (
   id INT AUTO_INCREMENT PRIMARY KEY,
   email VARCHAR(255),
   password VARCHAR(40),
   createdOn DATETIME,
   modifiedOn DATETIME
);

CREATE TABLE addressBook (
   id INT AUTO_INCREMENT PRIMARY KEY,
   accountID int,
   FOREIGN KEY (accountId) REFERENCES account(id),
   name VARCHAR(255),
   createdOn DATETIME,
   modifiedOn DATETIME
);

CREATE TABLE entry (
   id INT AUTO_INCREMENT PRIMARY KEY,
   addressBookId int,
   FOREIGN KEY (addressBookId) REFERENCES addressBook(id),
   firstName VARCHAR(255),
   lastName VARCHAR(255),
   birthday DATETIME,
   type ENUM ("phone", "address", "electronic-mail")
);

CREATE TABLE phone (
   id INT AUTO_INCREMENT PRIMARY KEY,
   entryId int,
   FOREIGN KEY (entryId) REFERENCES entry(id),
   type ENUM ("home", "work", "other"),
   subtype ENUM ("landline", "cellular", "fax"),
   content VARCHAR(255)
);

CREATE TABLE address (
   id INT AUTO_INCREMENT PRIMARY KEY,
   entryId int,
   FOREIGN KEY (entryId) REFERENCES entry(id),
   type ENUM ("home", "work", "other"),
   addressLine1 VARCHAR(255),
   addressLine2 VARCHAR(255),
   city VARCHAR(255),
   province VARCHAR(128),
   country VARCHAR(128),
   postalCode VARCHAR(10)
);

CREATE TABLE ElectronicMail (
   id INT AUTO_INCREMENT PRIMARY KEY,
   entryId int,
   FOREIGN KEY (entryId) REFERENCES entry(id),
   type ENUM ("home", "work", "other"),
   content VARCHAR(255)
);
