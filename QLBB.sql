CREATE DATABASE QLBB;
/* Chạy file Datadase này */
USE QLBB;

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
   PublicationDate DATE NULL,
   CONSTRAINT PK_PRODUCT PRIMARY KEY (ProductID)
);
/* Table: CATEGORY */
CREATE TABLE CATEGORY (
   CategoryID INT NOT NULL IDENTITY(1,1),
   CategoryName NVARCHAR(300) NULL,
   Description NVARCHAR(MAX) NULL,
   CreatedDate DATE NULL,
   ParentID INT NULL,
   CONSTRAINT PK_CATEGORY PRIMARY KEY (CategoryID)
);
/* Table: PRODUCT_CATEGORY */
CREATE TABLE PRODUCT_CATEGORY (
   ProductID INT NOT NULL,
   CategoryID INT NOT NULL,
   CONSTRAINT PK_PRODUCT_CATEGORY PRIMARY KEY (ProductID, CategoryID)
);
/* Table: TAG */
CREATE TABLE TAG (
   TagID INT NOT NULL IDENTITY(1,1),
   TagName NVARCHAR(300) NULL,
   CONSTRAINT PK_TAG PRIMARY KEY (TagID)
);
/* Table: PRODUCT_TAG */
CREATE TABLE PRODUCT_TAG (
   ProductID INT NOT NULL,
   TagID INT NOT NULL,
   CONSTRAINT PK_PRODUCT_TAG PRIMARY KEY (ProductID, TagID)
);
/* Table: CART_ITEM */
CREATE TABLE CART_ITEM (
   CartItemID INT NOT NULL IDENTITY(1,1),
   Quantity INT NOT NULL,
   Subtotal FLOAT NOT NULL,
   ProductID INT NOT NULL,
   ShoppingCartID INT NOT NULL,
   CONSTRAINT PK_CART_ITEM PRIMARY KEY (CartItemID)
);
/* Table: SHOPPING_CART */
CREATE TABLE SHOPPING_CART (
   ShoppingCartID INT NOT NULL IDENTITY(1,1),
   GrandTotal FLOAT NULL,
   UserID INT NULL,
   CONSTRAINT PK_SHOPPING_CART PRIMARY KEY (ShoppingCartID)
);
CREATE TABLE WISH_LIST_ITEM (
   WishListItemID INT NOT NULL IDENTITY(1,1),
   ProductID INT NOT NULL,
   AddedDate DATE NOT NULL,
   UserID INT NOT NULL,
   CONSTRAINT PK_WISH_LIST_ITEM PRIMARY KEY (WishListItemID)
);
/* Table: "ORDER" */
CREATE TABLE "ORDER" (
   OrderID INT NOT NULL IDENTITY(1,1),
   OrderDate DATETIME NULL,
   OrderStatus NVARCHAR(300) NOT NULL,
   ShippingMethod NVARCHAR(300) NOT NULL,
   PaymentStatus NVARCHAR(300) NOT NULL,
   ShippingDate DATETIME NULL,
   OrderTotal FLOAT NULL,
   DeliveryAddress NVARCHAR(MAX) NOT NULL,
   Payment NVARCHAR(200),
   UserID INT NULL,
   CONSTRAINT PK_ORDER PRIMARY KEY (OrderID)
);
CREATE TABLE "ORDER_DETAIL"(
	OrderID INT NOT NULL,
	ProductID INT NOT NULL,
	Quantity INT NOT NULL,
	ProductPrice Float NOT NULL,
	CONSTRAINT PK_ORDER_DETAIL PRIMARY KEY (OrderID,ProductID)
)
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
/* Table: PAYMENT_STATUS */
CREATE TABLE PAYMENT_STATUS (
   PaymentStatus NVARCHAR(300) NOT NULL,
   CONSTRAINT PK_PAYMENT_STATUS PRIMARY KEY (PaymentStatus)
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
   "Percent" FLOAT NULL,
   CONSTRAINT PK_SALES_DETAIL PRIMARY KEY (SalesID, OrderID)
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
/* Table: ROLE */
CREATE TABLE "ROLE" (
   RoleID INT NOT NULL IDENTITY(1,1),
   RoleName VARCHAR(100) NULL,
   CONSTRAINT PK_ROLE PRIMARY KEY (RoleID)
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
   Country NVARCHAR(500) NULL,
   City NVARCHAR(500) NULL,
   District NVARCHAR(500) NULL,
   Ward NVARCHAR(500) NULL,
   Street NVARCHAR(500) NULL,
   DefaultShipping BIT NULL,
   UserID INT NULL,
   CONSTRAINT PK_USER_SHIPPING PRIMARY KEY (UserShippingID)
);
/* Table: USER_PAYMENT */
CREATE TABLE USER_PAYMENT (
   UserPaymentID INT NOT NULL IDENTITY(1,1),
   BankName NVARCHAR(300) NULL,
   CardNumber VARCHAR(20) NULL,
   DefaultPayment BIT NULL,
   HolderName NVARCHAR(300) NULL,
   TypeID INT NULL,
   UserID INT NULL,
   CONSTRAINT PK_USER_PAYMENT PRIMARY KEY (UserPaymentID)
);
/* Table: CARD_TYPE */
CREATE TABLE CARD_TYPE (
   TypeID INT NOT NULL IDENTITY(1,1),
   "Type" NVARCHAR(150) NULL,
   CONSTRAINT PK_CARD_TYPE PRIMARY KEY (TypeID)
);

/* Table: CARD_TYPE */
CREATE TABLE DISCOUNT (
   DiscountID INT NOT NULL IDENTITY(1,1),
   DiscountCode NVARCHAR(50) UNIQUE,
   DiscountName NVARCHAR(255),
   DiscountPercentage INT,
   StartDate DATE,
   EndDate DATE,
   CONSTRAINT PK_DISCOUNT PRIMARY KEY (DiscountID)
);

/* Ràng buộc khóa ngoại */
ALTER TABLE PRODUCT
   ADD CONSTRAINT FK_PRODUCT_REFERENCE_DISCOUNT FOREIGN KEY (DISCOUNT)
      REFERENCES DISCOUNT (DiscountID);

ALTER TABLE CART_ITEM
   ADD CONSTRAINT FK_CART_ITEM_REFERENCE_SHOPPING FOREIGN KEY (ShoppingCartID)
      REFERENCES SHOPPING_CART (ShoppingCartID);

ALTER TABLE CART_ITEM
   ADD CONSTRAINT FK_CART_ITEM_REFERENCE_PRODUCT FOREIGN KEY (ProductID)
      REFERENCES PRODUCT (ProductID);

ALTER TABLE ORDER_DETAIL
   ADD CONSTRAINT FK_ORDER_DETAIL_REFERENCE_ORDER FOREIGN KEY (OrderID)
      REFERENCES "ORDER" (OrderID);

ALTER TABLE ORDER_DETAIL
   ADD CONSTRAINT FK_ORDER_DETAIL_REFERENCE_PRODUCT FOREIGN KEY (ProductID)
      REFERENCES PRODUCT (ProductID);

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

ALTER TABLE "ORDER"
   ADD CONSTRAINT FK_ORDER_REFERENCE_PAYMENT_STATUS FOREIGN KEY (PaymentStatus)
      REFERENCES PAYMENT_STATUS (PaymentStatus);

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

ALTER TABLE WISH_LIST_ITEM
   ADD CONSTRAINT FK_WISH_LIST_ITEM_REFERENCE_PRODUCT FOREIGN KEY (ProductID)
      REFERENCES PRODUCT (ProductID);

ALTER TABLE WISH_LIST_ITEM
   ADD CONSTRAINT FK_WISH_LIST_ITEM_REFERENCE_WISH FOREIGN KEY (UserID)
      REFERENCES "USER" (UserID);

/* Trigger: Month trong Sales chỉ thuộc khoảng 1 đến 12 */
CREATE TRIGGER TR_SALES_MonthConstraint
ON SALES
AFTER INSERT, UPDATE
AS
BEGIN
    -- Check for values in the range 1 to 12 for the Month attribute
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE i.Month < 1 OR i.Month > 12
    )
    BEGIN
        RAISERROR(N'Giá trị Month không hợp lệ, Month phải từ 1 đến 12.', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END
    
    -- Check for any changes in the Month attribute during UPDATE
    IF UPDATE(Month)
    BEGIN
        IF EXISTS (
            SELECT 1
            FROM inserted i
            WHERE i.Month < 1 OR i.Month > 12
        )
        BEGIN
            RAISERROR(N'Giá trị Month không hợp lệ, Month phải từ 1 đến 12', 16, 1)
            ROLLBACK TRANSACTION;
            RETURN;
        END
    END
END
/* Trigger: Quantity trong Cart_Item phải có giá trị lớn hơn bằng 1*/
CREATE TRIGGER TR_CART_ITEM_QuantityConstraint
ON CART_ITEM
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE i.Quantity < 1
    )
    BEGIN
        RAISERROR(N'Giá trị Quantity không hợp lệ, Quantity phải lớn hơn hoặc bằng 1', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END
END
/* Trigger: Username va Email không được trùng lặp */
ALTER TABLE "USER"
	ADD CONSTRAINT UQ_UserName UNIQUE (UserName);
ALTER TABLE "USER"
	ADD CONSTRAINT UQ_Email UNIQUE (Email);
/* Trigger: Tên sản phẩm không trùng */
ALTER TABLE PRODUCT
	ADD CONSTRAINT UQ_PRODUCT_ProductName UNIQUE (ProductName);
/* Trigger: Tên danh mục không trùng */
ALTER TABLE CATEGORY
	ADD CONSTRAINT UQ_CATEGORY_CategoryName UNIQUE (CategoryName);
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

/* Trigger: Số tiền trên một cart item */
CREATE TRIGGER UpdateSubTotal
ON CART_ITEM
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra nếu có sự thay đổi trong CART_ITEM
    IF (EXISTS (SELECT 1 FROM inserted) OR EXISTS (SELECT 1 FROM deleted))
    BEGIN
        -- Cập nhật giá SubTotal cho các mục giỏ hàng
        UPDATE ci
        SET SubTotal = ci.Quantity * (p.Price - (p.Price * ISNULL(d.DiscountPercentage, 0) / 100))
        FROM CART_ITEM ci
		INNER JOIN inserted i ON ci.CartItemID = i.CartItemID
        INNER JOIN PRODUCT p ON ci.ProductId = p.ProductId
        LEFT JOIN DISCOUNT d ON p.Discount = d.DiscountID
        WHERE ci.CartItemId IN (SELECT CartItemId FROM inserted) OR ci.CartItemId IN (SELECT CartItemId FROM deleted);
    END
END;
/* Tiền sản phẩm (ProductPrice) trong chi tiết hóa đơn */
CREATE TRIGGER UpdateProductPrice
ON ORDER_DETAIL
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE od
    SET ProductPrice = p.Price - (p.Price * ISNULL(d.DiscountPercentage, 0) / 100)
    FROM ORDER_DETAIL od
    INNER JOIN inserted i ON od.OrderID = i.OrderID
    INNER JOIN PRODUCT p ON od.ProductID = p.ProductID
    LEFT JOIN DISCOUNT d ON p.Discount = d.DiscountID;
END;

/* Trigger: Tổng tiền đơn hàng (OrderTotal) */
CREATE TRIGGER TR_ORDER_TOTAL_VALIDITY
ON "ORDER"
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE o
    SET OrderTotal = ISNULL((
        SELECT SUM(Quantity * ProductPrice)
        FROM ORDER_DETAIL od
        WHERE od.OrderID = o.OrderID
    ), 0)
    FROM "ORDER" o
    INNER JOIN INSERTED i ON o.OrderID = i.OrderID;
END;

CREATE TRIGGER TR_ORDER_DETAIL_UPDATE_ORDER_TOTAL
ON ORDER_DETAIL
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @OrderID INT;

    -- Lấy danh sách các OrderID bị ảnh hưởng bởi INSERT hoặc UPDATE
    SELECT @OrderID = OrderID
    FROM inserted;

    -- Cập nhật giá trị OrderTotal cho các đơn hàng ảnh hưởng
    UPDATE "ORDER"
    SET OrderTotal = ISNULL((
        SELECT SUM(Quantity * ProductPrice)
        FROM ORDER_DETAIL od
        WHERE od.OrderID = @OrderID
    ), 0)
    WHERE OrderID = @OrderID;
END;

/* Trigger: Tổng tiền doanh thu*/
CREATE TRIGGER TR_SALES_TOTAL_VALIDITY
ON SALES
FOR INSERT, UPDATE
AS
BEGIN
	UPDATE SALES
	SET SalesAmount =
	(
	  SELECT SUM(o.OrderTotal)
	  FROM SALES_DETAIL s
	  JOIN "ORDER" o ON s.OrderId = o.OrderId
	  WHERE s.SalesId IN (
		SELECT SalesId
		FROM INSERTED
		UNION
		SELECT SalesId
		FROM DELETED
	  )
	);
END;

/* Trigger: Tỷ lệ hóa đơn trên chi tiết doanh thu */
CREATE TRIGGER TR_SALES_DETAIL_CHECK
ON SALES_DETAIL
AFTER INSERT, UPDATE
AS
BEGIN
	UPDATE SALES_DETAIL
	SET "Percent" =
	(
	  SELECT o.OrderTotal / s.SalesAmount
	  FROM "ORDER" o, SALES s
	  WHERE SALES_DETAIL.SalesID = s.SalesID
	  AND SALES_DETAIL.OrderID = o.OrderID
	);
END

/* Trigger: Giá trị DefaultShipping trong bảng USER_SHIPPING */
CREATE TRIGGER trg_SetDefaultShipping
ON USER_SHIPPING
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON; 

    IF UPDATE(DefaultShipping)
    BEGIN
        DECLARE @UserShippingID INT;

        DECLARE cursorUpdatedAddresses CURSOR FOR
        SELECT UserShippingID
        FROM inserted
        WHERE DefaultShipping = 1;

        OPEN cursorUpdatedAddresses;

        FETCH NEXT FROM cursorUpdatedAddresses INTO @UserShippingID;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            UPDATE us
            SET DefaultShipping = 0
            FROM USER_SHIPPING us
            INNER JOIN inserted i ON us.UserID = i.UserID
            WHERE i.DefaultShipping = 1
              AND us.UserShippingID <> i.UserShippingID
              AND us.UserShippingID <> @UserShippingID;
            FETCH NEXT FROM cursorUpdatedAddresses INTO @UserShippingID;
        END;

        CLOSE cursorUpdatedAddresses;
        DEALLOCATE cursorUpdatedAddresses;
    END
END

/* Trigger: Giá trị DefaultPayment trong bảng USER_PAYMENT */
CREATE TRIGGER trg_SetDefaultPayment
ON USER_PAYMENT
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(DefaultPayment)
    BEGIN
        DECLARE @UserPaymentID INT;

        DECLARE cursorUpdatedPayments CURSOR FOR
        SELECT UserPaymentID
        FROM inserted
        WHERE DefaultPayment = 1;

        OPEN cursorUpdatedPayments;

        FETCH NEXT FROM cursorUpdatedPayments INTO @UserPaymentID;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            UPDATE up
            SET DefaultPayment = 0
            FROM USER_PAYMENT up
            INNER JOIN inserted i ON up.UserID = i.UserID
            WHERE i.DefaultPayment = 1
              AND up.UserPaymentID <> i.UserPaymentID
              AND up.UserPaymentID <> @UserPaymentID;

            FETCH NEXT FROM cursorUpdatedPayments INTO @UserPaymentID;
        END;	

        CLOSE cursorUpdatedPayments;
        DEALLOCATE cursorUpdatedPayments;
    END
END;


-- Insert Role -- 
INSERT INTO [ROLE] (RoleName)
VALUES ('Administrator');
INSERT INTO [ROLE] (RoleName)
VALUES ('User');

-- Insert User --
-- admin: admin
-- pass: 123456qC

-- user: kieutrang
-- pass: 123456qC --
INSERT INTO [User] (FirstName, LastName, Email, UserName, Password, Telephone)
VALUES ('Trang', 'Huynh', 'admin@gmail.com', 'admin', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0329917237')
INSERT INTO "USER" (FirstName, LastName, Email, UserName, Password, Telephone)
VALUES
   (N'Trang', N'Huỳnh Thị Kiều', 'trang158@gmail.com', 'trang158', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0329917237'),
   (N'Tuyết', N'Trần Thị Ánh', 'tuyet205@gmail.com', 'tuyet205', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0568872226'),
   (N'Dung', N'Võ Thị Mỹ', 'dung504@gmail.com', 'dung504', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0982253486'),
   (N'Ái', N'Nguyễn Lê Nhã', 'nhaai105@gmail.com', 'nhaai105', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0734458923'),
   (N'Liên', N'Bùi Thị Liên', 'lien305@gmail.com', 'lien305', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0848837245'),
   (N'Tân', N'Huỳnh Duy', 'tan202@gmail.com', 'tan202', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0376345235'),
   (N'Luân', N'Nguyễn Ngọc', 'luan308@gmail.com', 'luan308', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0837762467'),
   (N'Duyên', N'Trương Thị Mỹ', 'duyen142@gmail.com', 'duyen142', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0366458726'),
   (N'Ngọc', N'Hà Thị Mỹ', 'ngoc175@gmail.com', 'ngoc175', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0747546235'),
   (N'Hải', N'Võ Văn', 'hai129@gmail.com', 'hai129', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0647728946'),
   (N'Lâm', N'Nguyễn Văn', 'lam304@gmail.com', 'lam304', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0367258359'),
   (N'Tuấn', N'Hà Anh', 'tuan708@gmail.com', 'tuan708', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0896583471'),
   (N'Thành', N'Huỳnh Văn', 'thanh408@gmail.com', 'thanh408', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0837745142'),
   (N'Kiều', N'Giáp Thị', 'kieu128@gmail.com', 'kieu128', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0853381563'),
   (N'Trinh', N'Thái Ngọc', 'trinh412@gmail.com', 'trinh412', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0548836295'),
   (N'Khá', N'Lê Minh', 'kha607@gmail.com', 'kha607', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0372296165'),
   (N'Hiền', N'Nguyễn Thị', 'hien092@gmail.com', 'hien092', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0863872481'),
   (N'Viên', N'Nguyễn Mai', 'vien811@gmail.com', 'vien811', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0365926418'),
   (N'Tiên', N'Nguyễn Thúc Thuỳ', 'tien1306@gmail.com', 'tien1306', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0541472904'),
   (N'Nhi', N'Hồng Hài', 'nhi1809@gmail.com', 'nhi1809', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0327305629'),
   (N'Phong', N'Lê Hữu Phong', 'phong0712@gmail.com', 'phong0712', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0571843967'),
   (N'Nguyên', N'Thái Ngọc Thảo', 'nguyen905@gmail.com', 'nguyen905', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0957251479'),
   (N'Binh', N'Lê Bảo', 'binh1801@gmail.com', 'binh1801', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0362851639'),
   (N'Trường', N'Võ Văn', 'truong0808@gmail.com', 'truong0808', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0548752618'),
   (N'Tuất', N'Huỳnh Anh', 'tuat2608@gmail.com', 'tuat2608', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0328751157'),
   (N'Loan', N'Nguyễn Thị', 'loan407@gmail.com', 'loan407', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0287715239'),
   (N'Bé', N'Bùi Thị', 'be1309@gmail.com', 'be1309', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0368826459'),
   (N'Ngọc', N'Hoàng Bảo', 'ngoc611@gmail.com', 'ngoc611', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0372851736'),
   (N'Tú', N'Nguyễn Thị', 'tu3112@gmail.com', 'tu3112', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0986741453'),
   (N'Quỳnh', N'Nguyễn Như', 'quynh1010@gmail.com', 'quynh1010', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0529973529'),
   (N'Uyên', N'Nguyễn Thị Phương', 'uyen1606@gmail.com', 'uyen1606', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0582204672'),
   (N'Nhàn', N'Triệu Thị Thanh Nhàn', 'nhan2509@gmail.com', 'nhan2509', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0849762564'),
   (N'Anh', N'Đặng Thị Tú', 'anh1304@gmail.com', 'anh1304', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0348761264'),
   (N'Hiếu', N'Đoàn Vọng', 'hieu2402@gmail.com', 'hieu2402', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0375293192'),
   (N'Sơn', N'Thái Ngọc', 'son1101@gmail.com', 'son1101', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0258642753'),
   (N'Hương', N'Hoàng Mai', 'huong3012@gmail.com', 'huong3012', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0354472456'),
   (N'Mai', N'Nguyễn Thị', 'mai801@gmail.com', 'mai801', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0653392752'),
   (N'Hường', N'Lưu Thị', 'huong1211@gmail.com', 'huong1211', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0352895417'),
   (N'Huy', N'Lê Minh', 'huy0101@gmail.com', 'huy0101', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0629916382'),
   (N'Mơ', N'Nguyễn Thị', 'mo1703@gmail.com', 'mo1703', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0828636511'),
   (N'Tiên', N'Hà Thị', 'tien0303@gmail.com', 'tien0303', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0356128452'),
   (N'Hân', N'Lê Bảo', 'han1906@gmail.com', 'han1906', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0872264319'),
   (N'Duy', N'Phan Mạnh', 'duy0302@gmail.com', 'duy0302', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0538861572'),
   (N'Linh', N'Trần Duy', 'linh0909@gmail.com', 'linh0909', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0857631973'),
   (N'Nhung', N'Trần Thị Cẩm', 'nhung0805@gmail.com', 'nhung0805', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0347761238'),
   (N'Giang', N'Võ Văn', 'giang0605@gmail.com', 'giang0605', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0854872543'),
   (N'Hoa', N'Lê Thị', 'hoa2901@gmail.com', 'hoa2901', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0386651723'),
   (N'Hát', N'Võ Văn', 'hat0505@gmail.com', 'hat0505', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0562849915'),
   (N'Đức', N'Trần Văn', 'duc2304@gmail.com', 'duc2304', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0941846725'),
   (N'Hy', N'Phạm Đức', 'hy1105@gmail.com', 'hy1105', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0857716235'),
   (N'Nguyên', N'Lê Đình', 'nguyen0408@gmail.com', 'nguyen0408', '2e4a1210c0dba6e4e6882a40ec773c19467fccb66a9a3049c010320d7a966b07', '0927651635');
-- Insert User_Role --
INSERT INTO [USER_ROLE] (RoleID, UserID) VALUES (1, 1);
INSERT INTO [USER_ROLE] (RoleID, UserID)
VALUES
(2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (2, 8), (2, 9),
(2, 10), (2, 11), (2, 12), (2, 13), (2, 14),
(2, 15), (2, 16), (2, 17), (2, 18), (2, 19),
(2, 20), (2, 21), (2, 22), (2, 23), (2, 24),
(2, 25), (2, 26), (2, 27), (2, 28), (2, 29),
(2, 30), (2, 31), (2, 32), (2, 33), (2, 34),
(2, 35), (2, 36), (2, 37), (2, 38), (2, 39),
(2, 40), (2, 41), (2, 42), (2, 43), (2, 44),
(2, 45), (2, 46), (2, 47), (2, 48), (2, 49),
(2, 50), (2, 51), (2, 52);

INSERT INTO [SHOPPING_CART] (GrandTotal, UserID)
VALUES
(0, 2),(0, 3),(0, 4),(0, 5), (0, 6), (0, 7), (0, 8), (0, 9),
(0, 10), (0, 11), (0, 12), (0, 13), (0, 14),
(0, 15), (0, 16), (0, 17), (0, 18), (0, 19),
(0, 20), (0, 21), (0, 22), (0, 23), (0, 24),
(0, 25), (0, 26), (0, 27), (0, 28), (0, 29),
(0, 30), (0, 31), (0, 32), (0, 33), (0, 34),
(0, 35), (0, 36), (0, 37), (0, 38), (0, 39),
(0, 40), (0, 41), (0, 42), (0, 43), (0, 44),
(0, 45), (0, 46), (0, 47), (0, 48), (0, 49),
(0, 50), (0, 51), (0, 52);

INSERT INTO USER_SHIPPING (Country, City, District, Ward, Street, DefaultShipping, UserID)
VALUES
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 9', N'Phường Tăng Nhơn Phú A', N'21 Hẻm D6', 1, 2),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 1', N'Phường Đa Kao', N'Số 12 Đường Tôn Đức Thắng', 1, 3),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 1', N'Phường Phạm Ngũ Lão', N'Số 45 Đường Nguyễn Trãi', 1, 4),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 1', N'Phường Phạm Ngũ Lão', N'Số 27 Đường Hai Bà Trưng', 1, 5),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 1', N'Phường Phạm Ngũ Lão', N'Số 19 Đường Lê Duẩn', 1, 6),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 1', N'Phường Tân Định', N'Số 67 Đường Nguyễn Thái Bình', 1, 7),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 1', N'Phường Tân Định', N'Số 32 Đường Lý Tự Trọng', 1, 8),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 1', N'Phường Tân Định', N'Số 15 Đường Nguyễn Hữu Cảnh', 1, 9),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 3', N'Phường Bến Thành', N'Số Đường Võ Thị Sáu', 1, 10),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 3', N'Phường Bến Thành', N'Số 14 Đường Nam Kỳ Khởi Nghĩa', 1, 11),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 3', N'Phường Bến Thành', N'Số 26 Đường Điện Biên Phủ', 1, 12),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 5', N'Phường 12', N'Số 86 Tân Hưng', 1, 13),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 5', N'Phường 6', N'Số 10 Nguyễn Tri Phương', 1, 14),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 5', N'Phường 12', N'Số 190 Thuận Kiều', 1, 15),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 3', N'Phường 11', N'590 Cách Mạng Tháng 8', 1, 16),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 10', N'Phường 12', N'Số 456 Đường Ba Tháng Hai', 1, 17),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 3', N'Phường 14', N'Số 398 Lê Văn Sỹ', 1, 18),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 10', N'Phường 12', N'Số 200 Đường 3/2', 1, 19),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 1', N'Phường Tân Định', N'Số 300 Hai Bà Trưng', 1, 20),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 3', N'Phường 4', N'Số 134 Đường Cao Thắng', 1, 21),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận Tân Bình', N'Phường 1', N'Số 300 Nguyễn Trọng Tuyển', 1, 22),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 3', N'Phường 1', N'Số 33 Đường Lý Tự Trọng', 1, 23),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 3', N'Phường Võ Thị Sáu', N'Số 16 Đường Nguyễn Thị Minh Khai', 1, 24),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 3', N'Phường Võ Thị Sáu', N'Số 28 Đường Pasteur', 1, 25),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 3', N'Phường Võ Thị Sáu', N'Số 10 Đường Bà Huyện Thanh Quan', 1, 26),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 3', N'Phường 6', N'Số 44 Đường Cách Mạng Tháng Tám', 1, 27),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 3', N'Phường 6', N'Số 27 Đường Nguyễn Du', 1, 28),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 3', N'Phường 6', N'Số 19 Đường Trần Hưng Đạo', 1, 29),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 4', N'Phường 1', N'Số 66 Đường Nguyễn Tất Thành', 1, 30),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 4', N'Phường 1', N'Số 32 Đường Tôn Thất Thuyết', 1, 31),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 4', N'Phường 1', N'Số 15 Đường Hoàng Diệu', 1, 32),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 4', N'Phường 2', N'Số 22 Đường Đoàn Văn Bơ', 1, 33),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 4', N'Phường 2', N'Số 14 Đường Đề Thám', 1, 34),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 4', N'Phường 2', N'Số 26 Đường Nguyễn Hữu Huân', 1, 35),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 4', N'Phường 3', N'Số 33 Đường Nguyễn Văn Cừ', 1, 36),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 4', N'Phường 3', N'Số 16 Đường Khánh Hội', 1, 37),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 4', N'Phường 3', N'Số 28 Đường Ký Con', 1, 38),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 2', N'Phường Thạnh Mỹ Lợi', N'Số 125 Đồng Văn Cống', 1, 39),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 1', N'Phường Bến Nghé', N'Số 2 Nguyễn Bỉnh Khiêm', 1, 40),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 2', N'Phường Thảo Điền', N'63 Xa lộ Hà Nội', 1, 41),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 7', N'Phường Tân Phú', N'582/12 Huỳnh Tấn Phát', 1, 42),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 9', N'Phường Tân Phú', N'Số 120 Xa Lộ Hà Nội', 1, 43),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 9', N'Phường Trường Thạnh', N'Số 191 Đường Tam Đa', 1, 44),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 11', N'Phường 3', N'Số 3 Hòa Bình', 1, 45),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 2', N'Phường Thảo Điền', N'Số 18/1 Nguyễn Văn Hưởng', 1, 46),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 1', N'Phường Bến Nghé', N'Số 2 Nguyễn Bỉnh Khiêm', 1, 47),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 1', N'Phường Bến Nghé', N'Số 19-25 Nguyễn Huệ', 1, 48),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 1', N'Phường Nguyễn Thái Bình', N'Số 79 Nguyễn Thái Bình', 1, 49),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 1', N'Phường Tân Định', N'Số 83 Nguyễn Phi Khanh', 1, 50),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 3', N'Phường 9', N'Số 130 Nguyễn Phúc Nguyên', 1, 51),
(N'Việt Nam', N'Hồ Chí Minh', N'Quận 4', N'Phường 9', N'Số 146 Hoàng Diệu', 1, 52);


-- Insert Discount --
INSERT INTO DISCOUNT (DiscountCode, DiscountName, DiscountPercentage, StartDate, EndDate)
VALUES ('YUMMY10', N'Discount giảm 10%', 10, '2023-01-01', '2023-12-31');
INSERT INTO DISCOUNT (DiscountCode, DiscountName, DiscountPercentage, StartDate, EndDate)
VALUES ('YUMMY20', N'Discount giảm 20%', 20, '2023-02-01', '2023-11-30');
INSERT INTO DISCOUNT (DiscountCode, DiscountName, DiscountPercentage, StartDate, EndDate)
VALUES ('YUMMY5', N'Discount giảm 5%', 5, '2023-03-01', '2023-10-31');

-- Insert Product --
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh kem trà xanh', N'Bánh Kem Trà Xanh mang trong mình một sự kết hợp tinh tế giữa lớp bánh bông lan mềm mịn vị trà xanh và lớp kem trà xanh ngọt thanh, thơm béo. Khi thưởng thức, chỉ cần xắn một muỗng nhỏ, miếng đầu tiên sẽ khiến bạn ngay lập tức bị cuốn hút bởi hương thơm thoang thoảng và vị chan chát đậm đà của trà xanh, hoà quyện với vị đăng đắng, nồng nàn của socola. Hy vọng Bánh Kem Trà Xanh sẽ mang lại cho bạn những giây phút trọn vẹn và những kỷ niệm đáng nhớ trong bữa tiệc sắp tới. Đừng chần chừ, hãy đặt ngay và trải nghiệm hương vị tuyệt vời này nhé!', N'Bánh Kem Trà Xanh mang trong mình một sự kết hợp tinh tế giữa lớp bánh bông lan mềm mịn vị trà xanh và lớp kem trà xanh ngọt thanh, thơm béo.', 6, 'banh-kem-tra-xanh.jpg', 230000, 1, '2023-06-30');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh kem vị đào', N'Bánh kem đào là một loại bánh ngọt được làm từ lớp bánh bông lan mềm mịn, nhân kem đào thơm mát và phủ bên ngoài là lớp đào tươi giòn ngọt. Bánh có hương vị ngọt ngào, thanh mát, rất thích hợp cho những ngày hè nóng bức. Phần bánh bông lan thường được làm từ bột mì, trứng gà, sữa tươi, đường, vani và một số nguyên liệu khác. Bánh được nướng chín vàng đều, có độ mềm mịn và xốp nhẹ. Phần kem đào được làm từ kem tươi, sữa tươi, đường và đào tươi. Kem có vị ngọt dịu, thơm mùi đào và béo ngậy. Phần đào tươi được cắt lát mỏng hoặc tỉa hoa trang trí trên mặt bánh. Đào tươi có vị chua ngọt tự nhiên, giúp cân bằng hương vị của bánh.', N'Bánh kem đào là một món ăn ngon và bổ dưỡng. Bánh có thể được dùng làm món tráng miệng, món quà tặng hoặc món ăn trong các dịp đặc biệt.', 7, 'banh-kem-dao.jpg', 240000, 2, '2023-09-22');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh kem xoài', N'Bánh kem xoài thường có hình tròn hoặc vuông. Cốt bánh bông lan có thể được làm từ bột mì, trứng, sữa, đường và bơ. Bánh được nướng chín vàng đều, có độ mềm ẩm vừa phải. Kem tươi được đánh bông với đường, có độ mịn và béo ngậy. Xoài được gọt vỏ, cắt miếng nhỏ hoặc xay nhuyễn. Bánh kem xoài có thể dùng trong các dịp lễ tết, sinh nhật hoặc đơn giản là thưởng thức trong những buổi tụ tập bạn bè. Bánh là món ăn thơm ngon, bổ dưỡng và được nhiều người yêu thích. Bánh kem xoài có thể được biến tấu với nhiều hương vị khác nhau, chẳng hạn như bánh kem xoài sữa chua, bánh kem xoài cốt dừa, bánh kem xoài chocolate,... Mỗi loại bánh đều có hương vị riêng, mang đến cho người thưởng thức những trải nghiệm thú vị.', N'Bánh kem xoài là một loại bánh kem được làm từ cốt bánh bông lan, kem tươi và xoài. Bánh có vị ngọt thanh của xoài, béo ngậy của kem tươi và thơm mùi bơ sữa. Bánh có thể được trang trí với xoài tươi, kem tươi, trái cây tươi hoặc chocolate.', 6, N'banh-kem-xoai.jpg', 230000, 1, '2023-09-15');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh kem socola', N'Bánh kem socola thường được làm từ cốt bông lan socola, kem tươi và socola. Cốt bông lan socola được làm từ bột mì, trứng gà, sữa, socola và các nguyên liệu khác. Cốt bông lan có màu nâu đen đặc trưng của socola, vị ngọt ngào, mềm mịn. Kem tươi được đánh bông với đường và vani, có vị ngọt béo, thơm ngon. Socola được nấu chảy và phủ lên bề mặt bánh, tạo nên lớp phủ bóng mượt, hấp dẫn. Bánh kem socola có thể được trang trí với nhiều hình dạng và màu sắc khác nhau, tùy theo sở thích của người làm bánh hoặc người thưởng thức. Một số mẫu bánh kem socola phổ biến như: bánh kem socola hình tròn truyền thống, bánh kem socola hình trái tim, bánh kem socola trang trí trái cây,... Bánh kem socola thường được dùng trong các dịp đặc biệt như sinh nhật, lễ kỷ niệm,... Bánh kem socola là món quà ý nghĩa, thể hiện tình yêu thương, sự quan tâm của người tặng dành cho người nhận.', N'Bánh kem socola là một trong những loại bánh kem được yêu thích nhất trên thế giới. Với hương vị socola đậm đà, ngọt ngào, béo ngậy, bánh kem socola mang đến cho người thưởng thức cảm giác vô cùng thích thú.', 5, N'banh-kem-socola.jpg', 200000, 2, '2023-10-22');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh kem việt quất', N'Bánh kem Việt quất thường được làm từ hai lớp bông lan mềm mịn, thơm ngon. Ở giữa là lớp nhân việt quất tươi, chua thanh, ngọt dịu. Lớp kem phủ bánh thường là kem sữa tươi, kem tươi phô mai hoặc kem tươi chocolate, tùy theo sở thích của người thưởng thức. Bánh được trang trí bằng những quả việt quất tươi đỏ mọng, tạo nên vẻ đẹp sang trọng, bắt mắt. Khi thưởng thức bánh kem Việt quất, bạn sẽ cảm nhận được hương vị thơm ngon, hòa quyện của các nguyên liệu. Vị ngọt ngào của việt quất, vị béo ngậy của kem tươi, vị mềm mịn của bông lan tạo nên một tổng thể hài hòa, kích thích vị giác. Bánh kem Việt quất có thể được dùng làm món tráng miệng, món ăn nhẹ hoặc dùng trong các dịp đặc biệt như sinh nhật, tiệc cưới,... Bánh được nhiều người yêu thích bởi hương vị thơm ngon, hấp dẫn và vẻ ngoài bắt mắt.', N'Bánh kem Việt quất là một trong những loại bánh kem được yêu thích nhất hiện nay. Với hương vị ngọt ngào, chua thanh của việt quất, bánh kem này mang đến cho người thưởng thức cảm giác tươi mát, sảng khoái, đặc biệt phù hợp với mùa hè.', 10, N'banh-kem-viet-quat.jpg', 250000, 2, '2023-10-15');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh kem dâu tây', N'Bánh kem dâu tây thường được làm từ cốt bánh bông lan mềm mịn, kết hợp với lớp nhân dâu tây tươi ngon. Bề mặt bánh thường được phủ lớp kem tươi phô mai hoặc kem sữa tươi, tạo nên hương vị độc đáo và hấp dẫn. Bánh thường được trang trí bằng dâu tây tươi, tạo nên vẻ ngoài đẹp mắt và hấp dẫn. Với hương vị ngọt ngào của dâu tây, vị béo ngậy của kem, và vị thơm mát của bông lan, bánh kem dâu tây là sự lựa chọn tuyệt vời cho những người yêu thích hương vị quyến rũ của trái cây.', N'Bánh kem dâu tây là một món tráng miệng ngon miệng và bắt mắt, thích hợp cho các dịp lễ, tiệc cưới, hoặc đơn giản là để thưởng thức trong những ngày dễ thương.', 15, N'banh-kem-dau-tay.jpg', 180000, 1, '2023-11-15');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh kem dâu tây mâm xôi', N'Bánh kem dâu tây mâm xôi là một tác phẩm bánh ngọt tinh tế và ngon miệng, mang đến một trải nghiệm ẩm thực thật tuyệt vời với vị ngọt của quả dâu tươi mọng và lớp kem mousse nhẹ nhàng như mây. Bánh được làm từ những thành phần chất lượng cao và kỹ thuật nghệ thuật, tạo nên một tác phẩm trang trọng và thú vị trên bàn ăn.Bánh kem dâu tây mâm xôi có lớp bánh mềm mịn và nhẹ nhàng, mang trong mình một màu hồng tươi sáng, tượng trưng cho sự tươi mới và tinh khiết của quả dâu. Bên trên bánh, lớp kem mousse trắng mịn tạo ra một hình ảnh như mây, mang đến sự nhẹ nhàng và êm dịu cho mỗi miếng bánh. Quả dâu tươi ngon được sắp xếp cẩn thận, làm cho bề mặt bánh trở nên đẹp mắt và hấp dẫn. Vị ngọt thanh từ quả dâu tươi kết hợp với vị nhẹ nhàng và mát lạnh của kem mousse, tạo ra một cảm giác hài hòa và hoàn hảo trên đầu lưỡi. Bánh có độ ẩm vừa phải, giúp bánh mềm mịn tan chảy trong miệng, mang đến một trải nghiệm ẩm thực đầy thú vị. Bánh kem dâu tây mâm xôi là một lựa chọn hoàn hảo cho các dịp đặc biệt như sinh nhật, kỷ niệm hay các buổi tiệc. Bánh không chỉ làm vừa lòng về mặt hương vị mà còn gây ấn tượng với vẻ đẹp tinh tế. Với màu hồng tươi sáng và vẻ ngoài trang nhã, bánh là một điểm nhấn hoàn hảo cho bất kỳ bữa tiệc nào. Dù là ngày hè nóng bức hay ngày đông lạnh giá, Bánh kem dâu tây mâm xôi đều mang đến niềm vui và sự thỏa mãn cho mọi thực khách. Bạn sẽ cảm nhận được sự hạnh phúc khi thưởng thức một miếng bánh thật tuyệt vời, nơi mà hương vị tuyệt hảo của quả dâu hòa quyện với kem mousse nhẹ nhàng như mây.', N'Bánh kem dâu tây mâm xôi - một tác phẩm bánh ngọt với lớp kem mousse nhẹ nhàng như mây và vị ngọt thanh của quả dâu tươi. Bánh mềm mịn và trang nhã, là sự lựa chọn hoàn hảo cho các dịp đặc biệt và mang đến niềm vui cho mọi thực khách.', 2, 'banh-kem-dau-mam-xoi.png', 230000, 1, '2023-06-29');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh kem dâu 3 vị', N'Bánh kem dâu 3 vị là một tuyệt phẩm bánh ngọt tươi ngon và thanh mát, kết hợp giữa ba loại trái cây mọng nước - dâu tây, mâm xôi và việt quất - cùng với lớp kem mousse nhẹ nhàng. Bánh mang đến một trải nghiệm ẩm thực độc đáo và hấp dẫn, với vị ngọt tự nhiên và hương thơm tươi mát của các loại trái cây. Bánh kem dâu 3 vị có lớp bánh mềm mịn và màu trắng tinh khiết, tượng trưng cho sự tinh tế và sự tươi mới của trái cây. Bề mặt bánh được phủ một lớp kem mousse nhẹ nhàng, tạo nên một cảm giác mềm mại và mịn màng trên đầu lưỡi. Quả dâu tây tươi, mâm xôi và việt quất được sắp xếp trên bề mặt bánh, tạo điểm nhấn màu sắc và hương vị tươi mát. Vị ngọt thanh của ba loại trái cây kết hợp với kem mousse nhẹ nhàng, tạo ra một hòa quyện ngọt ngào và mát lạnh trên đầu lưỡi. Bánh có độ ẩm vừa phải, giúp bánh mềm mịn và giữ được độ tươi mát của trái cây. Vị ngọt tự nhiên của dâu tây, mâm xôi và việt quất mang lại cảm giác tươi mới và sảng khoái cho mỗi miếng bánh. Bánh kem dâu 3 vị là lựa chọn hoàn hảo cho các dịp đặc biệt như sinh nhật, kỷ niệm hoặc khi bạn muốn thưởng thức một món tráng miệng tươi mát và đầy hương vị. Bạn có thể tận hưởng bánh một mình hoặc chia sẻ với gia đình và bạn bè. Bánh không chỉ ngon lành mà còn làm cho bữa tiệc thêm phần rực rỡ và thu hút. Dù là vào mùa hè nóng bức hay mùa đông lạnh giá, Bánh kem dâu 3 vị đều mang đến sự thỏa mãn cho mọi thực khách. Bạn sẽ cảm nhận được sự hài lòng khi thưởng thức một miếng bánh thơm ngon, nơi hương vị tươi mát của ba loại trái cây hòa quyện với kem mousse nhẹ nhàng, mang lại sự sảng khoái và hài lòng cho vị giác.', N'Bánh kem dâu 3 vị - một tuyệt phẩm bánh ngọt với ba loại trái cây tươi mát - dâu tây, mâm xôi và việt quất - kết hợp với lớp kem mousse nhẹ nhàng. Bánh mềm mịn và tươi sáng, mang đến trải nghiệm ẩm thực độc đáo và thanh mát.', 2, 'banh-kem-dau-3-vi.png', 300000, 3, '2023-7-01');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh kem dâu tây cà phê', N'Bánh Mocha dâu tây là một tác phẩm bánh ngọt độc đáo, kết hợp giữa hương vị mạnh mẽ của cà phê và sự mềm mịn của kem mousse. Bánh mang đến một trải nghiệm ẩm thực thú vị, với hương thơm hấp dẫn và vị ngọt đắng hoàn hảo của hỗn hợp cà phê và kem. Bánh Mocha dâu tây có lớp bánh mềm mịn và màu nâu hấp dẫn, tượng trưng cho hương vị đậm đà của cà phê. Bề mặt bánh được phủ một lớp kem mousse mịn màng và bọt nhẹ, tạo ra một cảm giác mềm mại và êm ái trên đầu lưỡi. Quảng trí bánh bằng một lớp cacao hoặc hạt cà phê rang, tạo điểm nhấn màu sắc và hương vị đặc biệt. Vị ngọt đắng của cà phê kết hợp với kem mousse mịn màng, tạo ra một hòa quyện ngọt ngào và cân bằng trên đầu lưỡi. Bánh có độ ẩm vừa phải, giúp bánh mềm mịn và giữ được hương vị đậm đà của cà phê. Hương vị cà phê đặc trưng và độ mịn của kem mousse tạo ra một trải nghiệm ẩm thực độc đáo và sôi động cho vị giác. Bánh Mocha dâu tây là lựa chọn hoàn hảo cho những người yêu thích hương vị cà phê mạnh mẽ và muốn thưởng thức một món tráng miệng độc đáo. Bạn có thể tận hưởng bánh một mình hoặc chia sẻ với người thân yêu. Bất kể mùa trong năm, Bánh Mocha dâu tây đều là một món tráng miệng thú vị và hấp dẫn. Dù là vào mùa hè nóng bức hay mùa đông lạnh giá, Bánh Mocha dâu tây đều mang đến sự thỏa mãn cho mọi thực khách. Bạn sẽ cảm nhận được sự hài lòng khi thưởng thức một miếng bánh thơm ngon, nơi hương vị đậm đà của cà phê hòa quyện với kem mousse mịn màng, mang lại sự sảng khoái và hài lòng cho vị giác.', N'Bánh Mocha dâu tây - một tác phẩm bánh ngọt độc đáo với hương vị mạnh mẽ của cà phê và sự mềm mịn của kem mousse. Bánh mềm mịn và hấp dẫn, mang đến trải nghiệm ẩm thực thú vị và đậm đà.', 7, 'banh-mocha-dau-tay.png', 320000, null, '2023-05-28');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh kem xoài đặc biệt', N'Bánh kem xoài đặc biệt là một tuyệt phẩm bánh ngọt tươi mát và hấp dẫn, kết hợp giữa hương vị đặc trưng của trái xoài và sự nhẹ nhàng của kem mousse. Bánh mang đến một trải nghiệm ẩm thực độc đáo, với vị ngọt tự nhiên và hương thơm tươi mát của xoài. Bánh kem xoài đặc biệt có lớp bánh mềm mịn và màu vàng sáng, tượng trưng cho sự tươi mới và sự tươi mát của trái xoài. Bề mặt bánh được phủ một lớp kem mousse nhẹ nhàng, tạo ra một cảm giác mềm mại và mịn màng trên đầu lưỡi. Miếng xoài tươi ngon được sắp xếp trên bề mặt bánh, tạo điểm nhấn màu sắc và hương vị tươi mát. Vị ngọt tự nhiên và mát lạnh của xoài kết hợp với kem mousse nhẹ nhàng, tạo ra một hòa quyện ngọt ngào và thanh mát trên đầu lưỡi. Bánh có độ ẩm vừa phải, giúp bánh mềm mịn và giữ được hương vị tươi mát của xoài. Vị ngọt tự nhiên của xoài tươi ngon mang lại cảm giác thơm ngon và sảng khoái cho mỗi miếng bánh. Bánh kem xoài đặc biệt là lựa chọn hoàn hảo cho những người yêu thích xoài và muốn thưởng thức một món tráng miệng tươi mát và ngọt ngào. Bạn có thể tận hưởng bánh một mình hoặc chia sẻ với người thân yêu. Bất kể mùa trong năm, Bánh kem xoài đặc biệt đều là một món tráng miệng thú vị và hấp dẫn. Dù là vào mùa hè nóng bức hay mùa đông lạnh giá, Mango Cloud đều mang đến sự thỏa mãn cho mọi thực khách. Bạn sẽ cảm nhận được sự hài lòng khi thưởng thức một miếng bánh thơm ngon, nơi hương vị tươi mát của xoài hòa quyện với kem mousse mịn màng, mang lại sự sảng khoái và hài lòng cho vị giác.', N'Bánh kem xoài đặc biệt - một tuyệt phẩm bánh ngọt với hương vị tươi mát và đặc trưng của trái xoài, kết hợp với kem mousse nhẹ nhàng. Bánh mềm mịn và tươi sáng, mang đến trải nghiệm ẩm thực độc đáo và hấp dẫn.', 5, 'banh-kem-xoai-db.png', 400000, 2, '2023-04-11');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh kem socola trái tim', N'Bánh kem socola trái tim là một tác phẩm điêu khắc ngọt ngào và hoàn hảo để thể hiện tình yêu và sự lãng mạn. Khi nhìn vào bánh, bạn sẽ bị mê hoặc bởi vẻ đẹp đầy lôi cuốn của nó. Với lớp vỏ ngoài chocolate mịn màng và ánh kim tinh tế, bánh có hình dạng hình trái tim tinh tế, tỏa sáng với vẻ đẹp trọn vẹn và sự tinh tế. Khi bạn chạm tay vào bề mặt mềm mịn của bánh, sự êm ái và mềm mại của chocolate sẽ chảy vào ngón tay bạn, đảm bảo một trải nghiệm thực sự thú vị cho giác quan của bạn. Hương thơm ngọt ngào của chocolate cảm nhận từ xa, hòa quyện với không gian xung quanh và tạo ra không khí lãng mạn và quyến rũ. Mở bánh ra, bạn sẽ tiết lộ một cuộc hành trình đầy màu sắc của sự thưởng thức. Lớp chocolate đen đậm, đắm chìm trong vị ngọt của nó, hoàn hảo hòa quyện với lớp bánh mềm mịn và đặc biệt. Khi bạn cắt một miếng, bạn sẽ khám phá ra một trái tim chocolate nhỏ nằm ngay giữa, giống như trái tim ngọt ngào và thủy chung của tình yêu. Với sự kết hợp hoàn hảo của hương vị, kết cấu và hình dạng, bánh Heart Chocolate trở thành một sự lựa chọn lý tưởng cho những dịp đặc biệt như ngày Valentine, kỷ niệm ngày cưới, sinh nhật hay chỉ đơn giản là khi bạn muốn tặng tình yêu của mình một món quà độc đáo và tuyệt vời. Hãy để bánh kem socola trái tim làm nổi bật tình yêu và tạo nên những kỷ niệm đáng nhớ trong trái tim của người thân yêu.', N'Bánh kem socola trái tim là một tác phẩm điêu khắc ngọt ngào mà bạn không thể cưỡng lại. Với lớp vỏ ngoài chocolate mịn màng, bánh có hình dạng hình trái tim tinh tế, khiến nó trở thành lựa chọn hoàn hảo cho các dịp lãng mạn như ngày Valentine, kỷ niệm ngày cưới hoặc bất kỳ dịp đặc biệt nào bạn muốn tặng tình yêu của mình.', 3, 'banh-kem-socola-trai-tim.png', 500000, 1, '2023-06-28');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh hoa giấy 7 màu', N'Bánh hoa giấy 7 màu là một tác phẩm nghệ thuật ẩm thực đích thực, đánh thức trẻ con trong mỗi chúng ta. Với lớp vỏ ngoài trắng mịn và những hạt nhiều màu sắc rải rác khắp bề mặt, bánh này tạo ra một khung cảnh vui nhộn và lôi cuốn. Màu sắc tươi sáng của những hạt hoa giấy làm nổi bật bánh và khiến mọi người không thể rời mắt khỏi nó. Khi bạn chạm vào bề mặt mềm mịn của bánh, bạn sẽ cảm nhận được sự mềm mại và tinh tế của nó. Khi cắt một miếng bánh, bạn sẽ khám phá ra những hạt bông giấy đa dạng và ngộ nghĩnh, tạo ra một cảm giác vui nhộn và trẻ trung. Vị hương vani ngọt ngào và hương vị nhẹ nhàng tạo nên một hỗn hợp thú vị, khiến mỗi miếng bánh trở thành một cuộc phiêu lưu hương vị. Bánh hoa giấy 7 màu không chỉ là một món tráng miệng ngon lành, mà còn là biểu tượng của niềm vui và sự phấn khích. Nó là lựa chọn hoàn hảo cho các buổi tiệc sinh nhật, kỷ niệm, hoặc bất kỳ dịp đặc biệt nào mà bạn muốn mang đến nụ cười cho mọi người.Bánh hoa giấy 7 màu sẽ làm tăng tính vui nhộn và tạo nên những kỷ niệm đáng nhớ trong cuộc sống của bạn và những người thân yêu. Hãy để bánh Confetti mang đến niềm vui và sự hân hoan cho bữa tiệc của bạn.', N'Bánh hoa giấy 7 màu là một món tráng miệng vui nhộn và đầy màu sắc. Với những hạt nhiều màu rải rác khắp bề mặt, bánh mang đến niềm vui và sự phấn khích cho mọi dịp đặc biệt.', 3, 'banh-bong-giay-7-mau.png', 240000, null, '2023-06-17');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh kem dâu ngọt ngào', N'Bánh kem dâu ngọt ngào là một món tráng miệng thực sự quyến rũ, lấy cảm hứng từ hương vị tươi mát của dâu tươi. Với lớp vỏ bánh ngoài mịn màng và màu hồng nhẹ nhàng, bánh này mang đến một sự quyến rũ ngay từ cái nhìn đầu tiên. Mùi thơm ngọt ngào của dâu tươi thoang thoảng trong không khí, hứa hẹn một hành trình vị giác tuyệt vời. Khi bạn chạm vào bề mặt mềm mịn của bánh, bạn sẽ cảm nhận được sự nhẹ nhàng và mềm mại của nó. Khi cắt một miếng bánh, màu hồng tươi sáng và mứt dâu bắn ra, tạo ra một cảm giác tươi mát và phấn khích. Vị hương dâu tươi độc đáo, kết hợp với kem tươi mềm mịn, tạo ra một hương vị ngọt ngào và tươi mát đặc biệt. Bánh kem dâu ngọt ngào là một lựa chọn tuyệt vời cho những người yêu thích hương vị dâu tươi và tìm kiếm một món tráng miệng ngon lành. Nó làm cho một sự kết hợp hoàn hảo cho các dịp như tiệc sinh nhật, họp mặt bạn bè hoặc chỉ đơn giản là để thưởng thức trong ngày hè nóng bức. Với hương vị tươi mát và ngọt ngào, bánh kem dâu ngọt ngào sẽ chinh phục trái tim của bạn và mang lại niềm vui và hài lòng cho mọi người thưởng thức.', N'Bánh kem dâu ngọt ngào là một món tráng miệng tuyệt vời, mang đến hương vị tươi ngon của dâu tươi. Với lớp vỏ ngoài mịn màng và lớp kem tươi thơm ngon, bánh này là lựa chọn hoàn hảo cho những người yêu thích hương vị ngọt ngào và tươi mát.', 2, 'banh-kem-dau-ngot-ngao.png', 280000, 2, '2023-06-17');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh bông lan nhung đỏ', N'Bánh kem nhung đỏ là một tác phẩm nghệ thuật ẩm thực, kết hợp giữa vẻ đẹp và hương vị tinh tế. Với màu đỏ đặc trưng, bánh này gợi lên sự tự tin và thu hút ngay từ cái nhìn đầu tiên. Lớp vỏ ngoài mịn màng và màu đỏ rực rỡ tạo ra một bức tranh hấp dẫn, khiến ai nhìn vào cảm thấy tò mò và muốn khám phá sự ngọt ngào bên trong. Khi bạn chạm vào bề mặt mềm mịn của bánh, sự êm ái và nhẹ nhàng của nó sẽ lấp đầy lòng bàn tay bạn. Khi bạn cắt một miếng bánh, màu đỏ nổi bật và mềm mịn của nó sẽ tỏa ra, tạo ra một hình ảnh hấp dẫn và độc đáo trên đĩa. Vị hương vani thơm ngon, hòa quyện với một chút hương cacao nhẹ, mang lại một hương vị tinh tế và độc đáo. Với mỗi miếng bánh Bánh kem nhung đỏ bạn thưởng thức, bạn sẽ được trải nghiệm một hỗn hợp hương vị tuyệt vời. Sự kết hợp hoàn hảo giữa độ ẩm và độ xốp của bánh, kết hợp với một lớp kem phô mai nhẹ nhàng hay kem tươi thơm ngon, tạo ra một hòa quyện vị giác đáng nhớ. Bánh kem nhung đỏ không chỉ là một món tráng miệng ngon lành, mà còn là biểu tượng của sự sang trọng và thanh lịch. Nó thích hợp cho bất kỳ dịp đặc biệt nào - từ tiệc cưới, sinh nhật, cho đến những buổi tiệc gia đình hoặc khi bạn chỉ đơn giản muốn thưởng thức một món tráng miệng đặc biệt. Bánh kem nhung đỏ sẽ không chỉ đáp ứng sự mong đợi về vẻ đẹp và hương vị mà còn gợi lên cảm giác thăng hoa và hạnh phúc trong trái tim của bạn.', N'Bánh kem nhung đỏ là một biểu tượng của sự sang trọng và thanh lịch. Với màu đỏ đặc trưng, bánh có vị hương vani thơm ngon và cấu trúc mềm mịn, tạo ra một trải nghiệm thưởng thức tuyệt vời.', 2, 'banh-kem-nhung-do.png', 380000, null, '2023-06-14');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh bông lan đào', N'Bánh bông lan đào là một tác phẩm ẩm thực tuyệt vời, kết hợp giữa vẻ đẹp và hương vị tươi ngon của đào và kem sữa mịn màng. Bánh có lớp vỏ ngoài mềm mịn, mang lại sự dễ chịu và êm ái khi bạn cắn vào từng miếng nhỏ. Khi bạn chạm vào bề mặt mềm mịn của bánh, bạn sẽ cảm nhận được sự mềm mại và tinh tế của nó. Hương thơm của đào tươi ngon lan tỏa trong không gian, đưa bạn đến với những khu vườn đầy mùi hương. Mỗi miếng bánh mang một phần đào nhỏ, tươi mọng và độc đáo, tạo nên một trải nghiệm thưởng thức đặc biệt và đáng nhớ. Lớp kem kem sữa mịn màng là điểm nhấn hoàn hảo cho bánh bông lan đào. Với vị ngọt nhẹ và kem sữa mượt mà, nó tạo ra một sự kết hợp tuyệt vời với hương vị đào tươi ngon. Khi bạn thưởng thức mỗi miếng bánh, hương vị ngọt ngào của đào hòa quyện với kem sữa mịn, mang lại một sự thỏa mãn và hạnh phúc cho vị giác của bạn. Bánh bông lan đào không chỉ là một món tráng miệng thơm ngon, mà còn là một biểu tượng của sự tươi ngon và thanh lịch. Nó là sự lựa chọn hoàn hảo cho các buổi tiệc, dịp kỷ niệm hoặc chỉ đơn giản là để thưởng thức một món quà ngọt ngào cho bản thân. Bánh bông lan đào sẽ mang đến sự hài lòng và niềm vui tuyệt đối cho bạn và những người thân yêu.', N'Bánh bông lan đào là một món tráng miệng tinh tế và thơm ngon, kết hợp giữa hương vị đặc trưng của đào và kem sữa mịn màng. Với lớp vỏ ngoài mềm mịn và lớp kem kem đặc trưng, bánh này là một lựa chọn hoàn hảo để thưởng thức hương vị tươi ngon và thỏa mãn sự ngọt ngào trong lòng.', 10, 'banh-bong-lan-dao.png', 120000, null, '2023-06-14');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh bông lan mứt cam', N'Bánh bông lan mứt cam là một miếng bánh nhỏ xinh đầy màu sắc và hương vị tươi mát của quả cam, kết hợp hoàn hảo với kem kem tươi nhẹ nhàng. Đây là một món tráng miệng độc đáo và ngon lành, mang đến trải nghiệm ẩm thực đầy thú vị và sảng khoái. Bánh bông lan mứt cam có hình dạng hình vuông hoặc hình tròn nhỏ, với màu cam sáng và bề mặt mịn màng. Lớp kem kem tươi được phủ lên trên miếng bánh, tạo ra một hình ảnh hấp dẫn và mát lạnh. Chút trang trí từ vỏ cam tươi cắt nhỏ tạo thêm điểm nhấn màu sắc và sự tươi mát cho bánh. Vị ngọt ngọt thanh của quả cam kết hợp với kem kem tươi nhẹ nhàng, tạo ra một hòa quyện tuyệt vời trên đầu lưỡi. Bánh có độ ẩm vừa phải, giúp bánh mềm mịn và giữ được vị tươi mát của quả cam. Vị cam tự nhiên đặc trưng mang lại cảm giác tươi mới và sảng khoái cho mỗi miếng bánh. Bánh bông lan mứt cam là lựa chọn hoàn hảo cho những người thích thưởng thức một món tráng miệng nhẹ nhàng và ngọt ngào. Với kích thước nhỏ, bạn có thể thưởng thức miếng bánh này một mình hoặc chia sẻ với người thân yêu. Đây cũng là món tráng miệng lý tưởng cho các buổi tiệc hoặc dịp đặc biệt. Dù là vào mùa hè nóng bức hay mùa đông lạnh giá, bánh bông lan mứt cam đều mang đến sự thỏa mãn cho mọi thực khách. Bạn sẽ cảm nhận được sự hài lòng khi thưởng thức một miếng bánh nhỏ nhưng tràn đầy hương vị và màu sắc. Với bánh bông lan mứt cam, bạn sẽ tận hưởng sự kết hợp độc đáo giữa vị cam tươi mát và sự nhẹ nhàng của kem kem tươi, tạo nên một trải nghiệm ẩm thực thú vị và đáng nhớ.', N'Bánh bông lan mứt cam - một miếng bánh nhỏ xinh với vị ngọt thanh của quả cam và sự nhẹ nhàng của kem kem tươi. Bánh mang đến trải nghiệm ẩm thực tươi mát và đầy màu sắc.', 8, 'banh-bong-lan-mut-cam.png', 135000, 1, '2023-06-20');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh bông lan socola', N'Bánh bông lan socola là một tác phẩm ẩm thực đẳng cấp, mang đến hương vị sô-cô-la tinh tế và trải nghiệm mềm mại như những mảnh mây. Bánh có lớp vỏ ngoài sô-cô-la mịn màng, tạo ra một cảm giác mềm mại và êm ái khi bạn chạm vào. Khi bạn chạm vào bề mặt mềm mịn của bánh, bạn sẽ cảm nhận được sự dễ chịu và nhẹ nhàng của nó. Mỗi miếng bánh như những mảnh mây sô-cô-la tan chảy trong miệng, mang đến một trải nghiệm thưởng thức độc đáo và đáng nhớ. Hương thơm sô-cô-la nồng nàn, hòa quyện với không gian xung quanh, tạo ra một không khí ngọt ngào và quyến rũ. Lớp kem sữa béo ngậy là một điểm nhấn hoàn hảo cho bánh Bánh bông lan socola. Với vị ngọt nhẹ và độ kem mịn, nó tạo ra một sự kết hợp hoàn hảo với hương vị sô-cô-la. Khi bạn thưởng thức mỗi miếng bánh, sự hòa quyện giữa chocolate và kem sữa mời gọi, mang lại sự thỏa mãn và hạnh phúc tuyệt đối cho vị giác của bạn. Bánh bông lan socola không chỉ là một món tráng miệng ngon lành, mà còn là biểu tượng của sự sang trọng và thanh lịch. Nó là lựa chọn hoàn hảo cho các dịp đặc biệt như sinh nhật, kỷ niệm hoặc chỉ đơn giản là để thưởng thức một món quà ngọt ngào cho bản thân. Bánh bông lan socola sẽ mang đến sự hài lòng và niềm vui tuyệt đối cho bạn và những người thân yêu.', N'Bánh bông lan socola là một món bánh ngọt ngào và nhẹ nhàng, với hương vị sô-cô-la thượng hạng. Với lớp bên ngoài mịn màng và kem sữa béo ngậy, bánh mang đến cảm giác như đang thưởng thức những mảnh mây sô-cô-la ngọt ngào trên đầu lưỡi.', 5, 'banh-bong-lan-socola.png', 150000, 3, '2023-06-17');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh bông lan phô mai', N'Bánh Phô Mai là một sự kết hợp hoàn hảo giữa vị béo ngậy của phô mai và độ giòn của lớp vỏ bánh. Lớp bánh nước béo được làm từ bột mỳ và bơ, tạo nên độ giòn hấp dẫn, trong khi lớp phô mai mềm mịn giúp tăng thêm hương vị đặc trưng. Với hình thức đa dạng từ bánh tròn đến bánh dài, Bánh Phô Mai là sự lựa chọn phổ biến trong các buổi tiệc và dịp lễ. Hãy thưởng thức hương vị thơm ngon và độc đáo của chiếc bánh này.', N'Bánh phô mai có hương vị thơm ngon, béo ngậy và mềm mịn. Bánh phô mai là một món ăn ngon.', 10, N'banh-pho-mai.png', 180000, NULL, '2023-8-14');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh bông lan sữa chua việt quất', N'Bánh bông lan sữa chua việt quất là sự kết hợp ngon mắt giữa vị bông lan mềm mịn, sữa chua tươi ngon và hương vị thơm ngon của quả việt quất. Lớp bánh bông lan được làm từ bột mỳ, trứng, sữa chua và bơ, tạo nên độ ẩm và vị ngon đặc trưng. Bánh được nhân bằng kem sữa chua trắng mịn màng, kết hợp với việt quất tươi giòn, tạo nên một trải nghiệm thưởng thức độc đáo. Lớp vỏ bánh được trang trí bằng kem sữa chua, quả việt quất, và có thể thêm các đường deo trang trí theo sở thích cá nhân.', N'Bánh bông lan sữa chua việt quất là một món bánh ngọt thơm ngon, mềm mịn và đẹp mắt. Bánh có lớp bông lan xốp nhẹ, phủ lớp sữa chua mát lạnh và việt quất tươi ngọt.', 15, N'banh-bong-lan-sua-chua-viet-quat.png', 130000, NULL, '2023-7-11');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh bông lan dâu tây việt quất', N'Bánh Bông Lan Dâu Tây Việt Quất là sự pha trộn hoàn hảo giữa vị bông lan mềm mịn, hương thơm dâu tây quyến rũ và vị ngon độc đáo của quả việt quất. Lớp bánh bông lan được làm từ bột mỳ, trứng, bơ, và dâu tây tươi, tạo nên độ ẩm và vị thơm ngon đặc trưng. Bánh được nhân bằng kem tươi dâu tây mềm mịn, kết hợp với việt quất giòn ngon, tạo nên một trải nghiệm thưởng thức độc đáo. Lớp vỏ bánh được trang trí bằng kem tươi, dâu tây, và có thể thêm các chi tiết trang trí tùy chọn.', N'Bánh bông lan dâu tây việt quất là một món bánh ngọt thơm ngon và đẹp mắt. Bánh có lớp bông lan mềm mịn, được phủ lên trên là kem tươi béo ngậy và những quả dâu tây việt quất tươi ngon.', 10, N'banh-bong-lan-dau-tay-viet-quat.png', 150000, 1, '2023-7-25');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh kem bọt khoai tây', N'Bánh mousse khoai tây là một món tráng miệng thơm ngon và mềm mịn. Nguyên liệu chính của bánh là khoai tây, kết hợp với lớp mousse nhẹ nhàng, tạo nên một trải nghiệm ăn uống đặc biệt.', N'Bánh mousse khoai tây thơm ngon và mềm mịn với hương vị đặc trưng của khoai tây.', 20, N'banh-mousse-khoai-tay.png', 200000, NULL, '2023-12-31');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh kem bọt vani socola trái tim', N'Bánh mousse vani socola trái tim là một tác phẩm nghệ thuật ẩm thực độc đáo, kết hợp hương vị tinh tế của vani và sự đậm đà của sô-cô-la. Được thiết kế dưới hình dạng trái tim, bánh không chỉ gây ấn tượng về hương vị mà còn về vẻ ngoài tinh tế và lãng mạn. Lớp mousse vani mềm mịn, nhẹ nhàng làm cho mỗi miếng bánh tan chảy trong miệng, đồng thời mang lại cảm giác ngọt ngào và thơm ngon. Sự kết hợp với lớp mousse sô-cô-la đen đặc trưng, tạo nên một hòa quyện vị giác đặc sắc. Đặc biệt, hình dạng trái tim không chỉ là điểm nhấn thẩm mỹ mà còn là biểu tượng của tình yêu và quan tâm. Bánh mousse vani socola trái tim là lựa chọn hoàn hảo để làm quà tặng trong những dịp lễ tình nhân, kỷ niệm hay để chia sẻ niềm vui với người thân yêu. Mỗi chiếc bánh được làm thủ công với độ tinh tế cao, đảm bảo chất lượng và trải nghiệm thưởng thức đẳng cấp.', N'Bánh mousse vani socola trái tim đẹp mắt và thơm ngon, phù hợp làm quà tặng cho những dịp đặc biệt.', 8, N'banh-mousse-vani-socola-trai-tim.png', 220000, NULL, '2023-12-31');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh kem caramen cà phê', N'Bánh kem caramen cà phê là một tác phẩm ẩm thực tinh tế, hứa hẹn mang lại trải nghiệm độc đáo cho những người yêu thích hương vị caramen và cà phê. Lớp kem caramen mềm mịn, dày đặc với hương vị đặc trưng của đường và sữa tươi, tạo nên lớp vị ngọt ngào và béo ngậy mà bất cứ ai cũng muốn thưởng thức. Lớp kem cà phê đậm đà và thơm ngon được chế biến từ cà phê nguyên chất, giúp bổ sung sự tỉnh táo và hứng khởi. Khi thưởng thức chiếc bánh, bạn sẽ cảm nhận được sự hòa quyện hoàn hảo giữa hương vị độc đáo của caramen và hương thơm đặc trưng của cà phê. Bánh kem caramen cà phê không chỉ là một món tráng miệng tuyệt vời mà còn là điểm nhấn lý tưởng cho các dịp đặc biệt như lễ cưới, sinh nhật hay các sự kiện quan trọng khác. Chiếc bánh này không chỉ làm hài lòng vị giác mà còn tạo nên một trải nghiệm ẩm thực đặc sắc. Đắm chìm trong hương vị ngon lành của Bánh Kem Caramen Cà Phê và hãy để nó trở thành điểm nhấn tuyệt vời trong bữa tiệc của bạn.', N'Bánh kem caramen cà phê hoà quyện caramen ngọt và cà phê đắng, mang đến trải nghiệm hương vị độc đáo và thú vị.', 5, N'banh-kem-caramen-ca-phe.png', 250000, NULL, '2023-6-30');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh kem socola 3 tầng', N'Bánh kem socola 3 tầng là tác phẩm nghệ thuật ẩm thực với ba lớp kem sô-cô-la ngon mắt và thơm ngon. Lớp bánh bông lan giòn tan, kết hợp với lớp kem sô-cô-la đen và kem sô-cô-la trắng, tạo nên sự đa dạng hương vị và màu sắc. Bánh được trang trí tinh tế với những hạt sô-cô-la hoặc topping tùy chọn, tạo nên một bức tranh thị giác hấp dẫn. Với sự kết hợp độc đáo của lớp bánh mềm mịn và hương vị sô-cô-la đắm chìm, chiếc bánh này làm hài lòng mọi đám đông và trở thành điểm nhấn tuyệt vời cho bất kỳ dịp lễ nào.', N'Bánh kem socola 3 tầng là một món tráng miệng ngon và đẹp mắt. Bánh có 3 lớp bánh mềm xốp, được phủ bởi kem sô-cô-la béo ngậy và socola lát. ', 12, N'banh-kem-socola-3-tang.png', 210000, 1, '2023-11-24');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh kem mịn cacao', N'Bánh kem mịn cacao là sự kết hợp hoàn hảo giữa vị thơm ngon của cacao và độ mịn màng của lớp bánh. Lớp bánh được làm từ bột mỳ chất lượng cao và cacao nguyên chất, tạo nên độ ẩm và hương vị đặc trưng. Bánh được phủ lớp kem mịn màng, tạo nên cảm giác nhẹ nhàng mà vẫn giữ được vị đậm đà của cacao. Sự hòa quyện giữa lớp bánh mềm mịn và hương vị thơm ngon của cacao khiến cho Bánh Kem Mịn Cacao trở thành lựa chọn tuyệt vời cho những người yêu thích hương vị đặc trưng của cacao.', N'Bánh kem mịn cacao có hương vị thơm ngon, béo ngậy và mềm mịn. Bạn có thể thưởng thức bánh với trà hoặc cà phê vào buổi sáng hoặc chiều.', 15, N'banh-kem-min-cacao.png', 190000, 2,'2023-9-23');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh heo đáng yêu', N'Bánh Heo Đáng Yêu là chiếc bánh nhỏ xinh hình con heo, tạo nên một bức tranh đáng yêu và ngộ nghĩnh. Lớp vỏ bánh giòn tan được làm từ bột mỳ và bơ, mang đến cảm giác nhẹ nhàng khi nắm giữ. Bánh được nhân bằng kem tươi mềm mịn, có thể có thêm những hạt sô-cô-la nhỏ hoặc đường màu, tạo nên vẻ ngoài độc đáo và hấp dẫn. Bánh Heo Đáng Yêu không chỉ là món tráng miệng ngon mắt mà còn là lựa chọn hoàn hảo để làm quà tặng dễ thương cho những người yêu thích ẩm thực sáng tạo.', N' Bánh heo đáng yêu không chỉ ngon mà còn mang lại niềm vui và hạnh phúc cho bạn và gia đình.', 4, N'banh-heo-dang-yeu.png', 250000, NULL, '2023-10-28');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh gấu nâu tinh nghịch', N'Bánh gấu nâu tinh nghịch là chiếc bánh có hình dạng đáng yêu như chú gấu nâu, mang đến không khí vui tươi và ngọt ngào. Lớp vỏ bánh được làm từ bột mỳ và bơ, tạo nên độ giòn và hương vị dễ chịu. Bên trong, bánh được nhân bằng kem sô-cô-la mềm mịn, tạo nên sự kết hợp tuyệt vời giữa vị ngọt của kem và vị béo của bánh. Bánh gấu nâu tinh nghịch không chỉ là lựa chọn hoàn hảo cho những người yêu thích thực phẩm sáng tạo mà còn là món quà ý nghĩa cho những dịp đặc biệt.', N'Bánh gấu nâu tinh nghịch cũng là món quà ý nghĩa cho những người bạn yêu thích động vật hoặc muốn có một ngày vui vẻ.', 5, N'banh-gau-nau-tinh-nghich.png', 290000, NULL, '2023-12-31');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh kem rừng xanh socola', N'Bánh kem rừng xanh socola là sự kết hợp tinh tế giữa hương vị tươi mới của rừng xanh và sự đắm chìm trong vị sô-cô-la ngon mắt. Lớp vỏ bánh được làm từ bột mỳ chất lượng cao, bơ và nấm xanh, tạo nên độ ẩm và hương vị đặc trưng của rừng xanh. Bánh được phủ lớp sô-cô-la đen mịn màng, tạo nên lớp vỏ bóng mượt và hấp dẫn. Bên trong, lớp kem sô-cô-la béo ngậy là điểm nhấn hoàn hảo cho trải nghiệm thưởng thức. Bánh Kem Rừng Xanh Sô-cô-la không chỉ mang đến hương vị đặc sắc mà còn làm cho mọi dịp lễ trở nên đặc biệt.', N'Bánh kem rừng xanh socola là một món tráng miệng ngon tuyệt vời cho những dịp đặc biệt. Bánh có lớp kem béo ngậy, phủ lên bánh bông lan mềm xốp, và được trang trí bằng những viên sô-cô-la đen và trắng hình lá cây.', 5, N'banh-kem-rung-xanh-socola.png', 240000, NULL, '2023-9-25');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh mì kem bơ', N'Bánh mì kem bơ là sự kết hợp tuyệt vời giữa vị bánh mì giòn tan và lớp kem bơ mềm mịn. Bánh mì được làm từ bột mỳ chất lượng cao, nướng chín vàng giòn, mang lại hương vị ngon miệng. Bên trên, lớp kem bơ được đánh bông với đường và vani, tạo nên vị béo ngậy và thơm ngon. Bánh Mì Kem Bơ là lựa chọn lý tưởng cho những người yêu thích sự kết hợp độc đáo giữa vị ngọt của bơ và vị giòn của bánh mì.', N'Bánh mì kem bơ là một loại bánh ngọt phổ biến ở Việt Nam, được làm từ bột mì, đường, trứng, bơ và kem.', 20, N'banh-mi-kem-bo.png', 90000, NULL, '2023-11-24');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh mì phô mai kem việt quất', N'Bánh mì phô mai kem việt quất là sự kết hợp hấp dẫn giữa vị ngọt của phô mai kem và hương thơm tinh tế của việt quất. Bánh mì được làm từ bột mỳ mịn màng, nướng chín vàng, mang lại độ giòn cho lớp vỏ bánh. Lớp kem phô mai béo ngậy được đánh bông với đường, tạo nên hương vị thơm ngon và độ béo ngậy đặc trưng. Việt quất tươi được sắp xếp trên bề mặt bánh, tạo nên vẻ đẹp mắt và hấp dẫn. Bánh Mì Phô Mai Kem Việt Quất là sự lựa chọn tuyệt vời cho những người yêu thích sự hòa quyện giữa phô mai và quả việt quất.', N'Bánh thích hợp cho bữa sáng hoặc ăn vặt, có thể kết hợp với trà hoặc cà phê.', 30, N'banh-mi-pho-mai-kem-viet-quat.png', 60000, NULL, '2023-12-15');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh mì nho khô', N'Bánh mì nho khô là sự kết hợp tinh tế giữa hương vị giòn ngon của bánh mì và độ ngọt tự nhiên của nho khô. Bánh mì được làm từ bột mỳ mịn màng, nướng chín vàng, tạo nên lớp vỏ bánh giòn ngon. Những hạt nho khô được trải đều trên bề mặt bánh, mang lại độ ngọt và hương vị tinh tế. Bánh Mì Nho Khô là lựa chọn lý tưởng cho những người yêu thích sự kết hợp giữa vị giòn và hương vị tự nhiên của nho khô.', N'Bánh mì nho khô có vị ngọt dịu của nho khô, mềm xốp của bánh mì và thơm lừng của bơ.', 20, N'banh-mi-nho-kho.png', 75000, NULL, '2023-09-25');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh mì ngũ cốc', N'Bánh mì ngũ cốc là sự kết hợp hoàn hảo giữa vị ngon của bánh mì và hương thơm của các loại ngũ cốc khác nhau. Bánh mì được làm từ bột mỳ chất lượng cao, nướng chín vàng giòn, tạo nên lớp vỏ bánh hấp dẫn. Những hạt ngũ cốc trải đều trên bề mặt bánh, mang lại độ giòn và hương vị phong phú. Bánh mì ngũ cốc là lựa chọn tuyệt vời cho những người yêu thích sự đa dạng trong khẩu vị.', N'Bánh mì ngũ cốc là một loại bánh mì được làm từ nhiều loại ngũ cốc khác nhau, như lúa mì, lúa mạch, yến mạch, hạt lanh, hạt dẻ cười và hạt chia. Bánh mì ngũ cốc có nhiều lợi ích cho sức khỏe.', 15, N'banh-mi-ngu-coc.png', 90000, NULL, '2023-10-23');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh mì cuộn bơ lạt', N'Bánh mì cuộn bơ lạt là sự kết hợp độc đáo giữa vị bơ thơm ngon và hình dáng cuộn lạ mắt. Bánh mì được làm từ bột mỳ mềm mịn, nướng chín vàng, tạo nên lớp vỏ bánh giòn ngon. Lớp bơ lạt béo ngậy được cuộn đều bên trong bánh, tạo nên sự độc đáo và hấp dẫn. Bánh mì cuộn bơ lạt là sự lựa chọn tuyệt vời cho những người muốn trải nghiệm hương vị mới lạ.', N'Món bánh mì cuộn bơ lạt có vị ngọt của bánh mì, béo của bơ và đậm đà của lạt, rất thơm ngon và bổ dưỡng.', 20, N'banh-mi-cuon-bo-lat.png', 55000, NULL, '2023-10-17');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh mì áp chảo kem tươi', N'Bánh mì áp chảo kem tươi là sự kết hợp hấp dẫn giữa vị giòn ngon của bánh mì áp chảo và hương thơm béo ngậy của kem tươi. Bánh mì áo chảo được làm từ bột mỳ mềm mịn, nướng chảo cho đến khi giòn vàng, tạo nên lớp vỏ bánh hấp dẫn. Khi bánh mì còn nóng hổi, lớp kem tươi được thêm lên bề mặt bánh, tạo nên sự hòa quyện giữa vị ngọt ngào và giòn giòn của bánh mì. Bánh mì áp chảo kem tươi là lựa chọn tuyệt vời cho những bữa ăn sáng hoặc giải khát trong ngày nắng nóng.', N'Bánh mì áp chảo kem tươi là một món ăn ngon và độc đáo, được chế biến từ bánh mì, trứng, sữa, đường và kem tươi.', 20, N'banh-mi-ap-chao-kem-tuoi.png', 25000, NULL, '2023-09-16');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh mì bơ đậu phộng', N'Bánh mì bơ đậu phộng là sự kết hợp ngon miệng giữa vị bơ mềm mịn và hạt đậu phộng giòn ngon. Bánh mì được làm từ bột mỳ chất lượng cao, nướng chín vàng giòn, tạo nên lớp vỏ bánh hấp dẫn. Lớp bơ đậu phộng được phết đều lên bề mặt bánh, tạo nên vị béo ngậy và hương thơm đặc trưng. Bánh mì bơ đậu phộng là lựa chọn tuyệt vời cho những người yêu thích sự độc đáo và vị ngon đậu phộng.', N'Bánh mì bơ đậu phộng là một món ăn đơn giản nhưng hấp dẫn, thường được dùng làm bữa sáng hoặc bữa phụ.', 20, N'banh-mi-bo-dau-phong.png', 20000, NULL, '2023-07-08');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh mì sữa trứng', N'Bánh mì sữa trứng là sự kết hợp hoàn hảo giữa vị thơm của sữa và hương vị độc đáo của trứng. Bánh mì được làm từ bột mỳ mềm mịn, nướng chín vàng, tạo nên lớp vỏ bánh mềm mịn và thơm ngon. Trên bề mặt bánh, lớp sữa trứng được phết đều, mang lại vị béo ngậy và hương thơm tinh tế. Bánh mì sữa trứng là lựa chọn tuyệt vời cho những người yêu thích sự êm dịu và độc đáo trong khẩu vị.', N'Bánh mì sữa trứng là một món ăn ngon và dễ làm, phù hợp cho bữa sáng hoặc bữa trưa nhẹ.', 20, N'banh-mi-sua-trung.png', 15000, NULL,'2023-08-24');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh mì sữa nguyên chất', N'Bánh mì sữa nguyên chất là sự kết hợp tinh tế giữa vị thơm của sữa tươi nguyên chất và hương vị đặc trưng của bánh mì. Bánh mì được làm từ bột mỳ mềm mịn, nướng chín vàng, tạo nên lớp vỏ bánh mềm mịn và thơm ngon. Chất sữa nguyên chất được sử dụng làm nhân và cũng được thêm lên bề mặt bánh, mang lại vị béo ngậy và hương thơm tinh tế. Bánh mì sữa nguyên chất là lựa chọn tuyệt vời cho những người yêu thích sự đơn giản và chất lượng.', N'Bánh mì sữa có vị ngọt nhẹ, mềm và xốp, thích hợp cho bữa sáng hoặc ăn vặt. ', 25, N'banh-mi-sua-nguyen-chat.png', 50000, NULL, '2023-06-30');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh mì đậu đỏ', N'Bánh mì đậu đỏ là sự kết hợp tuyệt vời giữa vị ngọt của đậu đỏ và hương thơm của bánh mì. Bánh mì được làm từ bột mỳ mềm mịn, nướng chín vàng, tạo nên lớp vỏ bánh giòn ngon và thơm bùi. Nhân đậu đỏ mịn màng được đặt bên trong bánh, mang lại vị ngọt ngào và độ béo ngậy đặc trưng. Bánh mì đậu đỏ là sự lựa chọn hoàn hảo cho những người yêu thích hương vị truyền thống và dinh dưỡng.', N'Bánh mì đậu đỏ là một loại bánh mì ngọt có nhân đậu đỏ nấu nhuyễn. Bánh mì đậu đỏ có nguồn gốc từ Nhật Bản, nơi nó được gọi là anpan.', 35, N'banh-mi-dau-do.png', 30000, NULL, '2023-08-18');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh mì kem khoai môn', N'Bánh mì kem khoai môn là sự kết hợp tuyệt vời giữa vị béo ngậy của khoai môn và hương thơm của bánh mì. Bánh mì được làm từ bột mỳ mềm mịn, nướng chín vàng, tạo nên lớp vỏ bánh giòn ngon và thơm phức. Nhân kem khoai môn béo ngậy được đặt bên trong bánh, mang lại hương vị độc đáo và thơm ngon.', N'Bánh mì kem khoai môn là một loại bánh ngọt phổ biến ở Việt Nam, được làm từ bột mì, kem tươi và khoai môn.', 20, N'banh-mi-kem-khoai-mon.png', 90000, NULL, '2023-11-24');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh xốp trái cây nhiệt đới', N'Bánh xốp trái cây nhiệt đới là một tác phẩm ngon miệng kết hợp giữa vị xốp nhẹ của bánh và hương thơm tinh tế của trái cây nhiệt đới. Bánh được làm từ các nguyên liệu chất lượng cao, nướng chín vàng, tạo nên lớp vỏ bánh mềm mịn. Bên trong, nhân bánh được làm từ trái cây nhiệt đới tươi ngon, mang lại hương vị tự nhiên và tươi mới. Bánh xốp trái cây nhiệt đới là sự lựa chọn hoàn hảo cho những người yêu thích sự hòa quyện giữa hương vị trái cây và sự nhẹ nhàng của bánh.', N'Bánh xốp trái cây nhiệt đới là một món ăn vừa ngon miệng vừa bổ dưỡng, rất được yêu thích bởi mọi lứa tuổi.', 20, N'banh-xop-trai-cay-nhiet-doi.png', 60000, NULL, '2023-07-30');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh sừng bò dâu tây', N'Bánh sừng bò dâu tây là sự kết hợp hài hòa giữa lớp vỏ giòn mỏng và nhân kem dâu tươi ngon. Bánh được làm từ bột mỳ chất lượng cao, nướng chín vàng, tạo nên lớp vỏ giòn mỏng bên ngoài. Nhân kem dâu tươi béo ngậy là điểm đặc sắc, mang lại hương vị tươi mới và thơm ngon.Bánh sừng bò dâu tây không chỉ ngon miệng mà còn đẹp mắt với màu đỏ dâu tươi bắt mắt.', N'Bánh sừng bò dâu tây có vị giòn tan, ngọt thanh và thơm mát, rất thích hợp để ăn kèm với trà hay cà phê vào buổi sáng hoặc chiều.', 15, N'banh-sung-bo-dau-tay.png', 80000, NULL, '2023-06-14');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh sừng bò socola', N'Bánh sừng bò socola là sự kết hợp hài hòa giữa lớp vỏ giòn mỏng và nhân kem sô-cô-la đậm đà. Bánh được làm từ bột mỳ chất lượng cao, nướng chín vàng, tạo nên lớp vỏ giòn mỏng bên ngoài. Nhân kem sô-cô-la đậm đà béo ngậy là điểm đặc sắc, mang lại hương vị thơm ngon và ngọt ngào. Bánh sừng bò socola không chỉ ngon miệng mà còn đẹp mắt với màu đen đậm của sô-cô-la.', N'Bánh được nướng trong lò ở nhiệt độ cao cho đến khi vàng giòn, sau đó được phủ một lớp socola lên trên. Bánh sừng bò socola có vị ngọt và béo, thích hợp để ăn với trà hoặc cà phê.', 10, N'banh-sung-bo-socola.png', 90000, NULL, '2023-05-26');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh sừng bò bơ tỏi', N'Bánh sừng bò bơ tỏi là sự kết hợp độc đáo giữa vị béo ngậy của bơ và hương thơm đặc trưng của tỏi. Bánh được làm từ bột mỳ chất lượng cao, nướng chín vàng, tạo nên lớp vỏ giòn mỏng bên ngoài. Nhân bơ béo ngậy và mùi thơm của tỏi là điểm độc đáo, mang lại hương vị ngon miệng và khác biệt. Bánh sừng bò bơ tỏi là sự lựa chọn phù hợp cho những người yêu thích hương vị độc đáo.', N'Bánh sừng bò bơ tỏi là một món ăn ngon và dễ làm, thích hợp cho bữa sáng hoặc bữa trưa. Bánh sừng bò là một loại bánh mì có hình dạng giống như sừng của con bò, được làm từ bột mì, men, đường, muối và bơ.', 12, N'banh-sung-bo-bo-toi.png', 120000, NULL, '2023-04-30');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh táo caramen nướng', N'Bánh táo caramen nướng là sự kết hợp tuyệt vời giữa vị ngọt của táo, độ ngon của caramen và hương thơm của bánh nướng. Bánh được làm từ bột mỳ chất lượng cao, nướng chín vàng, tạo nên lớp vỏ bánh giòn ngon và thơm phức. Nhân táo caramen ngọt ngon và thơm lừng là điểm đặc sắc, mang lại hương vị tinh tế và hấp dẫn.', N'Bánh táo caramen nướng có hương thơm quyến rũ, vị ngọt thanh và chua dịu của táo. Bạn có thể thưởng thức bánh cùng kem tươi hoặc sữa chua để tăng thêm hấp dẫn.', 10, N'banh-tao-caramen-nuong.png', 40000, NULL, '2023-03-17');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh rán kem xoài', N'Bánh rán kem xoài là sự kết hợp tuyệt vời giữa vị giòn của bánh rán, béo ngậy của kem và hương thơm ngọt của xoài. Bánh rán được làm từ bột mỳ chất lượng cao, chiên giòn vàng, tạo nên lớp vỏ bánh giòn ngon. Nhân kem xoài béo ngậy là điểm đặc sắc, mang lại hương vị ngon miệng và sảng khoái.', N'Bánh có hình dạng tròn nhỏ, màu vàng nâu hấp dẫn, khi ăn sẽ cảm nhận được sự kết hợp giữa vị ngọt của kem xoài, vị béo của nước cốt dừa và vị giòn của vỏ bánh. ', 15, N'banh-ran-kem-xoai.png', 60000, NULL, '2023-08-24');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh rán kem socola', N'Bánh rán kem socola là sự kết hợp hài hòa giữa vị giòn của bánh rán, béo ngậy của kem sô-cô-la và hương thơm đặc trưng của sô-cô-la. Bánh rán được làm từ bột mỳ chất lượng cao, chiên giòn vàng, tạo nên lớp vỏ bánh giòn ngon. Nhân kem sô-cô-la béo ngậy là điểm đặc sắc, mang lại hương vị thơm ngon và ngọt ngào.', N'Bánh có vị ngọt, béo và thơm, rất hấp dẫn với nhiều người. Bánh rán kem socola hương vị thường được dùng làm món ăn vặt hoặc món tráng miệng sau bữa ăn.', 15, N'banh-ran-kem-socola.png', 75000, NULL, '2023-03-24');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh rán kem vani', N'Bánh rán kem vani là sự kết hợp hài hòa giữa vị giòn của bánh rán và hương thơm ngọt của kem vani. Bánh rán được làm từ bột mỳ chất lượng cao, chiên giòn vàng, tạo nên lớp vỏ bánh giòn ngon. Nhân kem vani mềm mịn là điểm đặc sắc, mang lại hương vị thơm ngon và sự nhẹ nhàng của vani.', N'ên trong bánh là nhân kem vani thơm ngon, mềm mịn. Bánh rán kem vani hương vị thường được dùng làm món ăn vặt hoặc món tráng miệng sau bữa ăn.', 15, N'banh-ran-kem-vani.png', 70000, NULL, '2023-01-30');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh rán kim chi', N'Bánh rán kim chi là sự kết hợp độc đáo giữa vị giòn của bánh rán và hương vị đặc trưng của kim chi. Bánh rán được làm từ bột mỳ chất lượng cao, chiên giòn vàng, tạo nên lớp vỏ bánh giòn ngon. Nhân kim chi đậm đà và cay nồng là điểm độc đáo, mang lại hương vị thú vị và độ giòn của kim chi.', N'Bánh được chiên giòn và ăn nóng với sốt cay hoặc tương ớt. Bánh rán kim chi có hương vị đậm đà, cay nồng và béo ngậy, rất hấp dẫn và thích hợp cho những ngày lạnh.', 10, N'banh-ran-kim-chi.png', 65000, 1, '2023-02-24');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh rán mè', N'Bánh rán mè là một sự kết hợp độc đáo giữa vị giòn của bánh rán và hương thơm thơm của hạt mè. Bánh rán được làm từ bột mỳ chất lượng cao, chiên giòn vàng, tạo nên lớp vỏ bánh giòn ngon. Hạt mè béo ngậy làm cho bánh thêm phần độc đáo và ngon miệng.', N'Bánh có hình dạng tròn, được chiên giòn và phủ lớp mè trắng bên ngoài. Bên trong bánh là nhân đậu xanh hoặc khoai môn ngọt. Bánh rán mè thường được dùng làm món ăn vặt hoặc món tráng miệng sau bữa ăn.', 30, N'banh-ran-me.png', 20000, NULL, '2023-05-18');
INSERT INTO PRODUCT (ProductName, Description, ShortDescription, StockNumber, Image, Price, Discount, PublicationDate)
VALUES (N'Bánh rán đậu đỏ', N'Bánh rán đậu đỏ là sự kết hợp tuyệt vời giữa vị giòn của bánh rán và hương thơm đặc trưng của đậu đỏ. Bánh rán được làm từ bột mỳ chất lượng cao, chiên giòn vàng, tạo nên lớp vỏ bánh giòn ngon. Nhân đậu đỏ thơm ngon là điểm đặc sắc, mang lại hương vị tinh tế và độ ngon khó cưỡng.', N'Bánh thường được chiên trong dầu nóng cho đến khi vàng ươm. Bánh rán đậu đỏ là món ăn phổ biến vào các dịp lễ tết, hoặc làm quà vặt hàng ngày.', 30, N'banh-ran-dau-do.png', 25000, NULL, '2023-07-11');

-- Insert Category -- 
INSERT INTO CATEGORY VALUES (N'Bánh kem',N'Bánh kem gồm các loại bánh mềm mịn, có hình dạng giống những đám mây bồng bềnh, được làm từ bột mì, trứng, đường và kem tươi. Bánh được nướng ở nhiệt độ thấp để giữ độ ẩm và độ xốp. Chúng có thể được phủ lớp kem tươi hoặc sô cô la, hoặc được kết hợp với trái cây tươi. Bánh kem thích hợp cho những dịp đặc biệt hoặc ngày nắng nóng','2022-08-13', null);
INSERT INTO CATEGORY VALUES (N'Bánh bông lan',N'Bánh bông lan là loại bánh có lớp kem mỡ bơ, đường bột và hương liệu như vani hoặc ca cao. Kem mỡ bơ mịn màng thường được dùng để trang trí và phủ bánh. Bánh bông lan có nhiều hương vị và kem mỡ có thể được bơm thành các hình thức trang trí phức tạp, phổ biến trong các dịp đặc biệt như sinh nhật và đám cưới. Vị ngọt và béo của kem mỡ bơ hoàn hảo kết hợp với lớp bánh, tạo thành một món tráng miệng ngon và bắt mắt.','2022-07-22', null);
INSERT INTO CATEGORY VALUES (N'Bánh kem bọt',N'Bánh mousse là một loại bánh có lớp mousse nhẹ, mềm mịn là đặc trưng của bánh mousse truyền thống. Bạn có thể trải nghiệm hương vị nhẹ nhàng và độ béo ngậy của lớp mousse này.','2023-12-11', null);
INSERT INTO CATEGORY VALUES (N'Bánh kem cho bé',N'Bánh kem cho bé là một danh mục bánh ngọt dành cho những đứa trẻ yêu thích ăn ngọt và thích trang trí bánh. Bạn có thể tìm thấy nhiều loại bánh kem trẻ em khác nhau, từ bánh kem sinh nhật, bánh kem hình thú, bánh kem hình hoa, cho đến bánh kem hình siêu anh hùng. Bánh kem trẻ em không chỉ ngon miệng mà còn rất đẹp mắt và hấp dẫn.','2023-7-11', 1);
INSERT INTO CATEGORY VALUES (N'Bánh mì ngọt',N'Danh mục bánh mì ngọt là danh mục dành cho những ai yêu thích hương vị ngọt ngào của bánh mì. Bạn có thể tìm thấy nhiều loại bánh mì ngọt khác nhau, từ bánh mì sữa đến bánh mì phô mai, từ bánh mì trái cây đến bánh mì sô cô la. ','2023-11-25', null);
INSERT INTO CATEGORY VALUES (N'Bánh xốp',N'Bánh xốp là một loại bánh ngọt có kết cấu xốp, mềm và nhẹ, thường được làm từ bột, đường, trứng và bơ. Có nhiều loại bánh xốp khác nhau, như bánh gato, bánh cupcake, bánh muffin, bánh sponge và bánh chiffon. Mỗi loại bánh xốp có hương vị, hình dạng và kích thước riêng.','2023-10-25', 5);
INSERT INTO CATEGORY VALUES (N'Bánh rán',N'Bánh rán là một loại bánh ngọt có hình tròn, thường có một lỗ ở giữa. Bánh được làm từ bột mì, đường, bơ, sữa, men và trứng. Sau khi nhào bột, bánh được chiên trong dầu nóng cho đến khi vàng giòn. Bánh rán có thể được phủ lên bề mặt các loại sốt ngọt như sô-cô-la, kem, đường phèn hay mứt.','2023-11-17', null);
-- Insert Product Category -- 
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (1,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (2,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (3,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (4,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (5,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (6,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (7,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (8,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (9,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (10,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (11,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (12,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (13,1);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (14,2);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (15,2);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (16,2);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (17,2);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (18,2);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (19,2);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (20,2);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (21,3);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (22,3);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (23,3);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (24,3);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (25,3);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (26,4);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (27,4);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (28,4);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (29,5);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (30,5);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (31,5);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (32,5);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (33,5);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (34,5);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (35,5);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (36,5);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (37,5);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (38,5);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (39,5);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (40,6);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (41,6);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (42,6);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (43,6);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (44,6);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (45,7);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (46,7);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (47,7);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (48,7);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (49,7);
INSERT INTO PRODUCT_CATEGORY(ProductID, CategoryID) VALUES (50,7);

INSERT INTO ORDER_STATUS (OrderStatus) VALUES (N'Đang chờ xử lý');
INSERT INTO ORDER_STATUS (OrderStatus) VALUES (N'Đã xác nhận');
INSERT INTO ORDER_STATUS (OrderStatus) VALUES (N'Đang giao');
INSERT INTO ORDER_STATUS (OrderStatus) VALUES (N'Giao hàng thành công');
INSERT INTO ORDER_STATUS (OrderStatus) VALUES (N'Đã huỷ');


INSERT INTO PAYMENT_STATUS (PaymentStatus) VALUES (N'Chưa thanh toán trực tiếp');
INSERT INTO PAYMENT_STATUS (PaymentStatus) VALUES (N'Chưa thanh toán trực tuyến');
INSERT INTO PAYMENT_STATUS (PaymentStatus) VALUES (N'Đã thanh toán');

INSERT INTO ORDER_SHIPPING_METHOD(ShippingMethod) VALUES (N'Giao ngay');
INSERT INTO ORDER_SHIPPING_METHOD(ShippingMethod) VALUES (N'Hẹn lịch giao');


-- Chèn dữ liệu vào bảng CARD_TYPE
INSERT INTO CARD_TYPE ("Type") VALUES ('ATM'), ('Visa');
