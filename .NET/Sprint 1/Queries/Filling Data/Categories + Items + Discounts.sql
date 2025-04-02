-- =============================
-- Sample Data Insert Block 1
-- =============================

-- Categories
INSERT INTO Categories (NameEN, NameAR, ImagePath)
VALUES 
('Burgers', N'برجر', NULL),
('Pizza', N'بيتزا', NULL),
('Drinks', N'مشروبات', NULL);

-- Items
INSERT INTO Items (CategoryID, EnglishName, ArabicName, DescriptionEN, DescriptionAR, Price, StockQuantity)
VALUES
(1, 'Cheeseburger', N'تشيز برجر', 'Beef burger with cheese', N'برجر لحم مع جبنة', 25.50, 100),
(2, 'Pepperoni Pizza', N'بيتزا ببروني', 'Classic pepperoni pizza', N'بيتزا ببروني كلاسيكية', 40.00, 50),
(3, 'Coca Cola', N'كوكاكولا', 'Chilled soft drink', N'مشروب غازي بارد', 5.00, 200);

-- Discounts
INSERT INTO Discounts (TitleEN, TitleAR, DescriptionEN, DescriptionAR, StartDate, EndDate, DiscountPercentage, Code, LimitUsage)
VALUES
('New Year Offer', N'عرض رأس السنة', '10% off on all orders', N'خصم 10٪ على جميع الطلبات', '2025-01-01', '2025-01-10', 10.00, 'NY2025', 100);
