
-- Insert 4 Departments
INSERT INTO departments (department_id, department_name, budget, rules, policy) VALUES
(10001, 'IT', 1200000.00, 'Maintain cybersecurity protocols and software updates.', 'Data privacy and security are mandatory.'),
(10002, 'HR', 500000.00, 'Follow all compliance and employee engagement rules.', 'Ensure fair hiring practices.'),
(10003, 'Finance', 900000.00, 'Ensure accurate bookkeeping and timely reporting.', 'All expenses must be justified with documentation.'),
(10004, 'Sales', 750000.00, 'Meet quarterly targets and follow ethical sales practices.', 'All sales data must be reported weekly.');

-- Insert Users
-- 4 Department Managers (1 per department)
INSERT INTO users (user_id, name, email, password, role, created_at, department_id, no_of_assigned_tickets) VALUES
(11001, 'Alice Johnson', 'alice.johnson@company.com', '$2a$10$OzJgqM0zlqj2SfUjR6ePZ.K0thqnOcKKlNp.DDtZrxzpR3jZM7wlm', 'MANAGER', '2025-05-31', 10001, 0),
(11002, 'Brian Smith', 'brian.smith@company.com', '$2a$10$10OqhytF7yqNEStY4WIw6OR6u2gcUBgdxnaunvs7k8JKwjGHxQheq', 'MANAGER', '2025-05-31', 10002, 0),
(11003, 'Clara Williams', 'clara.williams@company.com', '$2a$10$JIRJrKdFpD6z9WfUmw2PGu61JmYQkjpKR9H0kTIpter3P3wPRfV9O', 'MANAGER', '2025-05-31', 10003, 0),
(11004, 'David Lee', 'david.lee@company.com', '$2a$10$j0DhEFCe6oOy4MFtYJCtLuja1iC1WmzctRCEfeIjZa5IAShNzfLnG', 'MANAGER', '2025-05-31', 10004, 0);

-- 3 Admins (all in IT department)
INSERT INTO users (user_id, name, email, password, role, created_at, department_id, no_of_assigned_tickets) VALUES
(11005, 'Grace Kim', 'grace.kim@company.com', '$2a$10$JUR3fIvMdKwWK5rid1GDsOZ8YFc/3pqUkD.X6DD3ulaHq2yc0t8ey', 'ADMIN', '2025-05-31', 10001, 0),
(11006, 'Henry Patel', 'henry.patel@company.com', '$2a$10$JutMWJwWP/j1bEE3kGAXVOmcVfagXBLipjKOtxRnlELZNW4F3AaU6', 'ADMIN', '2025-05-31', 10001, 0),
(11007, 'Irene Brown', 'irene.brown@company.com', '$2a$10$2UqR4F3rppoWck14xTLeFuDp.0./JXJB6WcseB67d/1mZWPlbsFky', 'ADMIN', '2025-05-31', 10001, 0);

-- 6 Employees (2 each in HR, Finance, Sales - none in IT)
INSERT INTO users (user_id, name, email, password, role, created_at, department_id, no_of_assigned_tickets) VALUES
(11008, 'Jack Wilson', 'jack.wilson@company.com', '$2a$10$2G/xmOuJAkKDJw85V30aLOl5euQwQHIUGY0Etm0Fr1UAlIoY3TknG', 'EMPLOYEE', '2025-05-31', 10002, 0),
(11009, 'Kathy Moore', 'kathy.moore@company.com', '$2a$10$DaWl2.Cb.CyNuasMBsrDXu7HcAbypb.31TNeSsZQ52zBYRQFNrHkK', 'EMPLOYEE', '2025-05-31', 10002, 0),
(11010, 'Liam White', 'liam.white@company.com', '$2a$10$CGDvU2N4fPo80FsFYC7zFek0pAW3v7IgAzn2DQj6Lfb27sb4Ua54O', 'EMPLOYEE', '2025-05-31', 10003, 0),
(11011, 'Mia Scott', 'mia.scott@company.com', '$2a$10$9bQhaDLtM2y1i4PKYLzQNeDHXolk/wG4WtCsv1PleyVOkDnVPCMce', 'EMPLOYEE', '2025-05-31', 10003, 0),
(11012, 'Noah Hall', 'noah.hall@company.com', '$2a$10$TcqU114lmnPiDoUyTXxpCus4CRtQdgeUgWTDIw0Mrk.5zXJS4ERKC', 'EMPLOYEE', '2025-05-31', 10004, 0),
(11013, 'Olivia Adams', 'olivia.adams@company.com', '$2a$10$YV10xChUphqswfWIdS.CEeVGAhiG8i.kjgpjXj7kibXubqA9953L.', 'EMPLOYEE', '2025-05-31', 10004, 0);

