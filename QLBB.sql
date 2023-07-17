CREATE DATABASE QLBB;

USE QLBB;

/* Table: CARD_TYPE */
CREATE TABLE CARD_TYPE (
   TypeID INT NOT NULL IDENTITY(1,1),
   Type VARCHAR(150) NULL,
   CONSTRAINT PK_CARD_TYPE PRIMARY KEY (TypeID)
);

/* Table: CART_ITEM */
CREATE TABLE CART_ITEM (
   CartItemID INT NOT NULL IDENTITY(1,1),
   Quantity INT NULL,
   Subtotal FLOAT NULL,
   ProductID INT NULL,
   OrderID INT NULL,
   ShoppingCartID INT NULL,
   CONSTRAINT PK_CART_ITEM PRIMARY KEY (CartItemID)
);

/* Table: CATEGORY */
CREATE TABLE CATEGORY (
   CategoryID INT NOT NULL IDENTITY(1,1),
   CategoryName NVARCHAR(300) NULL,
   ParentID INT NULL,
   CONSTRAINT PK_CATEGORY PRIMARY KEY (CategoryID)
);

/* Table: "ORDER" */
CREATE TABLE "ORDER" (
   OrderID INT NOT NULL IDENTITY(1,1),
   OrderDate DATE NULL,
   OrderStatus NVARCHAR(300) NULL,
   ShippingMethod NVARCHAR(300) NULL,
   ShippingDate DATE NULL,
   OrderTotal FLOAT NULL,
   UserID INT NULL,
   CONSTRAINT PK_ORDER PRIMARY KEY (OrderID)
);

/* Table: ORDER_SHIPPING_METHOD */
CREATE TABLE ORDER_SHIPPING_METHOD (
   ShippingMethod NVARCHAR(300) NOT NULL,
   CONSTRAINT PK_ORDER_SHIPPING_METHOD PRIMARY KEY (ShippingMethod)
);

/* Table: ORDER_STATUS */
CREATE TABLE ORDER_STATUS (
   OrderStatus NVARCHAR(300) NOT NULL,
   CONSTRAINT PK_ORDER_STATUS PRIMARY KEY (OrderStatus)
);

/* Table: PRODUCT */
CREATE TABLE PRODUCT (
   ProductID INT NOT NULL IDENTITY(1,1),
   ProductName NVARCHAR(300) NULL,
   Description NVARCHAR(MAX) NULL,
   ShortDescription NVARCHAR(MAX) NULL,
   StockNumber INT NULL,
   Image VARCHAR(500) NULL,
   Price FLOAT NULL,
   Discount INT NULL,
   Rating FLOAT NULL,
   PublicationDate DATE NULL,
   CONSTRAINT PK_PRODUCT PRIMARY KEY (ProductID)
);

/* Table: PRODUCT_CATEGORY */
CREATE TABLE PRODUCT_CATEGORY (
   ProductID INT NOT NULL,
   CategoryID INT NOT NULL,
   CONSTRAINT PK_PRODUCT_CATEGORY PRIMARY KEY (ProductID, CategoryID)
);

/* Table: PRODUCT_TAG */
CREATE TABLE PRODUCT_TAG (
   ProductID INT NOT NULL,
   TagID INT NOT NULL,
   CONSTRAINT PK_PRODUCT_TAG PRIMARY KEY (ProductID, TagID)
);

/* Table: ROLE */
CREATE TABLE ROLE (
   RoleID INT NOT NULL IDENTITY(1,1),
   RoleName VARCHAR(100) NULL,
   CONSTRAINT PK_ROLE PRIMARY KEY (RoleID)
);

/* Table: SALES */
CREATE TABLE SALES (
   SalesID INT NOT NULL IDENTITY(1,1),
   CreateDate DATE NULL,
   Month INT NULL,
   Year INT NULL,
   SalesAmount FLOAT NULL,
   CONSTRAINT PK_SALES PRIMARY KEY (SalesID)
);

/* Table: SALES_DETAIL */
CREATE TABLE SALES_DETAIL (
   SalesID INT NOT NULL ,
   OrderID INT NOT NULL,
   TotalAmount FLOAT NULL,
   "Percent" FLOAT NULL,
   CONSTRAINT PK_SALES_DETAIL PRIMARY KEY (SalesID, OrderID)
);

/* Table: SHOPPING_CART */
CREATE TABLE SHOPPING_CART (
   ShoppingCartID INT NOT NULL IDENTITY(1,1),
   GrandTotal FLOAT NULL,
   UserID INT NULL,
   CONSTRAINT PK_SHOPPING_CART PRIMARY KEY (ShoppingCartID)
);

/* Table: TAG */
CREATE TABLE TAG (
   TagID INT NOT NULL IDENTITY(1,1),
   TagName NVARCHAR(300) NULL,
   CONSTRAINT PK_TAG PRIMARY KEY (TagID)
);

/* Table: "USER" */
CREATE TABLE "USER" (
   UserID INT NOT NULL IDENTITY(1,1),
   FirstName NVARCHAR(300) NULL,
   LastName NVARCHAR(300) NULL,
   Email VARCHAR(300) NULL,
   UserName VARCHAR(300) NULL,
   Password VARCHAR(300) NULL,
   Telephone VARCHAR(11) NULL,
   CONSTRAINT PK_USER PRIMARY KEY (UserID)
);

/* Table: USER_PAYMENT */
CREATE TABLE USER_PAYMENT (
   UserPaymentID INT NOT NULL IDENTITY(1,1),
   CardName NVARCHAR(300) NULL,
   CardNumber VARCHAR(20) NULL,
   CVC INT NULL,
   DefaultPayment CHAR(10) NULL,
   ExpiryMonth INT NULL,
   ExpiryYear INT NULL,
   HolderName NVARCHAR(300) NULL,
   TypeID INT NULL,
   UserID INT NULL,
   CONSTRAINT PK_USER_PAYMENT PRIMARY KEY (UserPaymentID)
);

/* Table: USER_ROLE */
CREATE TABLE USER_ROLE (
   UserID INT NOT NULL,
   RoleID INT NOT NULL,
   CONSTRAINT PK_USER_ROLE PRIMARY KEY (UserID, RoleID)
);

/* Table: USER_SHIPPING */
CREATE TABLE USER_SHIPPING (
   UserShippingID INT NOT NULL IDENTITY(1,1),
   Country NVARCHAR(100) NULL,
   City NVARCHAR(200) NULL,
   District NVARCHAR(200) NULL,
   Ward NVARCHAR(100) NULL,
   Street NVARCHAR(300) NULL,
   DefaultShipping BIT NULL,
   UserID INT NULL,
   CONSTRAINT PK_USER_SHIPPING PRIMARY KEY (UserShippingID)
);

ALTER TABLE CART_ITEM
   ADD CONSTRAINT FK_CART_ITEM_REFERENCE_SHOPPING FOREIGN KEY (ShoppingCartID)
      REFERENCES SHOPPING_CART (ShoppingCartID);

ALTER TABLE CART_ITEM
   ADD CONSTRAINT FK_CART_ITEM_REFERENCE_PRODUCT FOREIGN KEY (ProductID)
      REFERENCES PRODUCT (ProductID);

