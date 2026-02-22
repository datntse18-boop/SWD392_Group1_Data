USE BikeMarketplace;
GO

/* =========================
   INSERT USERS (50 USERS)
========================= */
DECLARE @i INT = 1;
WHILE @i <= 50
BEGIN
    INSERT INTO Users(FullName,Email,Password,Phone,Address,RoleID)
    VALUES(
        'User '+CAST(@i AS NVARCHAR),
        'user'+CAST(@i AS NVARCHAR)+'@gmail.com',
        '123456',
        '09000000'+RIGHT('00'+CAST(@i AS NVARCHAR),2),
        CASE 
            WHEN @i <= 15 THEN 'Ho Chi Minh City'
            WHEN @i <= 30 THEN 'Ha Noi'
            ELSE 'Da Nang'
        END,
        CASE 
            WHEN @i <= 15 THEN 3   -- Seller
            WHEN @i <= 45 THEN 2   -- Buyer
            ELSE 4                 -- Inspector
        END
    );
    SET @i=@i+1;
END

/* =========================
   INSERT 60 BIKES
========================= */
DECLARE @j INT = 1;
WHILE @j <= 60
BEGIN
    INSERT INTO Bikes
    (SellerID,Title,Description,Price,BrandID,CategoryID,FrameSize,BikeCondition,Status)
    VALUES(
        ABS(CHECKSUM(NEWID()))%15+1,
        'Bike Model '+CAST(@j AS NVARCHAR),
        'High quality sport bike, suitable for training and city riding.',
        ABS(CHECKSUM(NEWID()))%50000000+8000000,
        ABS(CHECKSUM(NEWID()))%10+1,
        ABS(CHECKSUM(NEWID()))%5+1,
        CASE WHEN @j%3=0 THEN 'S'
             WHEN @j%3=1 THEN 'M'
             ELSE 'L' END,
        CASE WHEN @j%2=0 THEN 'USED_LIKE_NEW'
             ELSE 'USED_GOOD' END,
        'APPROVED'
    );
    SET @j=@j+1;
END

/* =========================
   INSERT 30 ORDERS
========================= */
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
        CASE WHEN @k%2=0 THEN 'COMPLETED'
             ELSE 'DEPOSITED' END
    );
    SET @k=@k+1;
END

/* =========================
   INSERT 20 REVIEWS
========================= */
DECLARE @r INT = 1;
WHILE @r <= 20
BEGIN
    INSERT INTO Reviews(OrderID,BuyerID,SellerID,Rating,Comment)
    VALUES(
        ABS(CHECKSUM(NEWID()))%30+1,
        ABS(CHECKSUM(NEWID()))%30+16,
        ABS(CHECKSUM(NEWID()))%15+1,
        ABS(CHECKSUM(NEWID()))%5+1,
        'Very smooth transaction and professional seller.'
    );
    SET @r=@r+1;
END

/* =========================
   INSERT 40 MESSAGES
========================= */
DECLARE @m INT = 1;
WHILE @m <= 40
BEGIN
    INSERT INTO Messages(SenderID,ReceiverID,BikeID,Content)
    VALUES(
        ABS(CHECKSUM(NEWID()))%50+1,
        ABS(CHECKSUM(NEWID()))%50+1,
        ABS(CHECKSUM(NEWID()))%60+1,
        'Hello, is this bike still available?'
    );
    SET @m=@m+1;
END