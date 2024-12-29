DROP DATABASE IF EXISTS ShopApp;
CREATE DATABASE ShopApp;

use ShopAPP;

-- Create Tables
DROP TABLE IF EXISTS Product_Group_Update_Log;
DROP TABLE IF EXISTS [Message];
DROP TABLE IF EXISTS [Product_Address];
DROP TABLE IF EXISTS [User_Phone_Number];
DROP TABLE IF EXISTS [User_Address];
DROP TABLE IF EXISTS [User];
DROP TABLE IF EXISTS [User_Transactions];
DROP TABLE IF EXISTS [Product];
DROP TABLE IF EXISTS [Product_Group];


CREATE TABLE [User] (
  id INT IDENTITY(1,1) NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  username VARCHAR(50) NOT NULL UNIQUE,
  national_code VARCHAR(10) ,
  [password] CHAR(128) NOT NULL,
  email VARCHAR(100) NOT NULL,
  budget int not null default 500,
  create_date DATETIME NOT NULL,
  last_modify DATETIME NOT NULL,
  delete_date DATETIME,
  PRIMARY KEY (id),
  CONSTRAINT CK_NationalCodeLength CHECK (LEN(national_code) <= 10)
);

CREATE TABLE User_Address (
  id INT IDENTITY(1,1) NOT NULL,
  user_id INT NOT NULL,
  country VARCHAR(20) NOT NULL,
  state VARCHAR(20) NOT NULL,
  city VARCHAR(20) NOT NULL,
  address TEXT COLLATE Latin1_General_CI_AI NOT NULL ,
  postal_code VARCHAR(20),
  telephone VARCHAR(20),
  create_date DATETIME NOT NULL,
  last_modify DATETIME NOT NULL,
  delete_date DATETIME,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES [User] (id)
);

CREATE TABLE User_Phone_Number (
  id INT IDENTITY(1,1) NOT NULL,
  user_id INT NOT NULL,
  phone VARCHAR(20) NOT NULL,
  create_date DATETIME NOT NULL,
  last_modify DATETIME NOT NULL,
  delete_date DATETIME,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES [User] (id)
);

CREATE TABLE Product_Group (
  id INT IDENTITY(1,1) NOT NULL,
  title VARCHAR(50) NOT NULL,
  description TEXT COLLATE Latin1_General_CI_AI NOT NULL ,
  create_date DATETIME NOT NULL,
  last_modify DATETIME NOT NULL,
  delete_date DATETIME,
  PRIMARY KEY (id)
);


CREATE TABLE Product (
  id INT IDENTITY(1,1) NOT NULL,
  user_id INT NOT NULL,
  title VARCHAR(70) NOT NULL,
  description TEXT COLLATE Latin1_General_CI_AI NOT NULL,
  group_id INT NOT NULL,
  price DECIMAL(20,2) CHECK (price >= 0),
  create_date DATETIME NOT NULL,
  last_modify DATETIME NOT NULL,
  delete_date DATETIME,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES [User] (id),
  FOREIGN KEY (group_id) REFERENCES Product_Group (id)
);

--ALTER TABLE Product
--ADD CONSTRAINT price_not_negative CHECK (price >= 0);

CREATE TABLE Product_Address (
  id INT IDENTITY(1,1) NOT NULL,
  product_id INT NOT NULL,
  address_id INT NOT NULL,
  delete_date DATETIME,
  PRIMARY KEY (id),
  FOREIGN KEY (product_id) REFERENCES Product (id),
  FOREIGN KEY (address_id) REFERENCES User_Address (id)
);

CREATE TABLE [Message] (
  id INT IDENTITY(1,1) NOT NULL,
  user_id_1 INT NOT NULL,
  user_id_2 INT NOT NULL,
  product_id INT NOT NULL,
  message TEXT COLLATE Latin1_General_CI_AI  NOT NULL,
  create_date DATETIME NOT NULL,
  last_modify DATETIME NOT NULL,
  delete_date DATETIME,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id_1) REFERENCES [User] (id),
  FOREIGN KEY (user_id_2) REFERENCES [User] (id),
  FOREIGN KEY (product_id) REFERENCES Product (id)
);