ALTER TABLE CART_ITEM
   ADD CONSTRAINT FK_CART_ITEM_REFERENCE_ORDER FOREIGN KEY (OrderID)
      REFERENCES "ORDER" (OrderID);

ALTER TABLE CATEGORY
   ADD CONSTRAINT FK_CATEGORY_REFERENCE_CATEGORY FOREIGN KEY (ParentID)
      REFERENCES CATEGORY (CategoryID);

ALTER TABLE "ORDER"
   ADD CONSTRAINT FK_ORDER_REFERENCE_USER FOREIGN KEY (UserID)
      REFERENCES "USER" (UserID);

ALTER TABLE "ORDER"
   ADD CONSTRAINT FK_ORDER_REFERENCE_ORDER_STATUS FOREIGN KEY (OrderStatus)
      REFERENCES ORDER_STATUS (OrderStatus);

ALTER TABLE "ORDER"
   ADD CONSTRAINT FK_ORDER_REFERENCE_ORDER_SHIPPING FOREIGN KEY (ShippingMethod)
      REFERENCES ORDER_SHIPPING_METHOD (ShippingMethod);

ALTER TABLE PRODUCT_CATEGORY
   ADD CONSTRAINT FK_PRODUCT_CATEGORY_REFERENCE_PRODUCT FOREIGN KEY (ProductID)
      REFERENCES PRODUCT (ProductID);

ALTER TABLE PRODUCT_CATEGORY
   ADD CONSTRAINT FK_PRODUCT_CATEGORY_REFERENCE_CATEGORY FOREIGN KEY (CategoryID)
      REFERENCES CATEGORY (CategoryID);

ALTER TABLE PRODUCT_TAG
   ADD CONSTRAINT FK_PRODUCT_TAG_REFERENCE_PRODUCT FOREIGN KEY (ProductID)
      REFERENCES PRODUCT (ProductID);

ALTER TABLE PRODUCT_TAG
   ADD CONSTRAINT FK_PRODUCT_TAG_REFERENCE_TAG FOREIGN KEY (TagID)
      REFERENCES TAG (TagID);

ALTER TABLE SALES_DETAIL
   ADD CONSTRAINT FK_SALES_DETAIL_REFERENCE_SALES FOREIGN KEY (SalesID)
      REFERENCES SALES (SalesID);

ALTER TABLE SALES_DETAIL
   ADD CONSTRAINT FK_SALES_DETAIL_REFERENCE_ORDER FOREIGN KEY (OrderID)
      REFERENCES "ORDER" (OrderID);

ALTER TABLE SHOPPING_CART
   ADD CONSTRAINT FK_SHOPPING_CART_REFERENCE_USER FOREIGN KEY (UserID)
      REFERENCES "USER" (UserID);

ALTER TABLE USER_PAYMENT
   ADD CONSTRAINT FK_USER_PAYMENT_REFERENCE_USER FOREIGN KEY (UserID)
      REFERENCES "USER" (UserID);

ALTER TABLE USER_PAYMENT
   ADD CONSTRAINT FK_USER_PAYMENT_REFERENCE_CARD_TYPE FOREIGN KEY (TypeID)
      REFERENCES CARD_TYPE (TypeID);

ALTER TABLE USER_ROLE
   ADD CONSTRAINT FK_USER_ROLE_REFERENCE_USER FOREIGN KEY (UserID)
      REFERENCES "USER" (UserID);

ALTER TABLE USER_ROLE
   ADD CONSTRAINT FK_USER_ROLE_REFERENCE_ROLE FOREIGN KEY (RoleID)
      REFERENCES ROLE (RoleID);

ALTER TABLE USER_SHIPPING
   ADD CONSTRAINT FK_USER_SHIPPING_REFERENCE_USER FOREIGN KEY (UserID)
      REFERENCES "USER" (UserID);

ALTER TABLE PRODUCT
	ADD CONSTRAINT UQ_PRODUCT_ProductName UNIQUE (ProductName);

/* Trigger: Quantity phải có giá trị lớn hơn hoặc bằng 1 */
CREATE TRIGGER CheckQuantityCart
ON CART_ITEM
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE Quantity < 1)
    BEGIN
        RAISERROR(N'Quantity của CartItem phải lớn hơn hoặc bằng 1', 16, 1)
        ROLLBACK TRANSACTION
    END
END