-- Insert 25 Assets (all ALLOCATED)
INSERT INTO assets (asset_id, serial_number, brand, model, purchase_date, status, maintenance_count) VALUES
(12001, 'SN0012001', 'Dell', 'XPS13', '2024-01-15', 'ALLOCATED', 1),
(12002, 'SN0012002', 'HP', 'EliteBook', '2024-01-20', 'ALLOCATED', 1),
(12003, 'SN0012003', 'Apple', 'MacBook Pro', '2024-02-10', 'ALLOCATED', 1),
(12004, 'SN0012004', 'Lenovo', 'ThinkPad X1', '2024-02-15', 'ALLOCATED', 1),
(12005, 'SN0012005', 'Acer', 'Aspire 5', '2024-02-20', 'ALLOCATED', 1),
(12006, 'SN0012006', 'Dell', 'Latitude 7420', '2024-03-01', 'ALLOCATED', 1),
(12007, 'SN0012007', 'HP', 'Pavilion', '2024-03-05', 'ALLOCATED', 1),
(12008, 'SN0012008', 'Apple', 'MacBook Air', '2024-03-10', 'ALLOCATED', 1),
(12009, 'SN0012009', 'Lenovo', 'IdeaPad 3', '2024-03-15', 'ALLOCATED', 1),
(12010, 'SN0012010', 'Acer', 'Swift 3', '2024-03-20', 'ALLOCATED', 1),
(12011, 'SN0012011', 'Dell', 'XPS15', '2024-04-01', 'ALLOCATED', 1),
(12012, 'SN0012012', 'HP', 'ProBook 450', '2024-04-05', 'ALLOCATED', 1),
(12013, 'SN0012013', 'Apple', 'MacBook Pro M1', '2024-04-10', 'ALLOCATED', 1),
(12014, 'SN0012014', 'Lenovo', 'Yoga Slim 7', '2024-04-15', 'AVAILABLE', 0),
(12015, 'SN0012015', 'Acer', 'Nitro 5', '2024-04-20', 'AVAILABLE', 0),
(12016, 'SN0012016', 'Dell', 'Inspiron 15', '2024-04-25', 'AVAILABLE', 0),
(12017, 'SN0012017', 'HP', 'Spectre x360', '2024-05-01', 'AVAILABLE', 0),
(12018, 'SN0012018', 'Apple', 'MacBook Air M2', '2024-05-05', 'AVAILABLE', 0),
(12019, 'SN0012019', 'Lenovo', 'ThinkBook 14', '2024-05-10', 'AVAILABLE', 0),
(12020, 'SN0012020', 'Acer', 'TravelMate', '2024-05-15', 'AVAILABLE', 0),
(12021, 'SN0012021', 'Dell', 'XPS13 Plus', '2024-05-20', 'AVAILABLE', 0),
(12022, 'SN0012022', 'HP', 'Envy x360', '2024-05-25', 'AVAILABLE', 0),
(12023, 'SN0012023', 'Apple', 'MacBook Pro M2', '2024-05-30', 'AVAILABLE', 0),
(12024, 'SN0012024', 'Lenovo', 'Flex 5', '2025-05-01', 'AVAILABLE', 0),
(12025, 'SN0012025', 'Acer', 'Spin 5', '2025-05-15', 'AVAILABLE', 0);