CREATE TABLE Product_Group_Update_Log (
    id INT IDENTITY(1,1) NOT NULL,
    group_id INT NOT NULL,
    average_price DECIMAL(20, 2) NOT NULL,
    update_date DATETIME NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (group_id) REFERENCES Product_Group (id)
);


create table User_Transactions(
    user_id int,
    product_id int ,
    tdate datetime not null,
    PRIMARY KEY(user_id,product_id,tdate),
    FOREIGN KEY(user_id) REFERENCES [User](id),
    FOREIGN KEY(product_id) REFERENCES Product(id)
)

-- Add data samples 

INSERT INTO [User] (first_name, last_name, username, national_code, [password], email, create_date, last_modify, delete_date)
VALUES ('Yasin', 'Karbasian', 'yasinkarbasian', '5042819266',
'd404559f602eab6fd602ac7680dacbfaadd13630335e951f097af3900e9de176b6db28512f2e000b9d04fba5133e8b1c6e8df59db3a8ab9d60be4b97cc9e81db',
'yasinkarbasian@email.com', '2023-10-04', '2023-10-04', NULL);

INSERT INTO [User] (first_name, last_name, username, national_code, [password], email, create_date, last_modify, delete_date)
VALUES ('Mostafa', 'Derispour', 'mostafaderispour', '6286710817',
'3627909a29c31381a071ec27f7c9ca97726182aed29a7ddd2e54353322cfb30abb9e3a6df2ac2c20fe23436311d678564d0c8d305930575f60e2d3d048184d79',
'mostafaderispour@email.com', '2023-10-04', '2023-10-04', NULL);

INSERT INTO [User] (first_name, last_name, username, national_code, [password], email, create_date, last_modify, delete_date)
VALUES ('Amin', 'Ghasemi', 'aminghasemi', '4887763727',
'bbe96aa2ce1149882f168249a4542c8cc3d2972945d25bddeb4e37f8353896c50ef84e69e91d8ecdc0e45bd6e025cee994365f7dc31d92d7411ab4da53f61c59',
'aminghasemi@email.com', '2023-10-04', '2023-10-04', NULL);

-- select * from [User];

INSERT INTO User_Address (user_id, country, state, city, address, postal_code, telephone, create_date, last_modify, delete_date)
VALUES (1, 'Iran', 'Esfahan', 'Esfahan', '123 Street', '94101', '555-123-4567', '2023-10-04', '2023-10-04', NULL);

INSERT INTO User_Address (user_id, country, state, city, address, postal_code, telephone, create_date, last_modify, delete_date)
VALUES (2, 'Iran', 'Esfahan', 'Esfahan', '456 Street', '75001', '01-45-67-89-10', '2023-10-04', '2023-10-04', NULL);

INSERT INTO User_Address (user_id, country, state, city, address, postal_code, telephone, create_date, last_modify, delete_date)
VALUES (3, 'Iran', 'Esfahan', 'Esfahan', '789 Street', '95401', '416-555-5678', '2023-10-04', '2023-10-04', NULL);

-- select * from [User_Address];

INSERT INTO User_Phone_Number (user_id, phone, create_date, last_modify, delete_date)
VALUES (1, '09134567878', '2023-10-04', '2023-10-04', NULL);

INSERT INTO User_Phone_Number (user_id, phone, create_date, last_modify, delete_date)
VALUES (2, '09134567875', '2023-10-04', '2023-10-04', NULL);

INSERT INTO User_Phone_Number (user_id, phone, create_date, last_modify, delete_date)
VALUES (3, '09134567871', '2023-10-04', '2023-10-04', NULL);

-- select * from User_Phone_Number;

INSERT INTO Product_Group (title, description, create_date, last_modify, delete_date)
VALUES ('Electronics', 'Electronic products', '2023-10-04', '2023-10-04', NULL);

INSERT INTO Product_Group (title, description, create_date, last_modify, delete_date)
VALUES ('Clothing', 'Clothing and accessories', '2023-10-04', '2023-10-04', NULL);

INSERT INTO Product_Group (title, description, create_date, last_modify, delete_date)
VALUES ('Home Goods', 'Home décor and furnishings', '2023-10-04', '2023-10-04', NULL);


