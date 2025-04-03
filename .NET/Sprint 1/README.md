🍽️ RestaurantDB – Normalized SQL Server Database
📌 Project Overview
This repository contains the complete implementation of a fully normalized SQL Server database designed for a comprehensive Restaurant Management System.

✅ All tables, relationships, and constraints are implemented and aligned with the provided ERD and BRD documentation.

🧱 Database Scope
The RestaurantDB database supports the core backend structure for a digital restaurant ecosystem, including management of:

Users (Admins, Clients, Drivers, Employees)

Orders and Deliveries

Menu Items and Categories

Discounts and Offers

Notifications and Issues

Ratings and Reviews

Roles and Permissions

Lookup values for statuses, types, and regions

🔄 Generalization and Specialization
The system uses a generalized Users table for all actors (Admins, Clients, Employees, Drivers), with separate specialization tables for each role:

Generalized Table
sql
نسخ
تحرير
Users (
    UserID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100) UNIQUE,
    PhoneNumber NVARCHAR(20),
    PasswordHash NVARCHAR(MAX),
    ProfileImage NVARCHAR(255),
    UserType NVARCHAR(20),
    Status BIT,
    CreationDate DATETIME,
    CreatedBy INT,
    UpdatedDate DATETIME,
    UpdatedBy INT,
    IsActive BIT
)
Specialized Tables
Admins (AdminID, RoleID, JoinDate, EndDate, LastLogin)

Clients (ClientID, BirthDate, AccountStatusID)

Employees (EmployeeID, RoleID, JoinDate, EndDate)

Captains (CaptainID, VehicleTypeID, NumOfCompletedDeliveries, GPSLocation)

🗃️ Core Tables and Relationships
🔐 Roles & Permissions
Many-to-Many: Roles ↔ Permissions

Tables: Roles, Permissions, RolePermissions

🛍️ Menu System
Tables: Items, Categories, Discounts

Relationships:

Items ↔ Categories (M:1)

Items ↔ Discounts (Optional)

🧾 Orders
Tables: Orders, OrderItems, OrderTracking

Relationships:

Many-to-Many: Orders ↔ Items via OrderItems

One-to-One: Orders ↔ OrderTracking

Orders has optional DiscountID and AssignedCaptainID

🧍 Client-Specific
Tables:

Addresses

PaymentMethods

FavoriteItems (M:M: Clients ↔ Items)

RatingsReviews

ReportedIssues

📢 Notifications
Unified Notifications table: stores messages sent to Admins, Clients, and Drivers.

Foreign keys to user roles.

⚙️ Lookup & Supporting Tables
Implemented fully normalized lookup tables:

AccountStatus, OrderStatus, VehicleType, CardType

NotificationType, IssueType, Region, Province, ItemOptionType

All have:

sql
نسخ
تحرير
LookupTable (
    ID INT PRIMARY KEY,
    NameEN NVARCHAR(50),
    NameAR NVARCHAR(50)
)
🧪 Constraints and Normalization
✅ 3NF Compliance: All transitive dependencies are removed.

✅ All PKs and FKs implemented.

✅ Composite PKs used for join tables (OrderItems, FavoriteItems, RolePermissions).

✅ Unique constraints on emails, usernames, etc.

✅ All required NOT NULL, DEFAULT, and CHECK constraints applied where needed.

🧰 Sample Join Table Definitions
OrderItems (M:M)
sql
نسخ
تحرير
CREATE TABLE OrderItems (
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ItemID INT FOREIGN KEY REFERENCES Items(ItemID),
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, ItemID)
)
FavoriteItems
sql
نسخ
تحرير
CREATE TABLE FavoriteItems (
    ClientID INT FOREIGN KEY REFERENCES Clients(ClientID),
    ItemID INT FOREIGN KEY REFERENCES Items(ItemID),
    PRIMARY KEY (ClientID, ItemID)
)
🔐 Example: Roles & Permissions
sql
نسخ
تحرير
Roles (
    RoleID INT PRIMARY KEY,
    RoleNameEN NVARCHAR(50),
    RoleNameAR NVARCHAR(50),
    IsActive BIT
)

Permissions (
    PermissionID INT PRIMARY KEY,
    PermissionName NVARCHAR(100),
    PermissionDescription NVARCHAR(MAX)
)

RolePermissions (
    RoleID INT,
    PermissionID INT,
    PRIMARY KEY (RoleID, PermissionID),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID),
    FOREIGN KEY (PermissionID) REFERENCES Permissions(PermissionID)
)
📥 Contents of This Repository
bash
نسخ
تحرير
RestaurantDB/
├── RestaurantDB.bacpac       # SQL Server export of full normalized DB
├── README.md                 # This file
├── ERD/                      # ER Diagram image
│   └── ER-Diagram.png
├── BRD/
│   ├── Capstone BRD v1.1.pdf
│   └── BRD Analysis.docx
└── SQL/
    ├── CreateTables.sql      # (optional) script for schema creation
    └── SampleData.sql        # (optional) script to seed sample data
✅ Confirmed Implementation (Based on BRD & ERD)
This database implementation fully aligns with:

✔️ Business flows and entities in the Capstone BRD v1.1

✔️ Functional and data scope from BRD Analysis

✔️ Structure of the ER Diagram

✔️ Database schema extracted from RestaurantDB.bacpac
