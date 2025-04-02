CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(150) UNIQUE NOT NULL,
    PhoneNumber NVARCHAR(20) NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    ProfileImage NVARCHAR(255),
    UserTypeID INT NOT NULL, -- FK from LookupItems where LookupType = 'Role'
    StatusID INT NOT NULL, -- FK from LookupItems where LookupType = 'AccountStatus'
    CONSTRAINT FK_Users_UserType FOREIGN KEY (UserTypeID) REFERENCES LookupItems(LookupItemID),
    CONSTRAINT FK_Users_Status FOREIGN KEY (StatusID) REFERENCES LookupItems(LookupItemID)
);

CREATE TABLE Admins (
    AdminID INT PRIMARY KEY, -- FK to Users
    RoleID INT NOT NULL, -- FK to LookupItems where LookupType = 'Role'
    JoinDate DATE NOT NULL,
    EndDate DATE,
    LastLogin DATETIME,
    FOREIGN KEY (AdminID) REFERENCES Users(UserID),
    FOREIGN KEY (RoleID) REFERENCES LookupItems(LookupItemID)
);

CREATE TABLE Clients (
    ClientID INT PRIMARY KEY, -- FK to Users
    BirthDate DATE,
    FOREIGN KEY (ClientID) REFERENCES Users(UserID)
);

CREATE TABLE Deliveries (
    CaptainID INT PRIMARY KEY, -- FK to Users
    VehicleTypeID INT NOT NULL, -- FK LookupItems where LookupType = 'VehicleType'
    NumOfCompletedDeliveries INT DEFAULT 0,
    FOREIGN KEY (CaptainID) REFERENCES Users(UserID),
    FOREIGN KEY (VehicleTypeID) REFERENCES LookupItems(LookupItemID)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY, -- FK to Users
    RoleID INT NOT NULL, -- FK LookupItems where LookupType = 'Role'
    JoinDate DATE NOT NULL,
    EndDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Users(UserID),
    FOREIGN KEY (RoleID) REFERENCES LookupItems(LookupItemID)
);