-- select * from Product_Group;

INSERT INTO Product (user_id, title, description, group_id, price, create_date, last_modify, delete_date)
VALUES (1, 'Smartwatch', 'A great smartwatch from Yasin Karbasian', 1, 100.00, '2023-10-04', '2023-10-04', NULL);

INSERT INTO Product (user_id, title, description, group_id, price, create_date, last_modify, delete_date)
VALUES (2, 'Shirt', 'A beautiful shirt from Mostafa Derispour', 2, 50.00, '2023-10-04', '2023-10-04', NULL);

INSERT INTO Product (user_id, title, description, group_id, price, create_date, last_modify, delete_date)
VALUES (3, 'Coffee Table', 'A stylish coffee table from Amin Ghasemi', 3, 100.00, '2023-10-04', '2023-10-04', NULL);


-- select * from Product;

INSERT INTO Product_Address (product_id, address_id, delete_date)
VALUES (1,1, NULL);

INSERT INTO Product_Address (product_id, address_id, delete_date)
VALUES (2,2, NULL);

INSERT INTO Product_Address (product_id, address_id, delete_date)
VALUES (3,3, NULL);

-- select * from Product_Address;

INSERT INTO Message (user_id_1, user_id_2, product_id, message, create_date, last_modify, delete_date)
VALUES (1,2,2, 'Hi Mostafa, I really like your shirt!', '2023-10-04', '2023-10-04', NULL);

INSERT INTO Message (user_id_1, user_id_2, product_id, message, create_date, last_modify, delete_date)
VALUES (2,3,3, 'I love your coffee table, Amin!', '2023-10-04', '2023-10-04', NULL);

INSERT INTO Message (user_id_1, user_id_2, product_id, message, create_date, last_modify, delete_date)
VALUES (3,1,1, 'I love your smartwatch, Yasin!', '2023-10-04', '2023-10-04', NULL);

-- select * from Message;


-- Functions
DROP FUNCTION IF EXISTS GetProductMessages;
CREATE  FUNCTION GetProductMessages
(
    @ProductId INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM Message
    WHERE product_id = @ProductId
);

DROP FUNCTION IF EXISTS TotalProductPriceOfUser;
CREATE FUNCTION TotalProductPriceOfUser
(
    @UserId INT
)
RETURNS DECIMAL(20, 2)
AS
BEGIN
    DECLARE @TotalPrice DECIMAL(20, 2);

    SELECT @TotalPrice = SUM(price)
    FROM Product
    WHERE user_id = @UserId AND delete_date IS NULL;

    RETURN ISNULL(@TotalPrice, 0);
END;

DROP FUNCTION IF EXISTS IsProductGroupActive;
CREATE FUNCTION IsProductGroupActive
(
    @GroupId INT
)
RETURNS BIT
AS
BEGIN
    DECLARE @IsActive BIT;

    SELECT @IsActive = CASE WHEN delete_date IS NULL THEN 1 ELSE 0 END
    FROM Product_Group
    WHERE id = @GroupId;

    RETURN @IsActive;
END;

DROP FUNCTION IF EXISTS CheckNationalCode;
CREATE FUNCTION CheckNationalCode(@nationalCode NVARCHAR(MAX))
RETURNS BIT
AS
BEGIN
    DECLARE @isValid BIT;

    -- بررسی طول کد ملی
    IF LEN(@nationalCode) > 10 OR LEN(@nationalCode) < 8 
    BEGIN
        SET @isValid = 0;
    END
    ELSE  
    BEGIN
    SET @nationalCode = RIGHT('00' + @nationalCode, 10);
        -- محاسبه مجموع مراحل یک تا 10
        DECLARE @sum INT = 0;
        DECLARE @i INT = 1;

        WHILE @i <= 9
        BEGIN
            SET @sum = @sum + CAST(SUBSTRING(@nationalCode, @i, 1) AS INT) * (11-@i);
            SET @i = @i + 1;
        END;

        -- محاسبه باقیمانده و رقم کنترل
        DECLARE @remainder INT = @sum % 11;
        DECLARE @controlDigit INT;

        -- تعیین مقدار رقم کنترل
        IF @remainder < 2
            SET @controlDigit = @remainder;
        ELSE
            SET @controlDigit = 11 - @remainder;

        -- تعیین نتیجه بر اساس رقم کنترل
        IF @controlDigit = CAST(SUBSTRING(@nationalCode, 10, 1) AS INT)
            SET @isValid = 1; -- کد ملی معتبر
        ELSE
            SET @isValid = 0; -- کد ملی نامعتبر
    END

    RETURN @isValid;