/* Trigger: Giá trị của OrderStatus thuộc [“Đang chờ xử lý”, “Đã xác nhận”, “Đang giao”, “Giao hàng thành công”] */
CREATE TRIGGER CheckOrderStatus
ON ORDER_STATUS
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT *
        FROM INSERTED
        WHERE OrderStatus NOT IN (N'Đang chờ xử lý', N'Đã xác nhận', N'Đang giao', N'Giao hàng thành công')
    )
    BEGIN
        RAISERROR (N'Giá trị OrderStatus không hợp lệ. Các giá trị cho phép: "Đang chờ xử lý", "Đã xác nhận", "Đang giao", "Giao hàng thành công".', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
END
/*=> Insert ORDER_STATUS*/
INSERT INTO ORDER_STATUS (OrderStatus) VALUES (N'Đang chờ xử lý');
INSERT INTO ORDER_STATUS (OrderStatus) VALUES (N'Đã xác nhận');
INSERT INTO ORDER_STATUS (OrderStatus) VALUES (N'Đang giao');
INSERT INTO ORDER_STATUS (OrderStatus) VALUES (N'Giao hàng thành công');

/* Trigger: Ngày lập đơn hàng phải trước ngày vận chuyển */
CREATE TRIGGER CheckOrderDates
ON [ORDER]
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT *
        FROM INSERTED
        WHERE OrderDate > ShippingDate
    )
    BEGIN
        RAISERROR (N'OrderDate phải nhỏ hơn ShippingDate', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
END

/* Trigger: Tổng tiền giỏ hàng */
CREATE TRIGGER UpdateGrandTotal
ON CART_ITEM
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @ShoppingCartId INT
    IF EXISTS (
        SELECT *
        FROM INSERTED
    )
    BEGIN
        SELECT @ShoppingCartId = ShoppingCartId
        FROM INSERTED
    END
    ELSE IF EXISTS (
        SELECT *
        FROM DELETED
    )
    BEGIN
        SELECT @ShoppingCartId = ShoppingCartId
        FROM DELETED
    END
    UPDATE SHOPPING_CART
    SET GrandTotal = (
        SELECT SUM(SubTotal)
        FROM CART_ITEM
        WHERE ShoppingCartId = @ShoppingCartId
    )
    WHERE ShoppingCartId = @ShoppingCartId
END

/* Trigger: Số tiền trên một cart */
CREATE TRIGGER CalculateSubTotal
ON CART_ITEM
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE CART_ITEM
    SET SubTotal = c.Quantity * (p.Price - (p.Price * p.Discount * 0.01))
    FROM CART_ITEM c
    JOIN PRODUCT p ON c.ProductId = p.ProductId
    WHERE c.CartItemId IN (SELECT CartItemId FROM INSERTED)
END

/* Trigger: Tổng tiền đơn hàng */
CREATE TRIGGER CalculateOrderTotal
ON [ORDER]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE o
    SET OrderTotal = (
        SELECT SUM(c.SubTotal)
        FROM CART_ITEM c
        WHERE c.OrderId = o.OrderId
    )
    FROM [ORDER] o
    INNER JOIN inserted i ON o.OrderId = i.OrderId
    WHERE i.OrderId IS NOT NULL
    UPDATE o
    SET OrderTotal = (
        SELECT SUM(c.SubTotal)
        FROM CART_ITEM c
        WHERE c.OrderId = o.OrderId
    )
    FROM [ORDER] o
    INNER JOIN deleted d ON o.OrderId = d.OrderId
    WHERE d.OrderId IS NOT NULL
END

/* Trigger: Tiền trong chi tiết doanh thu*/
CREATE TRIGGER CheckSalesDetailTotal
ON SALES_DETAIL
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT *
        FROM inserted i
        INNER JOIN [ORDER] o ON i.OrderId = o.OrderId
        WHERE i.TotalAmount <> o.OrderTotal
    )
    BEGIN
        RAISERROR (N'TotalAmount trong SALES_DETAIL phải bằng OrderTotal trong ORDER.', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
END

/* Trigger: Tổng tiền doanh thu*/
CREATE TRIGGER CheckSalesTotal
ON SALES
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT s.SalesId, s.SalesAmount, 
            (SELECT SUM(sd.TotalAmount) FROM SALES_DETAIL sd WHERE sd.SalesId = s.SalesId) AS TotalAmountSum
        FROM SALES s
        WHERE s.SalesAmount <> COALESCE((SELECT SUM(sd.TotalAmount) FROM SALES_DETAIL sd WHERE sd.SalesId = s.SalesId), 0)
    )
    BEGIN
        RAISERROR (N'SalesAmount của SALES phải bằng tổng của các TotalAmounts trong SALES_DETAIL.', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
END

/* Trigger: Tỷ lệ hóa đơn trên tổng doanh thu */
CREATE TRIGGER CheckSalesDetailRatio
ON SALES_DETAIL
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT sd.SalesId, sd.TotalAmount, sd."Percent", s.SalesAmount
        FROM SALES_DETAIL sd
        INNER JOIN SALES s ON sd.SalesId = s.SalesId
        WHERE sd."Percent" <> sd.TotalAmount / s.SalesAmount
    )
    BEGIN
        RAISERROR (N'Tỷ lệ của TotalAmount so với SalesAmount không khớp với Phần trăm trong SALES_DETAIL.', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
END

/* Trigger: Giá trị của Month */
CREATE TRIGGER CheckMonthRange
ON SALES
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE Month < 1 OR Month > 12
    )
    BEGIN
        RAISERROR ('Giá trị Month không hợp lệ. Month phải trong khoảng 1 và 12.', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
END
-- Insert Role -- 
INSERT INTO [ROLE] (RoleName)
VALUES ('Administrator');
INSERT INTO [ROLE] (RoleName)
VALUES ('User');

-- Insert User --
-- pass user : 123456qC --
INSERT INTO [User] (FirstName, LastName, Email, UserName, Password, Telephone)
VALUES ('Trang', 'Huynh', 'admin@gmail.com', 'admin', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '1234567890')
INSERT INTO [User] (FirstName, LastName, Email, UserName, Password, Telephone)
VALUES ('Luan', 'Nguyen', 'luannn308@gmail.com', 'luannn308', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '1234567890')

-- Insert User_Role --
INSERT INTO [USER_ROLE] (RoleID,UserID) VALUES (1,1);
INSERT INTO [USER_ROLE] (RoleID,UserID) VALUES (2,2);

-- Insert Product --
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, Rating, PublicationDate)
VALUES (N'Blueberry Yogurt Cream Cake', N'Blueberry Yogurt Cream Cake là một tuyệt phẩm bánh ngọt thơm ngon kết hợp với vị chua nhẹ từ sữa chua và hương vị đặc trưng của quả blueberry tươi ngon. Bánh được làm từ những nguyên liệu chất lượng cao và tinh túy, mang đến một trải nghiệm ẩm thực tuyệt vời cho những ai yêu thích hương vị ngọt ngào và tươi mát.
Với lớp bánh mềm mịn và màu sắc xanh dịu nhẹ, Blueberry Yogurt Cream Cake gợi lên hình ảnh của một ngày hè thanh mát và tràn đầy năng lượng. Bên trên bánh là một lớp kem sữa chua mịn màng, hòa quyện với vị chua nhẹ của sữa chua và vị ngọt thanh của blueberry. Quả blueberry tươi ngon được sắp xếp cẩn thận trên bề mặt bánh, tạo nên một khung cảnh tươi sáng và đầy màu sắc.
Blueberry Yogurt Cream Cake không chỉ gây ấn tượng bởi vẻ đẹp tinh tế mà còn nhờ vào hương vị tuyệt vời. Vị chua nhẹ từ sữa chua kết hợp hài hòa với vị ngọt thanh của blueberry, tạo nên một sự cân bằng tuyệt đối giữa các thành phần. Bánh có độ ẩm vừa phải, giúp giữ cho bánh mềm mịn trong từng miếng.
Blueberry Yogurt Cream Cake là lựa chọn hoàn hảo cho các dịp kỷ niệm, sinh nhật hoặc chỉ đơn giản là khi bạn muốn thưởng thức một món tráng miệng thật ngon lành. Bạn có thể thưởng thức bánh này một mình, hoặc chia sẻ với gia đình và bạn bè. Dù là ngày nắng hay ngày mưa, Blueberry Yogurt Cream Cake sẽ làm hài lòng cả những tín đồ ẩm thực khó tính nhất.', N'Blueberry Yogurt Cream Cake - một tuyệt phẩm bánh ngọt thơm ngon với lớp kem sữa chua mịn màng và vị ngọt thanh của quả blueberry tươi ngon. Bánh mềm mịn và hấp dẫn, là sự kết hợp hoàn', 2, 'cloud-cake-1.png', 200000, 10, 8.9, '2023-06-28');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, Rating, PublicationDate)
VALUES (N'Strawberry Cloud Cake', N'Strawberry Cloud Cake là một tác phẩm bánh ngọt tinh tế và ngon miệng, mang đến một trải nghiệm ẩm thực thật tuyệt vời với vị ngọt của quả dâu tươi mọng và lớp kem mousse nhẹ nhàng như mây. Bánh được làm từ những thành phần chất lượng cao và kỹ thuật nghệ thuật, tạo nên một tác phẩm trang trọng và thú vị trên bàn ăn.
Strawberry Cloud Cake có lớp bánh mềm mịn và nhẹ nhàng, mang trong mình một màu hồng tươi sáng, tượng trưng cho sự tươi mới và tinh khiết của quả dâu. Bên trên bánh, lớp kem mousse trắng mịn tạo ra một hình ảnh như mây, mang đến sự nhẹ nhàng và êm dịu cho mỗi miếng bánh. Quả dâu tươi ngon được sắp xếp cẩn thận, làm cho bề mặt bánh trở nên đẹp mắt và hấp dẫn.
Vị ngọt thanh từ quả dâu tươi kết hợp với vị nhẹ nhàng và mát lạnh của kem mousse, tạo ra một cảm giác hài hòa và hoàn hảo trên đầu lưỡi. Bánh có độ ẩm vừa phải, giúp bánh mềm mịn tan chảy trong miệng, mang đến một trải nghiệm ẩm thực đầy thú vị.
Strawberry Cloud Cake là một lựa chọn hoàn hảo cho các dịp đặc biệt như sinh nhật, kỷ niệm hay các buổi tiệc. Bánh không chỉ làm vừa lòng về mặt hương vị mà còn gây ấn tượng với vẻ đẹp tinh tế. Với màu hồng tươi sáng và vẻ ngoài trang nhã, bánh là một điểm nhấn hoàn hảo cho bất kỳ bữa tiệc nào.
Dù là ngày hè nóng bức hay ngày đông lạnh giá, Strawberry Cloud Cake đều mang đến niềm vui và sự thỏa mãn cho mọi thực khách. Bạn sẽ cảm nhận được sự hạnh phúc khi thưởng thức một miếng bánh thật tuyệt vời, nơi mà hương vị tuyệt hảo của quả dâu hòa quyện với kem mousse nhẹ nhàng như mây.', N'Strawberry Cloud Cake - một tác phẩm bánh ngọt với lớp kem mousse nhẹ nhàng như mây và vị ngọt thanh của quả dâu tươi. Bánh mềm mịn và trang nhã, là sự lựa chọn hoàn hảo cho các dịp đặc biệt và mang đến niềm vui cho mọi thực khách.', 2, 'cloud-cake-2.png', 230000, 10, 8.9, '2023-06-29');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, Rating, PublicationDate)
VALUES (N'Green Tea Cloud Cake', N'Green Tea Cloud Cake là một chiếc bánh ngọt tuyệt đẹp và hấp dẫn, kết hợp giữa hương vị đặc trưng của trà xanh và sự nhẹ nhàng của kem mousse. Bánh mang đến một trải nghiệm ẩm thực độc đáo và sảng khoái, là sự hòa quyện tinh tế giữa vị ngọt và hương thơm tự nhiên của trà xanh.
Green Tea Cloud Cake có lớp bánh mềm mịn và màu xanh dịu nhẹ, tượng trưng cho sự tươi mới và sự thanh lịch của trà xanh. Bên trên bánh là một lớp kem mousse nhẹ nhàng, có màu trắng tinh khiết, tạo nên một cảm giác mềm mại và mịn màng trên đầu lưỡi. Để tạo điểm nhấn thú vị, có thể trang trí bánh bằng bột trà xanh hoặc lá trà xanh tươi, mang đến sự hấp dẫn và hương vị đa dạng.
Vị ngọt thanh từ bánh kết hợp với hương thơm đặc trưng và thanh mát của trà xanh, tạo nên một hòa quyện ngọt ngào và sảng khoái trên đầu lưỡi. Bánh có độ ẩm vừa phải, giúp giữ cho bánh mềm mịn và đồng thời tăng thêm cảm giác sảng khoái. Vị trà xanh đặc biệt và tinh tế tạo ra một trải nghiệm ẩm thực độc đáo, làm say mê những người yêu thích trà xanh.
Green Tea Cloud Cake là lựa chọn hoàn hảo cho những dịp đặc biệt như sinh nhật, kỷ niệm hay buổi tiệc. Bánh không chỉ mang đến hương vị tuyệt vời mà còn gây ấn tượng với vẻ đẹp tinh tế. Màu xanh dịu nhẹ và hương thơm tự nhiên của trà xanh tạo nên một cảm giác thanh lịch và trang nhã, làm cho bàn tiệc thêm phần đặc biệt và thu hút.', N'Green Tea Cloud Cake - một chiếc bánh ngọt hấp dẫn với hương vị đặc trưng của trà xanh và sự nhẹ nhàng của kem mousse. Bánh mềm mịn và màu xanh tươi sáng, mang đến trải nghiệm ẩm thực độc đáo và thanh mát.', 2, 'cloud-cake-3.png', 230000, 10, 8.9, '2023-06-30');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, Rating, PublicationDate)
VALUES (N'Peach Cream Cake', N'Peach Cream Cake là một tuyệt phẩm bánh ngọt đầy sáng tạo, kết hợp giữa hương vị tươi ngon của quả đào và sự mịn màng của kem kem tươi. Bánh mang đến một trải nghiệm ẩm thực tuyệt vời, với vị ngọt mát và hương thơm tự nhiên của quả đào tươi.
Peach Cream Cake có lớp bánh mềm mịn, mang trong mình màu vàng nhẹ nhàng. Bề mặt bánh được phủ một lớp kem kem tươi mịn màng, tạo ra một hình ảnh tươi sáng và hấp dẫn. Quả đào tươi ngon được sắp xếp trên bề mặt bánh, tạo điểm nhấn màu sắc và sự tươi mát cho bánh.
Vị ngọt của quả đào kết hợp với kem kem tươi mịn màng, tạo ra một hòa quyện ngọt ngào và mát lạnh trên đầu lưỡi. Bánh có độ ẩm vừa phải, giúp bánh mềm mịn và giữ được độ tươi mát của quả đào. Vị ngọt tự nhiên của quả đào tươi ngon mang lại cảm giác thơm ngon và sảng khoái cho mỗi miếng bánh.
Peach Cream Cake là sự lựa chọn hoàn hảo cho các dịp đặc biệt như sinh nhật, kỷ niệm hoặc khi bạn muốn thưởng thức một món tráng miệng thật ngon lành. Bạn có thể tận hưởng bánh một mình hoặc chia sẻ với gia đình và bạn bè. Bất kể mùa trong năm, Peach Cream Cake đều là một món tráng miệng thú vị và hấp dẫn.
Với Peach Cream Cake, bạn sẽ thưởng thức hương vị tươi mát và hấp dẫn của quả đào tươi ngon kết hợp với sự mịn màng và ngọt ngào của kem kem tươi. Hãy cùng nhau trải nghiệm một miếng bánh độc đáo và tinh tế, mang đến niềm vui cho vị giác của bạn.', N'Peach Cream Cake - một tuyệt phẩm bánh ngọt với hương vị tươi ngon của quả đào và sự mịn màng của kem kem tươi. Bánh mềm mịn và tươi sáng, mang đến trải nghiệm ẩm thực thú vị và sảng khoái.', 2, 'cloud-cake-4.png', 200000, 10, 8.9, '2023-07-03');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, Rating, PublicationDate)
VALUES (N'Triple Berry Cloud', N'Triple Berry Cloud là một tuyệt phẩm bánh ngọt tươi ngon và thanh mát, kết hợp giữa ba loại trái cây mọng nước - dâu tây, mâm xôi và việt quất - cùng với lớp kem mousse nhẹ nhàng. Bánh mang đến một trải nghiệm ẩm thực độc đáo và hấp dẫn, với vị ngọt tự nhiên và hương thơm tươi mát của các loại trái cây.
Triple Berry Cloud có lớp bánh mềm mịn và màu trắng tinh khiết, tượng trưng cho sự tinh tế và sự tươi mới của trái cây. Bề mặt bánh được phủ một lớp kem mousse nhẹ nhàng, tạo nên một cảm giác mềm mại và mịn màng trên đầu lưỡi. Quả dâu tây tươi, mâm xôi và việt quất được sắp xếp trên bề mặt bánh, tạo điểm nhấn màu sắc và hương vị tươi mát.
Vị ngọt thanh của ba loại trái cây kết hợp với kem mousse nhẹ nhàng, tạo ra một hòa quyện ngọt ngào và mát lạnh trên đầu lưỡi. Bánh có độ ẩm vừa phải, giúp bánh mềm mịn và giữ được độ tươi mát của trái cây. Vị ngọt tự nhiên của dâu tây, mâm xôi và việt quất mang lại cảm giác tươi mới và sảng khoái cho mỗi miếng bánh.
Triple Berry Cloud là lựa chọn hoàn hảo cho các dịp đặc biệt như sinh nhật, kỷ niệm hoặc khi bạn muốn thưởng thức một món tráng miệng tươi mát và đầy hương vị. Bạn có thể tận hưởng bánh một mình hoặc chia sẻ với gia đình và bạn bè. Bánh không chỉ ngon lành mà còn làm cho bữa tiệc thêm phần rực rỡ và thu hút.
Dù là vào mùa hè nóng bức hay mùa đông lạnh giá, Triple Berry Cloud đều mang đến sự thỏa mãn cho mọi thực khách. Bạn sẽ cảm nhận được sự hài lòng khi thưởng thức một miếng bánh thơm ngon, nơi hương vị tươi mát của ba loại trái cây hòa quyện với kem mousse nhẹ nhàng, mang lại sự sảng khoái và hài lòng cho vị giác.', N'Triple Berry Cloud - một tuyệt phẩm bánh ngọt với ba loại trái cây tươi mát - dâu tây, mâm xôi và việt quất - kết hợp với lớp kem mousse nhẹ nhàng. Bánh mềm mịn và tươi sáng, mang đến trải nghiệm ẩm thực độc đáo và thanh mát.', 2, 'cloud-cake-5.png', 300000, 10, 8.6, '2023-7-01');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, Rating, PublicationDate)
VALUES (N'Mocha Cloud', N'Mocha Cloud là một tác phẩm bánh ngọt độc đáo, kết hợp giữa hương vị mạnh mẽ của cà phê và sự mềm mịn của kem mousse. Bánh mang đến một trải nghiệm ẩm thực thú vị, với hương thơm hấp dẫn và vị ngọt đắng hoàn hảo của hỗn hợp cà phê và kem.
Mocha Cloud có lớp bánh mềm mịn và màu nâu hấp dẫn, tượng trưng cho hương vị đậm đà của cà phê. Bề mặt bánh được phủ một lớp kem mousse mịn màng và bọt nhẹ, tạo ra một cảm giác mềm mại và êm ái trên đầu lưỡi. Quảng trí bánh bằng một lớp cacao hoặc hạt cà phê rang, tạo điểm nhấn màu sắc và hương vị đặc biệt.
Vị ngọt đắng của cà phê kết hợp với kem mousse mịn màng, tạo ra một hòa quyện ngọt ngào và cân bằng trên đầu lưỡi. Bánh có độ ẩm vừa phải, giúp bánh mềm mịn và giữ được hương vị đậm đà của cà phê. Hương vị cà phê đặc trưng và độ mịn của kem mousse tạo ra một trải nghiệm ẩm thực độc đáo và sôi động cho vị giác.
Mocha Cloud là lựa chọn hoàn hảo cho những người yêu thích hương vị cà phê mạnh mẽ và muốn thưởng thức một món tráng miệng độc đáo. Bạn có thể tận hưởng bánh một mình hoặc chia sẻ với người thân yêu. Bất kể mùa trong năm, Mocha Cloud đều là một món tráng miệng thú vị và hấp dẫn.
Dù là vào mùa hè nóng bức hay mùa đông lạnh giá, Mocha Cloud đều mang đến sự thỏa mãn cho mọi thực khách. Bạn sẽ cảm nhận được sự hài lòng khi thưởng thức một miếng bánh thơm ngon, nơi hương vị đậm đà của cà phê hòa quyện với kem mousse mịn màng, mang lại sự sảng khoái và hài lòng cho vị giác.', N'Mocha Cloud - một tác phẩm bánh ngọt độc đáo với hương vị mạnh mẽ của cà phê và sự mềm mịn của kem mousse. Bánh mềm mịn và hấp dẫn, mang đến trải nghiệm ẩm thực thú vị và đậm đà.', 2, 'cloud-cake-6.png', 320000, 10, 9.0, '2023-05-28');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, Rating, PublicationDate)
VALUES (N'Choco Cloud', N'Choco Cloud là một tuyệt phẩm bánh ngọt độc đáo, kết hợp giữa hương vị đậm đà của sô-cô-la và sự nhẹ nhàng của kem mousse. Bánh mang đến một trải nghiệm ẩm thực tuyệt vời, với vị ngọt ngào và hương thơm hấp dẫn của sô-cô-la.
Choco Cloud có lớp bánh mềm mịn và màu nâu hấp dẫn, tượng trưng cho hương vị đậm đà của sô-cô-la. Bề mặt bánh được phủ một lớp kem mousse mịn màng và bọt nhẹ, tạo ra một cảm giác mềm mại và êm ái trên đầu lưỡi. Sô-cô-la nhũy được thêm vào bên trên, tạo điểm nhấn màu sắc và thêm lớp vị sô-cô-la đặc biệt.
Vị ngọt đắng của sô-cô-la kết hợp với kem mousse mịn màng, tạo ra một hòa quyện ngọt ngào và cân bằng trên đầu lưỡi. Bánh có độ ẩm vừa phải, giúp bánh mềm mịn và giữ được hương vị đậm đà của sô-cô-la. Hương vị sô-cô-la đặc trưng và độ mịn của kem mousse tạo ra một trải nghiệm ẩm thực độc đáo và thỏa mãn cho vị giác.
Choco Cloud là lựa chọn hoàn hảo cho những người yêu thích sô-cô-la và muốn thưởng thức một món tráng miệng ngọt ngào và đậm đà. Bạn có thể tận hưởng bánh một mình hoặc chia sẻ với người thân yêu. Bất kể mùa trong năm, Choco Cloud đều là một món tráng miệng thú vị và hấp dẫn.
Dù là vào mùa hè nóng bức hay mùa đông lạnh giá, Choco Cloud đều mang đến sự thỏa mãn cho mọi thực khách. Bạn sẽ cảm nhận được sự hài lòng khi thưởng thức một miếng bánh thơm ngon, nơi hương vị đậm đà của sô-cô-la hòa quyện với kem mousse mịn màng, mang lại sự thưởng thức tuyệt vời và đáng nhớ cho vị giác.', N'Choco Cloud - một tuyệt phẩm bánh ngọt với hương vị đậm đà của sô-cô-la và sự nhẹ nhàng của kem mousse. Bánh mềm mịn và hấp dẫn, mang đến trải nghiệm ẩm thực tuyệt vời và ngọt ngào.', 2, 'cloud-cake-7.png', 350000, 10, 7.9, '2023-05-22');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, Rating, PublicationDate)
VALUES (N'Mango Cloud', N'Mango Cloud là một tuyệt phẩm bánh ngọt tươi mát và hấp dẫn, kết hợp giữa hương vị đặc trưng của trái xoài và sự nhẹ nhàng của kem mousse. Bánh mang đến một trải nghiệm ẩm thực độc đáo, với vị ngọt tự nhiên và hương thơm tươi mát của xoài.
Mango Cloud có lớp bánh mềm mịn và màu vàng sáng, tượng trưng cho sự tươi mới và sự tươi mát của trái xoài. Bề mặt bánh được phủ một lớp kem mousse nhẹ nhàng, tạo ra một cảm giác mềm mại và mịn màng trên đầu lưỡi. Miếng xoài tươi ngon được sắp xếp trên bề mặt bánh, tạo điểm nhấn màu sắc và hương vị tươi mát.
Vị ngọt tự nhiên và mát lạnh của xoài kết hợp với kem mousse nhẹ nhàng, tạo ra một hòa quyện ngọt ngào và thanh mát trên đầu lưỡi. Bánh có độ ẩm vừa phải, giúp bánh mềm mịn và giữ được hương vị tươi mát của xoài. Vị ngọt tự nhiên của xoài tươi ngon mang lại cảm giác thơm ngon và sảng khoái cho mỗi miếng bánh.
Mango Cloud là lựa chọn hoàn hảo cho những người yêu thích xoài và muốn thưởng thức một món tráng miệng tươi mát và ngọt ngào. Bạn có thể tận hưởng bánh một mình hoặc chia sẻ với người thân yêu. Bất kể mùa trong năm, Mango Cloud đều là một món tráng miệng thú vị và hấp dẫn.
Dù là vào mùa hè nóng bức hay mùa đông lạnh giá, Mango Cloud đều mang đến sự thỏa mãn cho mọi thực khách. Bạn sẽ cảm nhận được sự hài lòng khi thưởng thức một miếng bánh thơm ngon, nơi hương vị tươi mát của xoài hòa quyện với kem mousse mịn màng, mang lại sự sảng khoái và hài lòng cho vị giác.', N'Mango Cloud - một tuyệt phẩm bánh ngọt với hương vị tươi mát và đặc trưng của trái xoài, kết hợp với kem mousse nhẹ nhàng. Bánh mềm mịn và tươi sáng, mang đến trải nghiệm ẩm thực độc đáo và hấp dẫn.', 2, 'cloud-cake-8.png', 400000, 10, 9.3, '2023-04-11');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, Rating, PublicationDate)
VALUES (N'Heart Chocolate Cake', N'Bánh Heart Chocolate là một tác phẩm điêu khắc ngọt ngào và hoàn hảo để thể hiện tình yêu và sự lãng mạn. Khi nhìn vào bánh, bạn sẽ bị mê hoặc bởi vẻ đẹp đầy lôi cuốn của nó. Với lớp vỏ ngoài chocolate mịn màng và ánh kim tinh tế, bánh có hình dạng hình trái tim tinh tế, tỏa sáng với vẻ đẹp trọn vẹn và sự tinh tế.
Khi bạn chạm tay vào bề mặt mềm mịn của bánh, sự êm ái và mềm mại của chocolate sẽ chảy vào ngón tay bạn, đảm bảo một trải nghiệm thực sự thú vị cho giác quan của bạn. Hương thơm ngọt ngào của chocolate cảm nhận từ xa, hòa quyện với không gian xung quanh và tạo ra không khí lãng mạn và quyến rũ.
Mở bánh ra, bạn sẽ tiết lộ một cuộc hành trình đầy màu sắc của sự thưởng thức. Lớp chocolate đen đậm, đắm chìm trong vị ngọt của nó, hoàn hảo hòa quyện với lớp bánh mềm mịn và đặc biệt. Khi bạn cắt một miếng, bạn sẽ khám phá ra một trái tim chocolate nhỏ nằm ngay giữa, giống như trái tim ngọt ngào và thủy chung của tình yêu.
Với sự kết hợp hoàn hảo của hương vị, kết cấu và hình dạng, bánh Heart Chocolate trở thành một sự lựa chọn lý tưởng cho những dịp đặc biệt như ngày Valentine, kỷ niệm ngày cưới, sinh nhật hay chỉ đơn giản là khi bạn muốn tặng tình yêu của mình một món quà độc đáo và tuyệt vời. Hãy để bánh Heart Chocolate làm nổi bật tình yêu và tạo nên những kỷ niệm đáng nhớ trong trái tim của người thân yêu.', N'Bánh Heart Chocolate là một tác phẩm điêu khắc ngọt ngào mà bạn không thể cưỡng lại. Với lớp vỏ ngoài chocolate mịn màng, bánh có hình dạng hình trái tim tinh tế, khiến nó trở thành lựa chọn hoàn hảo cho các dịp lãng mạn như ngày Valentine, kỷ niệm ngày cưới hoặc bất kỳ dịp đặc biệt nào bạn muốn tặng tình yêu của mình.', 2, 'buttercream-cake-1.png', 500000, 10, 8.9, '2023-06-28');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, Rating, PublicationDate)
VALUES (N'Red Velvet Cake', N'Bánh Red Velvet là một tác phẩm nghệ thuật ẩm thực, kết hợp giữa vẻ đẹp và hương vị tinh tế. Với màu đỏ đặc trưng, bánh này gợi lên sự tự tin và thu hút ngay từ cái nhìn đầu tiên. Lớp vỏ ngoài mịn màng và màu đỏ rực rỡ tạo ra một bức tranh hấp dẫn, khiến ai nhìn vào cảm thấy tò mò và muốn khám phá sự ngọt ngào bên trong.
Khi bạn chạm vào bề mặt mềm mịn của bánh, sự êm ái và nhẹ nhàng của nó sẽ lấp đầy lòng bàn tay bạn. Khi bạn cắt một miếng bánh, màu đỏ nổi bật và mềm mịn của nó sẽ tỏa ra, tạo ra một hình ảnh hấp dẫn và độc đáo trên đĩa. Vị hương vani thơm ngon, hòa quyện với một chút hương cacao nhẹ, mang lại một hương vị tinh tế và độc đáo.
Với mỗi miếng bánh Red Velvet bạn thưởng thức, bạn sẽ được trải nghiệm một hỗn hợp hương vị tuyệt vời. Sự kết hợp hoàn hảo giữa độ ẩm và độ xốp của bánh, kết hợp với một lớp kem phô mai nhẹ nhàng hay kem tươi thơm ngon, tạo ra một hòa quyện vị giác đáng nhớ.
Bánh Red Velvet không chỉ là một món tráng miệng ngon lành, mà còn là biểu tượng của sự sang trọng và thanh lịch. Nó thích hợp cho bất kỳ dịp đặc biệt nào - từ tiệc cưới, sinh nhật, cho đến những buổi tiệc gia đình hoặc khi bạn chỉ đơn giản muốn thưởng thức một món tráng miệng đặc biệt. Bánh Red Velvet sẽ không chỉ đáp ứng sự mong đợi về vẻ đẹp và hương vị mà còn gợi lên cảm giác thăng hoa và hạnh phúc trong trái tim của bạn.', N'Bánh Red Velvet là một biểu tượng của sự sang trọng và thanh lịch. Với màu đỏ đặc trưng, bánh có vị hương vani thơm ngon và cấu trúc mềm mịn, tạo ra một trải nghiệm thưởng thức tuyệt vời.', 2, 'buttercream-cake-2.png', 380000, 10, 8.9, '2023-06-14');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, Rating, PublicationDate)
VALUES (N'Confetti Cake', N'Bánh Confetti là một tác phẩm nghệ thuật ẩm thực đích thực, đánh thức trẻ con trong mỗi chúng ta. Với lớp vỏ ngoài trắng mịn và những hạt nhiều màu sắc rải rác khắp bề mặt, bánh này tạo ra một khung cảnh vui nhộn và lôi cuốn. Màu sắc tươi sáng của những hạt confetti làm nổi bật bánh và khiến mọi người không thể rời mắt khỏi nó.
Khi bạn chạm vào bề mặt mềm mịn của bánh, bạn sẽ cảm nhận được sự mềm mại và tinh tế của nó. Khi cắt một miếng bánh, bạn sẽ khám phá ra những hạt confetti đa dạng và ngộ nghĩnh, tạo ra một cảm giác vui nhộn và trẻ trung. Vị hương vani ngọt ngào và hương vị nhẹ nhàng tạo nên một hỗn hợp thú vị, khiến mỗi miếng bánh trở thành một cuộc phiêu lưu hương vị.
Bánh Confetti không chỉ là một món tráng miệng ngon lành, mà còn là biểu tượng của niềm vui và sự phấn khích. Nó là lựa chọn hoàn hảo cho các buổi tiệc sinh nhật, kỷ niệm, hoặc bất kỳ dịp đặc biệt nào mà bạn muốn mang đến nụ cười cho mọi người. Bánh Confetti sẽ làm tăng tính vui nhộn và tạo nên những kỷ niệm đáng nhớ trong cuộc sống của bạn và những người thân yêu. Hãy để bánh Confetti mang đến niềm vui và sự hân hoan cho bữa tiệc của bạn.', N'Bánh Confetti là một món tráng miệng vui nhộn và đầy màu sắc. Với những hạt nhiều màu rải rác khắp bề mặt, bánh mang đến niềm vui và sự phấn khích cho mọi dịp đặc biệt.', 2, 'buttercream-cake-3.png', 240000, 10, 8.9, '2023-06-17');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, Rating, PublicationDate)
VALUES (N'Strawberry Sweet', N'Bánh Strawberry Sweet là một món tráng miệng thực sự quyến rũ, lấy cảm hứng từ hương vị tươi mát của dâu tươi. Với lớp vỏ bánh ngoài mịn màng và màu hồng nhẹ nhàng, bánh này mang đến một sự quyến rũ ngay từ cái nhìn đầu tiên. Mùi thơm ngọt ngào của dâu tươi thoang thoảng trong không khí, hứa hẹn một hành trình vị giác tuyệt vời.
Khi bạn chạm vào bề mặt mềm mịn của bánh, bạn sẽ cảm nhận được sự nhẹ nhàng và mềm mại của nó. Khi cắt một miếng bánh, màu hồng tươi sáng và mứt dâu bắn ra, tạo ra một cảm giác tươi mát và phấn khích. Vị hương dâu tươi độc đáo, kết hợp với kem tươi mềm mịn, tạo ra một hương vị ngọt ngào và tươi mát đặc biệt.
Bánh Strawberry Sweet là một lựa chọn tuyệt vời cho những người yêu thích hương vị dâu tươi và tìm kiếm một món tráng miệng ngon lành. Nó làm cho một sự kết hợp hoàn hảo cho các dịp như tiệc sinh nhật, họp mặt bạn bè hoặc chỉ đơn giản là để thưởng thức trong ngày hè nóng bức. Với hương vị tươi mát và ngọt ngào, bánh Strawberry Sweet sẽ chinh phục trái tim của bạn và mang lại niềm vui và hài lòng cho mọi người thưởng thức.', N'Strawberry Sweet là một món tráng miệng tuyệt vời, mang đến hương vị tươi ngon của dâu tươi. Với lớp vỏ ngoài mịn màng và lớp kem tươi thơm ngon, bánh này là lựa chọn hoàn hảo cho những người yêu thích hương vị ngọt ngào và tươi mát.', 2, 'buttercream-cake-4.png', 280000, 10, 8.9, '2023-06-17');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, Rating, PublicationDate)
VALUES (N'Peach Cream Piece', N'Peach Cream Piece là một tác phẩm ẩm thực tuyệt vời, kết hợp giữa vẻ đẹp và hương vị tươi ngon của đào và kem sữa mịn màng. Bánh có lớp vỏ ngoài mềm mịn, mang lại sự dễ chịu và êm ái khi bạn cắn vào từng miếng nhỏ.
Khi bạn chạm vào bề mặt mềm mịn của bánh, bạn sẽ cảm nhận được sự mềm mại và tinh tế của nó. Hương thơm của đào tươi ngon lan tỏa trong không gian, đưa bạn đến với những khu vườn đầy mùi hương. Mỗi miếng bánh mang một phần đào nhỏ, tươi mọng và độc đáo, tạo nên một trải nghiệm thưởng thức đặc biệt và đáng nhớ.
Lớp kem kem sữa mịn màng là điểm nhấn hoàn hảo cho bánh Peach Cream Piece. Với vị ngọt nhẹ và kem sữa mượt mà, nó tạo ra một sự kết hợp tuyệt vời với hương vị đào tươi ngon. Khi bạn thưởng thức mỗi miếng bánh, hương vị ngọt ngào của đào hòa quyện với kem sữa mịn, mang lại một sự thỏa mãn và hạnh phúc cho vị giác của bạn.
Bánh Peach Cream Piece không chỉ là một món tráng miệng thơm ngon, mà còn là một biểu tượng của sự tươi ngon và thanh lịch. Nó là sự lựa chọn hoàn hảo cho các buổi tiệc, dịp kỷ niệm hoặc chỉ đơn giản là để thưởng thức một món quà ngọt ngào cho bản thân. Bánh Peach Cream Piece sẽ mang đến sự hài lòng và niềm vui tuyệt đối cho bạn và những người thân yêu.', N'Peach Cream Piece là một món tráng miệng tinh tế và thơm ngon, kết hợp giữa hương vị đặc trưng của đào và kem sữa mịn màng. Với lớp vỏ ngoài mềm mịn và lớp kem kem đặc trưng, bánh này là một lựa chọn hoàn hảo để thưởng thức hương vị tươi ngon và thỏa mãn sự ngọt ngào trong lòng.', 2, 'piece-cake-1.png', 240000, 10, 8.9, '2023-06-14');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, Rating, PublicationDate)
VALUES (N'Orange Cream Piece', N'Orange Cream Piece là một miếng bánh nhỏ xinh đầy màu sắc và hương vị tươi mát của quả cam, kết hợp hoàn hảo với kem kem tươi nhẹ nhàng. Đây là một món tráng miệng độc đáo và ngon lành, mang đến trải nghiệm ẩm thực đầy thú vị và sảng khoái.
Orange Cream Piece có hình dạng hình vuông hoặc hình tròn nhỏ, với màu cam sáng và bề mặt mịn màng. Lớp kem kem tươi được phủ lên trên miếng bánh, tạo ra một hình ảnh hấp dẫn và mát lạnh. Chút trang trí từ vỏ cam tươi cắt nhỏ tạo thêm điểm nhấn màu sắc và sự tươi mát cho bánh.
Vị ngọt ngọt thanh của quả cam kết hợp với kem kem tươi nhẹ nhàng, tạo ra một hòa quyện tuyệt vời trên đầu lưỡi. Bánh có độ ẩm vừa phải, giúp bánh mềm mịn và giữ được vị tươi mát của quả cam. Vị cam tự nhiên đặc trưng mang lại cảm giác tươi mới và sảng khoái cho mỗi miếng bánh.
Orange Cream Piece là lựa chọn hoàn hảo cho những người thích thưởng thức một món tráng miệng nhẹ nhàng và ngọt ngào. Với kích thước nhỏ, bạn có thể thưởng thức miếng bánh này một mình hoặc chia sẻ với người thân yêu. Đây cũng là món tráng miệng lý tưởng cho các buổi tiệc hoặc dịp đặc biệt.
Dù là vào mùa hè nóng bức hay mùa đông lạnh giá, Orange Cream Piece đều mang đến sự thỏa mãn cho mọi thực khách. Bạn sẽ cảm nhận được sự hài lòng khi thưởng thức một miếng bánh nhỏ nhưng tràn đầy hương vị và màu sắc. Với Orange Cream Piece, bạn sẽ tận hưởng sự kết hợp độc đáo giữa vị cam tươi mát và sự nhẹ nhàng của kem kem tươi, tạo nên một trải nghiệm ẩm thực thú vị và đáng nhớ.', N'Orange Cream Piece - một miếng bánh nhỏ xinh với vị ngọt thanh của quả cam và sự nhẹ nhàng của kem kem tươi. Bánh mang đến trải nghiệm ẩm thực tươi mát và đầy màu sắc.', 2, 'piece-cake-2.png', 240000, 10, 8.9, '2023-06-20');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, Rating, PublicationDate)
VALUES (N'Chocolate Cloud Piece Cake', N'Chocolate Cloud Piece Cake là một tác phẩm ẩm thực đẳng cấp, mang đến hương vị sô-cô-la tinh tế và trải nghiệm mềm mại như những mảnh mây. Bánh có lớp vỏ ngoài sô-cô-la mịn màng, tạo ra một cảm giác mềm mại và êm ái khi bạn chạm vào.
Khi bạn chạm vào bề mặt mềm mịn của bánh, bạn sẽ cảm nhận được sự dễ chịu và nhẹ nhàng của nó. Mỗi miếng bánh như những mảnh mây sô-cô-la tan chảy trong miệng, mang đến một trải nghiệm thưởng thức độc đáo và đáng nhớ. Hương thơm sô-cô-la nồng nàn, hòa quyện với không gian xung quanh, tạo ra một không khí ngọt ngào và quyến rũ.
Lớp kem sữa béo ngậy là một điểm nhấn hoàn hảo cho bánh Chocolate Cloud Piece. Với vị ngọt nhẹ và độ kem mịn, nó tạo ra một sự kết hợp hoàn hảo với hương vị sô-cô-la. Khi bạn thưởng thức mỗi miếng bánh, sự hòa quyện giữa chocolate và kem sữa mời gọi, mang lại sự thỏa mãn và hạnh phúc tuyệt đối cho vị giác của bạn.
Bánh Chocolate Cloud Piece không chỉ là một món tráng miệng ngon lành, mà còn là biểu tượng của sự sang trọng và thanh lịch. Nó là lựa chọn hoàn hảo cho các dịp đặc biệt như sinh nhật, kỷ niệm hoặc chỉ đơn giản là để thưởng thức một món quà ngọt ngào cho bản thân. Bánh Chocolate Cloud Piece sẽ mang đến sự hài lòng và niềm vui tuyệt đối cho bạn và những người thân yêu.', N'Chocolate Cloud Piece Cake là một món bánh ngọt ngào và nhẹ nhàng, với hương vị sô-cô-la thượng hạng. Với lớp bên ngoài mịn màng và kem sữa béo ngậy, bánh mang đến cảm giác như đang thưởng thức những mảnh mây sô-cô-la ngọt ngào trên đầu lưỡi.', 2, 'piece-cake-3.png', 220000, 10, 8.9, '2023-06-17');
-- Insert Category -- 
INSERT INTO CATEGORY (CategoryName) VALUES (N'Cloud Cake');
INSERT INTO CATEGORY (CategoryName) VALUES (N'Buttercream Cake');
INSERT INTO CATEGORY (CategoryName) VALUES (N'Mousse Cake');
INSERT INTO CATEGORY (CategoryName) VALUES (N'Kids Cake');
INSERT INTO CATEGORY (CategoryName) VALUES (N'Piece Cake');
-- Insert Product Category -- 
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (1,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (2,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (3,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (4,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (5,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (6,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (7,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (8,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (9,2);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (10,2);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (11,2);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (12,2);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (13,2);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (14,2);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (15,2);

-- Tạo login
CREATE LOGIN adminCake WITH PASSWORD = 'admin123', DEFAULT_DATABASE = QLBB;

-- Tạo user 
-- Giả sử QLBB là cơ sở dữ liệu mục tiêu
CREATE USER adminCake FOR LOGIN adminCake;

-- Cấp quyền
GRANT SELECT, INSERT, UPDATE, DELETE ON CART_ITEM TO adminCake;
GRANT SELECT, INSERT, UPDATE, DELETE ON CATEGORY TO adminCake;
GRANT SELECT, INSERT, UPDATE, DELETE ON "ORDER" TO adminCake;
GRANT SELECT, INSERT, UPDATE, DELETE ON ORDER_SHIPPING_METHOD TO adminCake;
GRANT SELECT, INSERT, UPDATE, DELETE ON ORDER_STATUS TO adminCake;
GRANT SELECT, INSERT, UPDATE, DELETE ON PRODUCT TO adminCake;
GRANT SELECT, INSERT, UPDATE, DELETE ON PRODUCT_CATEGORY TO adminCake;
GRANT SELECT, INSERT, UPDATE, DELETE ON PRODUCT_TAG TO adminCake;
GRANT SELECT, INSERT, UPDATE, DELETE ON ROLE TO adminCake;
GRANT SELECT, INSERT, UPDATE, DELETE ON SALES TO adminCake;
GRANT SELECT, INSERT, UPDATE, DELETE ON SALES_DETAIL TO adminCake;
GRANT SELECT, INSERT, UPDATE, DELETE ON SHOPPING_CART TO adminCake;
GRANT SELECT, INSERT, UPDATE, DELETE ON TAG TO adminCake;
GRANT SELECT, INSERT, UPDATE, DELETE ON "USER" TO adminCake;
GRANT SELECT, INSERT, UPDATE, DELETE ON USER_PAYMENT TO adminCake;
GRANT SELECT, INSERT, UPDATE, DELETE ON USER_ROLE TO adminCake;
GRANT SELECT, INSERT, UPDATE, DELETE ON USER_SHIPPING TO adminCake;
