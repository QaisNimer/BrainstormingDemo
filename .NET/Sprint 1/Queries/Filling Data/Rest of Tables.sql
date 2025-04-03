-- =============================
-- Sample Data Insert Block 3
-- =============================

-- Address for Client
INSERT INTO Addresses (ClientID, RegionID, ProvinceID, AddressDetails, GPSLocation, Title)
VALUES (3, 1, 1, '123 Main Street', '24.7136,46.6753', 'Home');

-- Payment Method for Client
INSERT INTO PaymentMethods (ClientID, CardTypeID, Last4Digits, ExpiryDate, IsDefault)
VALUES (3, 1, '1234', '2026-12-31', 1);

-- Order by Client
INSERT INTO Orders (ClientID, DiscountID, DeliveryFee, OrderStatusID, AssignedCaptainID, PaymentMethodID)
VALUES (3, 1, 5.00, 8, 4, 1); -- Assuming 8=OrderStatus (Active)

-- OrderItems
INSERT INTO OrderItems (OrderID, ItemID, Quantity)
VALUES 
(1, 1, 2), -- Cheeseburger x2
(1, 3, 1); -- CocaCola x1

-- Favorite Items for Client
INSERT INTO FavoriteItems (ClientID, ItemID)
VALUES 
(3, 1),
(3, 3);

-- Ratings and Reviews
INSERT INTO RatingsAndReviews (ClientID, OrderID, ItemID, CaptainID, RatingValue, ReviewText)
VALUES
(3, 1, 1, 4, 5, 'Excellent burger and fast delivery');

-- Reported Issue
INSERT INTO ReportedIssues (ClientID, OrderID, IssueTypeID, Description, Status)
VALUES
(3, 1, 1, 'The drink was missing', 'Open');

-- Order Tracking
INSERT INTO OrdersTracking (OrderID, CaptainID, CurrentStatus, LastUpdatedLocation, EstimatedArrivalTime)
VALUES
(1, 4, 'On the way', '24.7137,46.6758', DATEADD(MINUTE,30,GETDATE()));

-- Notification for Client
INSERT INTO Notifications (ReceiverID, Title, Message, NotificationTypeID)
VALUES
(3, 'Order Dispatched', 'Your order has been dispatched and is on the way.', 1); -- Assuming 1=Order Notification Type


-- Insert Roles
INSERT INTO Roles (RoleNameEN, RoleNameAR) VALUES
('SuperAdmin', N'مشرف عام'),
('Admin', N'مشرف'),
('Employee', N'موظف');

-- Insert Sample Permissions
INSERT INTO Permissions (PermissionName, PermissionDescription) VALUES
('ManageAdmins', 'Create, update, and delete admin users'),
('ManageItems', 'Create, update, and disable items'),
('ManageOrders', 'Update order status and track orders'),
('ViewReports', 'Access to various system reports'),
('ManageClients', 'Enable/disable clients and view their orders'),
('ManageDiscounts', 'Create and manage discounts and offers');

-- Assign Permissions to Roles (e.g., Admin has all)
INSERT INTO RolePermissions (RoleID, PermissionID) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), -- SuperAdmin: All
(2, 2), (2, 3), (2, 5), (2, 6),                 -- Admin: Some
(3, 2);                                         -- Employee: Only manage items