END;

-- views
DROP VIEW IF EXISTS User_Profile_View;
CREATE VIEW User_Profile_View AS
SELECT
    u.id AS user_id,
    u.first_name,
    u.last_name,
    u.username,
    u.email,
    ua.country,
    ua.state,
    ua.city,
    ua.address,
    ua.postal_code,
    upn.phone
FROM [User] u
JOIN User_Address ua ON u.id = ua.user_id
JOIN User_Phone_Number upn ON u.id = upn.user_id;

-- product details 
DROP VIEW IF EXISTS Product_Details_View;
CREATE VIEW Product_Details_View AS
SELECT
    p.id AS product_id,
    p.title AS product_title,
    p.description AS product_description,
    pg.title AS group_title,
    u.id AS user_id,
    u.username AS user_username,
    p.price
FROM Product p
JOIN Product_Group pg ON p.group_id = pg.id
JOIN [User] u ON p.user_id = u.id;

-- User_Message_History_View
DROP VIEW IF EXISTS User_Message_History_View;
CREATE VIEW User_Message_History_View AS
SELECT
    m.id AS message_id,
    u1.username AS sender_username,
    u2.username AS receiver_username,
    p.title AS related_product,
    m.message,
    m.create_date
FROM Message m
JOIN [User] u1 ON m.user_id_1 = u1.id
JOIN [User] u2 ON m.user_id_2 = u2.id
JOIN Product p ON m.product_id = p.id;

-- User_Product_Summary_View
DROP VIEW IF EXISTS User_Product_Summary_View;
CREATE VIEW User_Product_Summary_View AS
SELECT
    u.id AS user_id,
    u.username,
    COUNT(p.id) AS total_products,
    AVG(p.price) AS average_price,
    MAX(p.create_date) AS latest_product_date
FROM [User] u
LEFT JOIN Product p ON u.id = p.user_id
GROUP BY u.id, u.username;

-- Active_Products_View
DROP VIEW IF EXISTS Active_Products_View;
CREATE VIEW Active_Products_View AS
SELECT
    p.id AS product_id,
    p.title,
    u.username AS user_username,
    pg.title AS group_title,
    p.price
FROM Product p
JOIN [User] u ON p.user_id = u.id
JOIN Product_Group pg ON p.group_id = pg.id
WHERE p.delete_date IS NULL;

-- Product_Message_Count_View
DROP VIEW IF EXISTS Product_Message_Count_View;
CREATE VIEW Product_Message_Count_View AS
SELECT
    p.id AS product_id,
    p.title AS product_title,
    COUNT(m.id) AS message_count
FROM Product p
LEFT JOIN Message m ON p.id = m.product_id
GROUP BY p.id, p.title;

-- Trigger
DROP TRIGGER IF EXISTS tr_InsteadOfInsertUser;
CREATE TRIGGER tr_InsteadOfInsertUser
ON [User]
INSTEAD OF INSERT
AS
BEGIN
  IF NOT EXISTS (
        SELECT 1
        FROM inserted i
        WHERE dbo.CheckNationalCode(i.national_code) = 1
    )
    BEGIN
		PRINT('invalid national code')
        -- If the national code is not valid, do not allow the insertion
        RETURN;
    END;
    INSERT INTO [User] (
      first_name,
      last_name,
      username,
      national_code,
      password,
      email,
      create_date,
      last_modify,
      delete_date
    )
    SELECT
      first_name,
      last_name,
      username,
      national_code,
      password,
      email,
      create_date,
      last_modify,
      delete_date
    FROM inserted;
END;