-- Insert Department Asset Tracking (1 asset per user)
INSERT INTO department_asset_tracking (id, department_id, user_id, asset_id, policy_compliance, allocation_date) VALUES
-- IT Manager
(13001, 10001, 11001, 12001, 'YES', '2025-05-31'),
-- HR Manager  
(13002, 10002, 11002, 12002, 'YES', '2025-05-31'),
-- Finance Manager
(13003, 10003, 11003, 12003, 'YES', '2025-05-31'),
-- Sales Manager
(13004, 10004, 11004, 12004, 'YES', '2025-05-31'),
-- IT Admins
(13005, 10001, 11005, 12005, 'YES', '2025-05-31'),
(13006, 10001, 11006, 12006, 'YES', '2025-05-31'),
(13007, 10001, 11007, 12007, 'YES', '2025-05-31'),
-- HR Employees
(13008, 10002, 11008, 12008, 'YES', '2025-05-31'),
(13009, 10002, 11009, 12009, 'YES', '2025-05-31'),
-- Finance Employees
(13010, 10003, 11010, 12010, 'YES', '2025-05-31'),
(13011, 10003, 11011, 12011, 'YES', '2025-05-31'),
-- Sales Employees
(13012, 10004, 11012, 12012, 'YES', '2025-05-31'),
(13013, 10004, 11013, 12013, 'YES', '2025-05-31');

-- Insert 10 Vendors
INSERT INTO vendors (vendor_id, vendor_name, contact_person, contact_email, contact_phone) VALUES
(15001, 'Dell Technologies', 'John Smith', 'john.smith@dell.com', '+1-800-555-0101'),
(15002, 'HP Inc.', 'Sarah Johnson', 'sarah.johnson@hp.com', '+1-800-555-0102'),
(15003, 'Apple Inc.', 'Michael Brown', 'michael.brown@apple.com', '+1-800-555-0103'),
(15004, 'Lenovo Group', 'Emily Davis', 'emily.davis@lenovo.com', '+1-800-555-0104'),
(15005, 'Acer Inc.', 'David Wilson', 'david.wilson@acer.com', '+1-800-555-0105'),
(15006, 'Microsoft Corporation', 'Lisa Anderson', 'lisa.anderson@microsoft.com', '+1-800-555-0106'),
(15007, 'Intel Corporation', 'Robert Taylor', 'robert.taylor@intel.com', '+1-800-555-0107'),
(15008, 'AMD Inc.', 'Jennifer Martinez', 'jennifer.martinez@amd.com', '+1-800-555-0108'),
(15009, 'NVIDIA Corporation', 'Christopher Lee', 'christopher.lee@nvidia.com', '+1-800-555-0109'),
(15010, 'Cisco Systems', 'Amanda White', 'amanda.white@cisco.com', '+1-800-555-0110');

-- Insert 10 Procurement Orders
INSERT INTO procurement_orders (order_id, vendor_id, quantity, order_status, order_date) VALUES
(16001, 15001, 5, 'PENDING', '2025-05-25'),
(16002, 15002, 3, 'RECEIVED', '2025-05-26'),
(16003, 15003, 4, 'CANCELLED', '2025-05-27'),
(16004, 15004, 6, 'PENDING', '2025-05-28'),
(16005, 15005, 2, 'RECEIVED', '2025-05-29'),
(16006, 15006, 8, 'CANCELLED', '2025-05-30'),
(16007, 15007, 3, 'PENDING', '2025-05-31'),
(16008, 15008, 5, 'RECEIVED', '2025-05-31'),
(16009, 15009, 7, 'RECEIVED', '2025-05-31'),
(16010, 15010, 4, 'PENDING', '2025-05-31');

