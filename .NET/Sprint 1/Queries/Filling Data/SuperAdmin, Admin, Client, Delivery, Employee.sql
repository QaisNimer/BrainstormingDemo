-- =============================
-- Sample Data Insert Block 2
-- =============================

-- SuperAdmin User
INSERT INTO Users (FirstName, LastName, Email, PhoneNumber, Password, UserTypeID, StatusID)
VALUES ('Ahmed', 'SuperAdmin', 'superadmin@test.com', '0500000001', 'hashed_pwd', 1, 6); -- Assuming 1=SuperAdmin, 6=Active

-- Admin User
INSERT INTO Users (FirstName, LastName, Email, PhoneNumber, Password, UserTypeID, StatusID)
VALUES ('Sara', 'Admin', 'admin@test.com', '0500000002', 'hashed_pwd', 2, 6); -- Assuming 2=Admin

-- Insert Admin Role assignment
INSERT INTO Admins (AdminID, RoleID, JoinDate, LastLogin)
VALUES (2, 2, '2024-01-01', GETDATE());

-- Client User
INSERT INTO Users (FirstName, LastName, Email, PhoneNumber, Password, UserTypeID, StatusID)
VALUES ('Mohammed', 'Client', 'client@test.com', '0500000003', 'hashed_pwd', 3, 6);

INSERT INTO Clients (ClientID, BirthDate)
VALUES (3, '1995-05-15');

-- Delivery (Captain)
INSERT INTO Users (FirstName, LastName, Email, PhoneNumber, Password, UserTypeID, StatusID)
VALUES ('Khaled', 'Captain', 'captain@test.com', '0500000004', 'hashed_pwd', 4, 6);

INSERT INTO Deliveries (CaptainID, VehicleTypeID, NumOfCompletedDeliveries)
VALUES (4, 1, 10); -- Assuming 1=VehicleTypeID Motorcycle

-- Employee
INSERT INTO Users (FirstName, LastName, Email, PhoneNumber, Password, UserTypeID, StatusID)
VALUES ('Laila', 'Employee', 'employee@test.com', '0500000005', 'hashed_pwd', 5, 6);

INSERT INTO Employees (EmployeeID, RoleID, JoinDate)
VALUES (5, 2, '2024-02-01');