DROP TRIGGER IF EXISTS UpdateMessageDeleteDate;
CREATE TRIGGER UpdateMessageDeleteDate
ON Product
AFTER UPDATE
AS
BEGIN
    IF UPDATE(delete_date)
    BEGIN
        UPDATE [Message]
        SET delete_date = GETDATE()
        WHERE product_id IN (SELECT id FROM deleted)
        AND delete_date IS NULL;
    END
END;

DROP TRIGGER IF EXISTS UpdateUserLastModify;
CREATE TRIGGER UpdateUserLastModify
ON [User]
AFTER UPDATE
AS
BEGIN
     UPDATE [User]
	 SET last_modify = GETDATE()
	 FROM inserted
	WHERE [User].id = inserted.id;
END;

DROP TRIGGER IF EXISTS PreventProductInsertOnDeletedGroup;
CREATE TRIGGER PreventProductInsertOnDeletedGroup
ON Product
INSTEAD OF INSERT
AS
BEGIN
    BEGIN
        IF EXISTS (
            SELECT 1
            FROM inserted I
            INNER JOIN Product_Group PG ON I.group_id = PG.id
            WHERE PG.delete_date IS NOT NULL
        )
        BEGIN
            Print('Cannot insert a product for a deleted product group.');
        END
        ELSE
        BEGIN
            INSERT INTO Product (user_id, title, description, group_id, price, create_date, last_modify)
            SELECT user_id, title, description, group_id, price, create_date, last_modify
            FROM inserted;
        END;
    END;
END;


DROP TRIGGER IF EXISTS UpdateProductDeleteDateOnGroupDelete;
CREATE TRIGGER UpdateProductDeleteDateOnGroupDelete
ON Product_Group
AFTER UPDATE
AS
BEGIN
    IF UPDATE(delete_date)
    BEGIN
        UPDATE Product
        SET delete_date = GETDATE()
        FROM Product P
        INNER JOIN inserted I ON P.group_id = I.id
        WHERE P.delete_date IS NULL;
    END;
END;

-- stored procedure
DROP PROCEDURE IF EXISTS UpdateProductGroupDescription;
CREATE PROCEDURE UpdateProductGroupDescription
    @ProductGroupId INT
AS
BEGIN
    DECLARE @AveragePrice DECIMAL(20, 2);

    -- Calculate average price of products in the specified group
    SELECT @AveragePrice = AVG(price)
    FROM Product
    WHERE group_id = @ProductGroupId;

    -- Update the product group's description based on the average price
    UPDATE Product_Group
    SET description = 
        CASE
            WHEN @AveragePrice < 50 THEN 'Affordable products'
            WHEN @AveragePrice >= 50 AND @AveragePrice < 100 THEN 'Mid-range products'
            WHEN @AveragePrice >= 100 THEN 'High-end products'
            ELSE 'No description available'
        END,
        last_modify = GETDATE()
    WHERE id = @ProductGroupId;

    -- Log the update in a separate table for auditing purposes
    INSERT INTO Product_Group_Update_Log (group_id, average_price, update_date)
    VALUES (@ProductGroupId, @AveragePrice, GETDATE());
END;



DROP PROCEDURE IF EXISTS SendMessage;
CREATE PROCEDURE SendMessage
    @UserId1 INT,
    @UserId2 INT,
    @ProductId INT,
    @MessageText NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO Message (user_id_1, user_id_2, product_id, message, create_date, last_modify, delete_date)
    VALUES (@UserId1, @UserId2, @ProductId, @MessageText, GETDATE(), GETDATE(), NULL);
END;

DROP PROCEDURE IF EXISTS UpdateProductPrice;
CREATE PROCEDURE UpdateProductPrice
    @ProductId INT,
    @NewPrice DECIMAL(20, 2)
AS
BEGIN
    UPDATE Product
    SET price = @NewPrice,
        last_modify = GETDATE()
    WHERE id = @ProductId;
END;

DROP PROCEDURE IF EXISTS DeleteUser;
CREATE PROCEDURE DeleteUser
    @UserId INT
AS
BEGIN
    UPDATE [User]
    SET delete_date = GETDATE()
    WHERE id = @UserId;
END;