-- Insert Maintenance for each allocated asset (13 assets)
INSERT INTO maintenance (maintenance_id, asset_id, description, scheduled_date, status) VALUES
(17001, 12001, 'TechDesk- Patch deployment scheduled, Please do not shutdown your system, important security updates are being installed on your computer, window will disappear after the installation, You may minimize the window', NOW(), 'SCHEDULED'),
(17002, 12002, 'TechDesk- Patch deployment scheduled, Please do not shutdown your system, important security updates are being installed on your computer, window will disappear after the installation, You may minimize the window', NOW(), 'SCHEDULED'),
(17003, 12003, 'TechDesk- Patch deployment scheduled, Please do not shutdown your system, important security updates are being installed on your computer, window will disappear after the installation, You may minimize the window', NOW(), 'SCHEDULED'),
(17004, 12004, 'TechDesk- Patch deployment scheduled, Please do not shutdown your system, important security updates are being installed on your computer, window will disappear after the installation, You may minimize the window', NOW(), 'SCHEDULED'),
(17005, 12005, 'TechDesk- Patch deployment scheduled, Please do not shutdown your system, important security updates are being installed on your computer, window will disappear after the installation, You may minimize the window', NOW(), 'SCHEDULED'),
(17006, 12006, 'TechDesk- Patch deployment scheduled, Please do not shutdown your system, important security updates are being installed on your computer, window will disappear after the installation, You may minimize the window', NOW(), 'SCHEDULED'),
(17007, 12007, 'TechDesk- Patch deployment scheduled, Please do not shutdown your system, important security updates are being installed on your computer, window will disappear after the installation, You may minimize the window', NOW(), 'SCHEDULED'),
(17008, 12008, 'TechDesk- Patch deployment scheduled, Please do not shutdown your system, important security updates are being installed on your computer, window will disappear after the installation, You may minimize the window', NOW(), 'SCHEDULED'),
(17009, 12009, 'TechDesk- Patch deployment scheduled, Please do not shutdown your system, important security updates are being installed on your computer, window will disappear after the installation, You may minimize the window', NOW(), 'SCHEDULED'),
(17010, 12010, 'TechDesk- Patch deployment scheduled, Please do not shutdown your system, important security updates are being installed on your computer, window will disappear after the installation, You may minimize the window', NOW(), 'SCHEDULED'),
(17011, 12011, 'TechDesk- Patch deployment scheduled, Please do not shutdown your system, important security updates are being installed on your computer, window will disappear after the installation, You may minimize the window', NOW(), 'SCHEDULED'),
(17012, 12012, 'TechDesk- Patch deployment scheduled, Please do not shutdown your system, important security updates are being installed on your computer, window will disappear after the installation, You may minimize the window', NOW(), 'SCHEDULED'),
(17013, 12013, 'TechDesk- Patch deployment scheduled, Please do not shutdown your system, important security updates are being installed on your computer, window will disappear after the installation, You may minimize the window', NOW(), 'SCHEDULED');

-- Insert Welcome Notifications for all users (13 users)
INSERT INTO notifications (notification_id, user_id, request_id, description, status, date_created) VALUES
(18001, 11001, 'WELCOME_001', 'Welcome to TechDesk- IT Asset Management System', 'SENT', CURDATE()),
(18002, 11002, 'WELCOME_002', 'Welcome to TechDesk- IT Asset Management System', 'SENT', CURDATE()),
(18003, 11003, 'WELCOME_003', 'Welcome to TechDesk- IT Asset Management System', 'SENT', CURDATE()),
(18004, 11004, 'WELCOME_004', 'Welcome to TechDesk- IT Asset Management System', 'SENT', CURDATE()),
(18005, 11005, 'WELCOME_005', 'Welcome to TechDesk- IT Asset Management System', 'SENT', CURDATE()),
(18006, 11006, 'WELCOME_006', 'Welcome to TechDesk- IT Asset Management System', 'SENT', CURDATE()),
(18007, 11007, 'WELCOME_007', 'Welcome to TechDesk- IT Asset Management System', 'SENT', CURDATE()),
(18008, 11008, 'WELCOME_008', 'Welcome to TechDesk- IT Asset Management System', 'SENT', CURDATE()),
(18009, 11009, 'WELCOME_009', 'Welcome to TechDesk- IT Asset Management System', 'SENT', CURDATE()),
(18010, 11010, 'WELCOME_010', 'Welcome to TechDesk- IT Asset Management System', 'SENT', CURDATE()),
(18011, 11011, 'WELCOME_011', 'Welcome to TechDesk- IT Asset Management System', 'SENT', CURDATE()),
(18012, 11012, 'WELCOME_012', 'Welcome to TechDesk- IT Asset Management System', 'SENT', CURDATE()),
(18013, 11013, 'WELCOME_013', 'Welcome to TechDesk- IT Asset Management System', 'SENT', CURDATE());

