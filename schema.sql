/* =====================================================
   RESET DATABASE
===================================================== */
USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'BikeMarketplace')
BEGIN
    ALTER DATABASE BikeMarketplace SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE BikeMarketplace;
END
GO

CREATE DATABASE BikeMarketplace;
GO
USE BikeMarketplace;
GO

/* =====================================================
   ROLES
===================================================== */
CREATE TABLE Roles(
    RoleID INT IDENTITY PRIMARY KEY,
    RoleName NVARCHAR(50) UNIQUE
);

INSERT INTO Roles VALUES
('ADMIN'),('BUYER'),('SELLER'),('INSPECTOR');

/* =====================================================
   USERS
===================================================== */
CREATE TABLE Users(
    UserID INT IDENTITY PRIMARY KEY,
    FullName NVARCHAR(100),
    Email NVARCHAR(100) UNIQUE,
    Password NVARCHAR(100),
    Phone NVARCHAR(20),
    Address NVARCHAR(200),
    RoleID INT,
    Status NVARCHAR(20) DEFAULT 'ACTIVE',
    FOREIGN KEY(RoleID) REFERENCES Roles(RoleID)
);

/* =====================================================
   BRANDS
===================================================== */
CREATE TABLE Brands(
    BrandID INT IDENTITY PRIMARY KEY,
    BrandName NVARCHAR(100) UNIQUE
);

INSERT INTO Brands VALUES
('Trek'),('Giant'),('Cannondale'),('Specialized'),
('Merida'),('Bianchi'),('Scott'),('Cube'),
('Twitter'),('Trinx');

/* =====================================================
   CATEGORIES
===================================================== */
CREATE TABLE Categories(
    CategoryID INT IDENTITY PRIMARY KEY,
    CategoryName NVARCHAR(100)
);

INSERT INTO Categories VALUES
('Road Bike'),('Mountain Bike'),
('Hybrid Bike'),('Gravel Bike'),('City Bike');

/* =====================================================
   BIKES
===================================================== */
CREATE TABLE Bikes(
    BikeID INT IDENTITY PRIMARY KEY,
    SellerID INT,
    Title NVARCHAR(200),
    Description NVARCHAR(MAX),
    Price DECIMAL(18,2),
    BrandID INT,
    CategoryID INT,
    FrameSize NVARCHAR(20),
    BikeCondition NVARCHAR(50),
    Status NVARCHAR(20),
    FOREIGN KEY(SellerID) REFERENCES Users(UserID),
    FOREIGN KEY(BrandID) REFERENCES Brands(BrandID),
    FOREIGN KEY(CategoryID) REFERENCES Categories(CategoryID)
);

/* =====================================================
   ORDERS
===================================================== */
CREATE TABLE Orders(
    OrderID INT IDENTITY PRIMARY KEY,
    BikeID INT,
    BuyerID INT,
    SellerID INT,
    TotalAmount DECIMAL(18,2),
    DepositAmount DECIMAL(18,2),
    Status NVARCHAR(20),
    FOREIGN KEY(BikeID) REFERENCES Bikes(BikeID),
    FOREIGN KEY(BuyerID) REFERENCES Users(UserID),
    FOREIGN KEY(SellerID) REFERENCES Users(UserID)
);

/* =====================================================
   REVIEWS
===================================================== */
CREATE TABLE Reviews(
    ReviewID INT IDENTITY PRIMARY KEY,
    OrderID INT,
    BuyerID INT,
    SellerID INT,
    Rating INT,
    Comment NVARCHAR(MAX),
    FOREIGN KEY(OrderID) REFERENCES Orders(OrderID)
);

/* =====================================================
   MESSAGES
===================================================== */
CREATE TABLE Messages(
    MessageID INT IDENTITY PRIMARY KEY,
    SenderID INT,
    ReceiverID INT,
    BikeID INT,
    Content NVARCHAR(MAX)
);

/* =====================================================
   AUTO INSERT USERS (50 USERS)
===================================================== */
DECLARE @i INT = 1;
WHILE @i <= 50
BEGIN
    INSERT INTO Users(FullName,Email,Password,Phone,Address,RoleID)
    VALUES(
        'User '+CAST(@i AS NVARCHAR),
        'user'+CAST(@i AS NVARCHAR)+'@gmail.com',
        '123456',
        '09000000'+CAST(@i AS NVARCHAR),
        'Vietnam',
        CASE 
            WHEN @i <= 15 THEN 3
            WHEN @i <= 45 THEN 2
            ELSE 4
        END
    );
    SET @i=@i+1;
END

/* =====================================================
   AUTO INSERT 60 BIKES
===================================================== */
DECLARE @j INT = 1;
WHILE @j <= 60
BEGIN
    INSERT INTO Bikes
    (SellerID,Title,Description,Price,BrandID,CategoryID,FrameSize,BikeCondition,Status)
    VALUES(
        ABS(CHECKSUM(NEWID()))%15+1,
        'Bike Model '+CAST(@j AS NVARCHAR),
        'High quality sport bicycle for training and city riding.',
        ABS(CHECKSUM(NEWID()))%50000000+8000000,
        ABS(CHECKSUM(NEWID()))%10+1,
        ABS(CHECKSUM(NEWID()))%5+1,
        'M',
        'USED_GOOD',
        'APPROVED'
    );
    SET @j=@j+1;
END

/* =====================================================
   AUTO INSERT 30 ORDERS
===================================================== */
DECLARE @k INT = 1;
WHILE @k <= 30
BEGIN
    INSERT INTO Orders
    (BikeID,BuyerID,SellerID,TotalAmount,DepositAmount,Status)
    VALUES(
        ABS(CHECKSUM(NEWID()))%60+1,
        ABS(CHECKSUM(NEWID()))%30+16,
        ABS(CHECKSUM(NEWID()))%15+1,
        ABS(CHECKSUM(NEWID()))%50000000+8000000,
        ABS(CHECKSUM(NEWID()))%5000000+1000000,
        'COMPLETED'
    );
    SET @k=@k+1;
END

/* =====================================================
   AUTO INSERT 20 REVIEWS
===================================================== */
DECLARE @r INT = 1;
WHILE @r <= 20
BEGIN
    INSERT INTO Reviews(OrderID,BuyerID,SellerID,Rating,Comment)
    VALUES(
        ABS(CHECKSUM(NEWID()))%30+1,
        ABS(CHECKSUM(NEWID()))%30+16,
        ABS(CHECKSUM(NEWID()))%15+1,
        ABS(CHECKSUM(NEWID()))%5+1,
        'Very good transaction experience.'
    );
    SET @r=@r+1;
END

SELECT COUNT(*) FROM Users;
SELECT COUNT(*) FROM Bikes;
SELECT COUNT(*) FROM Orders;
SELECT COUNT(*) FROM Reviews;