DROP PROCEDURE IF EXISTS DeleteProductAndAssociatedData;
CREATE PROCEDURE DeleteProductAndAssociatedData
    @ProductId INT
AS
BEGIN
    BEGIN TRANSACTION;
    DELETE FROM Product_Address WHERE product_id = @ProductId;
    DELETE FROM [Message] WHERE product_id = @ProductId;
    DELETE FROM Product WHERE id = @ProductId;

    COMMIT;
END;

-- new stored procedure added in the third phase
-- this function checks the user budget and product price to validate the transaction
-- then add a transaction to the User_Transaction and lower the user budget acordingly
DROP PROCEDURE IF EXISTS Add_Transaction;
CREATE PROCEDURE Add_Transaction
    @user_id INT,
    @product_id INT
AS
BEGIN
-- add the transaction block to provide transaction atomicity
-- note: there can not be a deadlock scenario as the User_transaction table is only used in 
-- this stored procedure
-- note: as we have read commited envirment there can not be any dirthy read scenario
begin TRANSACTION
    DECLARE @current_date DATETIME = GETDATE();
    DECLARE @price decimal(20,2) = (select price from Product where id=@product_id);
    -- check if price is not NULL
    if @price is NULL
    begin
        print('Error: the price is not specified for this product thus we can not do the transaction.')
        commit;
        return;
    end

    -- check if user_id is in User table
    if NOT (@user_id in (select id from [User]))
    begin 
        print('Error: no such a user_id in the User table')
        commit;
        return;
    end 

    -- check if product_id is in Product table
    if not (@product_id in (select id from product))
    begin 
        print('Error: no such a product_id in Product table')
        commit 
        return
    end

    -- check if user can afford the product
    if @price > (select budget from [User] where id=@user_id)
    begin
        -- print error message
        print('Error: not enough budget to buy such product!');
        -- commit to end transaction before exiting the procedure
        commit
        return;
    end

    -- update user budget
    UPDATE [User]
    set budget = budget - @price 
    where id=@user_id

    -- finally insert the transaction
    INSERT INTO User_Transactions(user_id, product_id, tdate)
    VALUES (@user_id, @product_id, @current_date);

    print('Transaction done successfully...')
commit
END;

-- some tests or usecases for the functions
--GetProductMessages(@ProductId INT):
SELECT * FROM GetProductMessages(1) WHERE user_id_1 = 3;

--TotalProductPriceOfUser(@UserId INT):
SELECT dbo.TotalProductPriceOfUser(1) as Total;

--IsProductGroupActive(@GroupId INT):
SELECT dbo.IsProductGroupActive(1) AS IsActive;

-- Test CheckNationalCode Function
DECLARE @NationalCode NVARCHAR(MAX) = '6220032294';
SELECT dbo.CheckNationalCode(@NationalCode) AS IsValid;


------------------------------------------------------
-- some tests or usecases for the views 
-- View user profiles
SELECT * FROM User_Profile_View;

-- View product details
SELECT * FROM Product_Details_View;

-- View user message history
SELECT * FROM User_Message_History_View;

-- View user product summary
SELECT * FROM User_Product_Summary_View;

-- View active products
SELECT * FROM Active_Products_View;

-- View product message count
SELECT * FROM Product_Message_Count_View;


------------------------------------------------------------
-- some tests or usecases for the Trigger 
--tr_InsteadOfInsertUser Trigger Test
-- Attempt to insert a user with an invalid national code
select COUNT(*) from [User];
INSERT INTO [User] (first_name, last_name, username, national_code, [password], email, create_date, last_modify, delete_date)
VALUES ('John', 'Doe', 'johndoe', '6220015432', 'password123', 'john.doe@example.com', GETDATE(), GETDATE(), NULL);
select COUNT(*) from [User];
-- Insert a user with a valid national code
select COUNT(*) from [User];
INSERT INTO [User] (first_name, last_name, username, national_code, [password], email, create_date, last_modify, delete_date)
VALUES ('ali', 'rezaee', 'ali', '1235545628',
'd404559f602eab6fd602ac7680dacbfaadd13630335e951f097af3900e9de176b6db28512f2e000b9d04fba5133e8b1c6e8df59db3a8ab9d60be4b97cc9e81db',
'yasinkarbasian@email.com', '2023-10-04', '2023-10-04', NULL);
select COUNT(*) from [User];

