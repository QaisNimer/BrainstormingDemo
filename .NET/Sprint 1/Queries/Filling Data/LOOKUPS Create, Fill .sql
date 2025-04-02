-- =========================================
-- Generic Lookup Tables
-- =========================================

CREATE TABLE LookupTypes (
    LookupTypeID INT IDENTITY(1,1) PRIMARY KEY,
    LookupTypeName NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE LookupItems (
    LookupItemID INT IDENTITY(1,1) PRIMARY KEY,
    LookupTypeID INT NOT NULL,
    NameEN NVARCHAR(100) NOT NULL,
    NameAR NVARCHAR(100) NOT NULL,
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (LookupTypeID) REFERENCES LookupTypes(LookupTypeID)
);

-- Insert Lookup Types
INSERT INTO LookupTypes (LookupTypeName) VALUES
('Role'), ('Permission'), ('AccountStatus'), ('VehicleType'), 
('DiscountType'), ('NotificationType'), ('IssueType'), ('OrderStatus'),
('Region'), ('Province'), ('CardType'), ('ItemOptionType');

-- Insert Lookup Items Example
-- Insert Lookup Items Example (fixed for Arabic)
INSERT INTO LookupItems (LookupTypeID, NameEN, NameAR) VALUES
(1, 'SuperAdmin', N'مشرف عام'),
(1, 'Admin', N'مشرف'),
(1, 'Client', N'عميل'),
(1, 'Delivery', N'كابتن'),
(1, 'Employee', N'موظف'),

(3, 'Active', N'نشط'),
(3, 'Inactive', N'غير نشط'),
(3, 'Blocked', N'محظور');
