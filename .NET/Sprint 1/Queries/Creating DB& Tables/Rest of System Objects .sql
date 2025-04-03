CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    NameEN NVARCHAR(100) NOT NULL,
    NameAR NVARCHAR(100) NOT NULL,
    ImagePath NVARCHAR(255),
    IsActive BIT DEFAULT 1
);

CREATE TABLE Items (
    ItemID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryID INT NOT NULL,
    EnglishName NVARCHAR(100) NOT NULL,
    ArabicName NVARCHAR(100) NOT NULL,
    DescriptionEN NVARCHAR(255),
    DescriptionAR NVARCHAR(255),
    ImagePath NVARCHAR(255),
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT DEFAULT 0,
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Discounts (
    DiscountID INT IDENTITY(1,1) PRIMARY KEY,
    TitleEN NVARCHAR(100) NOT NULL,
    TitleAR NVARCHAR(100) NOT NULL,
    DescriptionEN NVARCHAR(255),
    DescriptionAR NVARCHAR(255),
    StartDate DATE,
    EndDate DATE,
    DiscountPercentage DECIMAL(5,2),
    Code NVARCHAR(50),
    LimitUsage INT
);

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    ClientID INT NOT NULL,
    DiscountID INT,
    DeliveryFee DECIMAL(10,2),
    OrderStatusID INT NOT NULL,
    AssignedCaptainID INT,
    PaymentMethodID INT,
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (DiscountID) REFERENCES Discounts(DiscountID),
    FOREIGN KEY (OrderStatusID) REFERENCES LookupItems(LookupItemID),
    FOREIGN KEY (AssignedCaptainID) REFERENCES Deliveries(CaptainID)
);

CREATE TABLE OrderItems (
    OrderID INT NOT NULL,
    ItemID INT NOT NULL,
    Quantity INT DEFAULT 1,
    PRIMARY KEY (OrderID, ItemID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
);

CREATE TABLE Addresses (
    AddressID INT IDENTITY(1,1) PRIMARY KEY,
    ClientID INT NOT NULL,
    RegionID INT NOT NULL,
    ProvinceID INT NOT NULL,
    AddressDetails NVARCHAR(255),
    GPSLocation NVARCHAR(255),
    Title NVARCHAR(100),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);

CREATE TABLE PaymentMethods (
    PaymentMethodID INT IDENTITY(1,1) PRIMARY KEY,
    ClientID INT NOT NULL,
    CardTypeID INT NOT NULL,
    Last4Digits NVARCHAR(4) NOT NULL,
    ExpiryDate DATE NOT NULL,
    IsDefault BIT DEFAULT 0,
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);

CREATE TABLE FavoriteItems (
    ClientID INT NOT NULL,
    ItemID INT NOT NULL,
    PRIMARY KEY (ClientID, ItemID),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
);

CREATE TABLE OrdersTracking (
    TrackingID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT UNIQUE,
    CaptainID INT NOT NULL,
    CurrentStatus NVARCHAR(100),
    LastUpdatedLocation NVARCHAR(255),
    EstimatedArrivalTime DATETIME,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (CaptainID) REFERENCES Deliveries(CaptainID)
);

CREATE TABLE Notifications (
    NotificationID INT IDENTITY(1,1) PRIMARY KEY,
    ReceiverID INT NOT NULL,
    Title NVARCHAR(100),
    Message NVARCHAR(255),
    NotificationTypeID INT NOT NULL,
    IsRead BIT DEFAULT 0,
    FOREIGN KEY (ReceiverID) REFERENCES Users(UserID),
    FOREIGN KEY (NotificationTypeID) REFERENCES LookupItems(LookupItemID)
);

CREATE TABLE RatingsAndReviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    ClientID INT NOT NULL,
    OrderID INT NOT NULL,
    ItemID INT,
    CaptainID INT,
    RatingValue INT,
    ReviewText NVARCHAR(500),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);

CREATE TABLE ReportedIssues (
    IssueID INT IDENTITY(1,1) PRIMARY KEY,
    ClientID INT NOT NULL,
    OrderID INT NOT NULL,
    IssueTypeID INT NOT NULL,
    Description NVARCHAR(500),
    Status NVARCHAR(50),
    AdminResponse NVARCHAR(500),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID));


CREATE TABLE Roles (
    RoleID INT IDENTITY(1,1) PRIMARY KEY,
    RoleNameEN NVARCHAR(100) NOT NULL,
    RoleNameAR NVARCHAR(100) NOT NULL
);


CREATE TABLE Permissions (
    PermissionID INT IDENTITY(1,1) PRIMARY KEY,
    PermissionName NVARCHAR(100) NOT NULL,
    PermissionDescription NVARCHAR(255)
);


CREATE TABLE RolePermissions (
    RoleID INT NOT NULL,
    PermissionID INT NOT NULL,
    PRIMARY KEY (RoleID, PermissionID),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID),
    FOREIGN KEY (PermissionID) REFERENCES Permissions(PermissionID)
);