--UpdateMessageDeleteDate Trigger Test:
-- Update the delete_date of a product and check if the trigger updates corresponding messages
SELECT * FROM Message WHERE product_id = 1;
UPDATE Product SET delete_date = GETDATE() WHERE id = 1;
-- Check the Message table to see if the delete_date is updated
SELECT * FROM Message WHERE product_id = 1;

--UpdateUserLastModify Trigger Test:
-- Update a user and check if the last_modify is updated
SELECT * FROM [User] WHERE id = 1;
UPDATE [User] SET first_name = 'UpdatedName2' WHERE id = 1;

-- Check the updated last_modify value
SELECT * FROM [User] WHERE id = 1;

--PreventProductInsertOnDeletedGroup Trigger Test:
-- Attempt to insert a product for a deleted product group
select * from Product_Group
UPDATE Product_Group
SET delete_date=GETDATE()
WHERE id=2;

INSERT INTO Product (user_id, title, description, group_id, price, create_date, last_modify, delete_date)
VALUES (1, 'smart phone', 'A great phone from Yasin Karbasian', 2, 100.00, '2023-10-04', '2023-10-04', NULL);
select * from Product;
-- Attempt to insert a product for an existing product group
UPDATE Product_Group
SET delete_date=NULL
WHERE id=2;

INSERT INTO Product (user_id, title, description, group_id, price, create_date, last_modify, delete_date)
VALUES (1, 'smart phone', 'A great phone from Yasin Karbasian', 2, 100.00, '2023-10-04', '2023-10-04', NULL);
select * from Product;

--UpdateProductDeleteDateOnGroupDelete Trigger Test:
-- Update the delete_date of a product group and check if the trigger updates corresponding product delete_date
select * from Product;
UPDATE Product_Group SET delete_date = GETDATE() WHERE id = 3;
SELECT * FROM Product_Group;
select * from Product;


---------------------------------------------------------
-- some tests or usecases for the stored procedures
--Test UpdateProductGroupDescription Procedure:
-- Update the description of a product group
EXEC UpdateProductGroupDescription @ProductGroupId = 1;

-- Check the updated Product_Group and Product_Group_Update_Log tables
SELECT * FROM Product_Group WHERE id = 1;
SELECT * FROM Product_Group_Update_Log;

--Test SendMessage Procedure:
-- Send a message
SELECT * FROM Message WHERE user_id_1 = 1 AND user_id_2 = 2 AND product_id = 1;
EXEC SendMessage @UserId1 = 1, @UserId2 = 2, @ProductId = 1, @MessageText = 'Hello, how are you?';
-- Check the inserted message
SELECT * FROM Message WHERE user_id_1 = 1 AND user_id_2 = 2 AND product_id = 1;

--Test UpdateProductPrice Procedure:
-- Update the price of a product
SELECT * FROM Product WHERE id = 1;
EXEC UpdateProductPrice @ProductId = 1, @NewPrice = 75.00;

-- Check the updated Product table
SELECT * FROM Product WHERE id = 1;


--Test DeleteUser Procedure:
-- Delete a user
SELECT * FROM [User] WHERE id = 1;
EXEC DeleteUser @UserId = 1;

-- Check the updated User table
SELECT * FROM [User] WHERE id = 1;


--Test DeleteProductAndAssociatedData Procedure:
-- Delete a product and its associated data
EXEC DeleteProductAndAssociatedData @ProductId = 1;

-- Check if the product and associated data are deleted
SELECT * FROM Product WHERE id = 1;
SELECT * FROM Product_Address WHERE product_id = 1;
SELECT * FROM Message WHERE product_id = 1;

--Test Add_Transaction Procedure:
-- Add a transaction
EXEC Add_Transaction @user_id = 1, @product_id = 2;

-- Check the updated User and User_Transactions tables
SELECT * FROM [User] WHERE id = 1;
SELECT * FROM User_Transactions WHERE user_id = 1 AND product_id = 2;
