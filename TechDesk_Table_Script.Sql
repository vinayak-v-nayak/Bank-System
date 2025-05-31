drop database if exists techdesk_db;
create database techdesk_db;
use techdesk_db

CREATE TABLE departments(
	
	department_id int AUTO_INCREMENT PRIMARY KEY ,
	department_name VARCHAR(255)NOT NULL,
	budget DECIMAL(12,2),
	rules TEXT,
	policy TEXT
);


CREATE TABLE users(
	user_id INT  AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	email VARCHAR(255) UNIQUE NOT NULL,
	password VARCHAR(255) NOT NULL,
	role varchar(50) NOT NULL,
	created_at DATE,
	department_id int,
	no_of_assigned_tickets int default 0,
	FOREIGN KEY(department_id) REFERENCES departments(department_id)
);





CREATE TABLE assets(
	asset_id int AUTO_INCREMENT PRIMARY KEY ,
	serial_number VARCHAR(255)not null,
	brand VARCHAR(100),
	model VARCHAR(100),
	purchase_date DATE,
	maintenance_count int DEFAULT 0,
	status varchar(50) DEFAULT 'AVAILABLE'
	);
	
	


CREATE TABLE department_asset_tracking(
	id int AUTO_INCREMENT PRIMARY KEY,
	department_id int,
	user_id int,
	asset_id int,
	policy_compliance varchar(50) DEFAULT 'YES',
	allocation_date DATE,
	FOREIGN KEY(department_id) REFERENCES departments(department_id),
	FOREIGN KEY(user_id) REFERENCES users(user_id),
	FOREIGN KEY(asset_id) REFERENCES assets(asset_id)
	
);




CREATE TABLE asset_request(
	request_id int AUTO_INCREMENT PRIMARY KEY,
	user_id int ,
	status varchar(50) DEFAULT 'PENDING',
	request_date DATE ,
	decision_date DATE,
	FOREIGN KEY(user_id) REFERENCES users(user_id)
	
	
);
CREATE TABLE attachments(
	attachment_id int AUTO_INCREMENT PRIMARY KEY,
	file_name varchar(100) unique,
	file_type varchar(50),
	ticket_attachment LONGBLOB
);


CREATE TABLE support_tickets(
	ticket_id int AUTO_INCREMENT PRIMARY KEY,
	user_id int,
	asset_id int,
	issue_description TEXT,
	status varchar(50) DEFAULT 'OPEN',
	priority varchar(50) DEFAULT 'LOW',
	created_at DATE ,
	resolved_at DATE,
	attachment_id int,
	assigned_to int,
	comments TEXT,
	FOREIGN KEY(user_id) REFERENCES users(user_id),
	FOREIGN KEY(asset_id) REFERENCES assets(asset_id),
	FOREIGN KEY(assigned_to)REFERENCES users(user_id),
	FOREIGN KEY(attachment_id) REFERENCES attachments(attachment_id)
);





CREATE TABLE returns(
	return_id int AUTO_INCREMENT PRIMARY KEY,
	user_id int,
	asset_id int,
	reason TEXT,
	status varchar(50) DEFAULT 'PENDING',
		return_request_date DATE,
	decision_date DATE,
		FOREIGN KEY(user_id) REFERENCES users(user_id),
	FOREIGN KEY(asset_id) REFERENCES assets(asset_id)
	
);



CREATE TABLE disposals(
	disposal_id int AUTO_INCREMENT PRIMARY KEY,
	asset_id int,
	disposal_reason TEXT,
	disposal_date DATE ,
	FOREIGN KEY(asset_id) REFERENCES assets(asset_id)
);



CREATE TABLE vendors(
	vendor_id int AUTO_INCREMENT PRIMARY KEY,
	vendor_name VARCHAR(255) NOT NULL,
	contact_person VARCHAR(255),
	contact_email VARCHAR(255),
	contact_phone VARCHAR(20)
);

CREATE TABLE procurement_orders(
	order_id int AUTO_INCREMENT PRIMARY KEY,
	vendor_id int,
	quantity int,
	order_status varchar(50) DEFAULT 'PENDING',
	order_date DATE ,
	FOREIGN KEY(vendor_id)REFERENCES vendors(vendor_id)
	
);

CREATE TABLE bulk_imports(
	import_id int AUTO_INCREMENT PRIMARY KEY,
	file_name VARCHAR(255),
	uploaded_by int,
	uploaded_date DATE ,
	FOREIGN KEY(uploaded_by)REFERENCES users(user_id)
	
);

CREATE TABLE maintenance(
	maintenance_id int AUTO_INCREMENT PRIMARY KEY,
	asset_id int,
	description TEXT,
	scheduled_date DATETIME,
	status varchar(50) DEFAULT 'SCHEDULED',
	FOREIGN KEY(asset_id) REFERENCES assets(asset_id)
	
);

CREATE TABLE notifications(
	notification_id  int AUTO_INCREMENT PRIMARY KEY,
	user_id int,
	request_id VARCHAR(255),
	description TEXT,

	status varchar(50) DEFAULT 'SENT',
	date_created DATE,


	FOREIGN KEY(user_id) REFERENCES users(user_id)
);


INSERT INTO departments (department_id, department_name, budget, rules, policy) VALUES
(10000, 'HR', 500000.00, 'Follow all compliance and employee engagement rules.', 'Ensure fair hiring practices.'),
(10001, 'IT', 1200000.00, 'Maintain cybersecurity protocols and software updates.', 'Data privacy and security are mandatory.'),
(10002, 'Sales', 750000.00, 'Meet quarterly targets and follow ethical sales practices.', 'All sales data must be reported weekly.'),
(10003, 'Marketing', 600000.00, 'Adhere to branding and campaign approval guidelines.', 'Digital campaigns must be pre-approved.'),
(10004, 'Finance', 900000.00, 'Ensure accurate bookkeeping and timely reporting.', 'All expenses must be justified with documentation.'),
(10005, 'R&D', 1100000.00, 'Protect intellectual property and conduct ethical research.', 'All research must align with company goals.');


INSERT INTO users (user_id, name, email, password, role, created_at, department_id, no_of_assigned_tickets) VALUES
(11000, 'Alice Johnson', 'alice.johnson@company.com', '$2a$10$OzJgqM0zlqj2SfUjR6ePZ.K0thqnOcKKlNp.DDtZrxzpR3jZM7wlm', 'MANAGER', '2025-05-19', 10000, 0),
(11001, 'Brian Smith', 'brian.smith@company.com', '$2a$10$10OqhytF7yqNEStY4WIw6OR6u2gcUBgdxnaunvs7k8JKwjGHxQheq', 'MANAGER', '2025-05-19', 10001, 0),
(11002, 'Clara Williams', 'clara.williams@company.com', '$2a$10$JIRJrKdFpD6z9WfUmw2PGu61JmYQkjpKR9H0kTIpter3P3wPRfV9O', 'MANAGER', '2025-05-19', 10002, 0),
(11003, 'David Lee', 'david.lee@company.com', '$2a$10$j0DhEFCe6oOy4MFtYJCtLuja1iC1WmzctRCEfeIjZa5IAShNzfLnG', 'MANAGER', '2025-05-19', 10003, 0),
(11004, 'Evan Davis', 'evan.davis@company.com', '$2a$10$KZO/Qn92hfW/UeKeW0ezpu15GgB3a5kcZ9VdkOlH6ajSUtkDcyG9C', 'MANAGER', '2025-05-19', 10004, 0),
(11005, 'Frank Miller', 'frank.miller@company.com', '$2a$10$bud9L2q3rsZxc954NJTYTOd99Qd5gFDcneYkjMuGwyHEE.dmfwCoe', 'MANAGER', '2025-05-19', 10005, 0),
(11006, 'Grace Kim', 'grace.kim@company.com', '$2a$10$JUR3fIvMdKwWK5rid1GDsOZ8YFc/3pqUkD.X6DD3ulaHq2yc0t8ey', 'ADMIN', '2025-05-19', 10001, 7),
(11007, 'Henry Patel', 'henry.patel@company.com', '$2a$10$JutMWJwWP/j1bEE3kGAXVOmcVfagXBLipjKOtxRnlELZNW4F3AaU6', 'ADMIN', '2025-05-19', 10001, 7),
(11008, 'Irene Brown', 'irene.brown@company.com', '$2a$10$2UqR4F3rppoWck14xTLeFuDp.0./JXJB6WcseB67d/1mZWPlbsFky', 'ADMIN', '2025-05-19', 10001, 7),
(11009, 'Jack Wilson', 'jack.wilson@company.com', '$2a$10$2G/xmOuJAkKDJw85V30aLOl5euQwQHIUGY0Etm0Fr1UAlIoY3TknG', 'ADMIN', '2025-05-19', 10001, 7),
(11010, 'Kathy Moore', 'kathy.moore@company.com', '$2a$10$DaWl2.Cb.CyNuasMBsrDXu7HcAbypb.31TNeSsZQ52zBYRQFNrHkK', 'ADMIN', '2025-05-19', 10001, 7),
(11011, 'Liam White', 'liam.white@company.com', '$2a$10$CGDvU2N4fPo80FsFYC7zFek0pAW3v7IgAzn2DQj6Lfb27sb4Ua54O', 'EMPLOYEE', '2025-05-19', 10000, 0),
(11012, 'Miami Scott', 'miami.scott@company.com', '$2a$10$9bQhaDLtM2y1i4PKYLzQNeDHXolk/wG4WtCsv1PleyVOkDnVPCMce', 'EMPLOYEE', '2025-05-19', 10000, 0),
(11013, 'Noah Hall', 'noah.hall@company.com', '$2a$10$TcqU114lmnPiDoUyTXxpCus4CRtQdgeUgWTDIw0Mrk.5zXJS4ERKC', 'EMPLOYEE', '2025-05-19', 10000, 0),
(11014, 'Olivia Adams', 'olivia.adams@company.com', '$2a$10$YV10xChUphqswfWIdS.CEeVGAhiG8i.kjgpjXj7kibXubqA9953L.', 'EMPLOYEE', '2025-05-19', 10000, 0),
(11015, 'Paul Young', 'paul.young@company.com', '$2a$10$KfDYhHKh4/72obr88AH4puJJ055AtMh8V6wa4dly/r6wOzdJUbaB2', 'EMPLOYEE', '2025-05-19', 10000, 0),
(11016, 'Quinn Baker', 'quinn.baker@company.com', '$2a$10$T55vVmgDzqcDsyqHoSVbweilxgFw5w.LqxisLHH9dWjkYGiRTkLVq', 'EMPLOYEE', '2025-05-19', 10001, 0),
(11017, 'Ruby Reed', 'ruby.reed@company.com', '$2a$10$cePLeEnZdB4xE1Pv.H61pufp0lx5yjTprL/E/v2Ao5k5vXltAV822', 'EMPLOYEE', '2025-05-19', 10001, 0),
(11018, 'Sami Ross', 'sami.ross@company.com', '$2a$10$16jcC9ZJPmVmbFlwASM6auUd.nWTDlwloafttOQulh7XDszl7M8fC', 'EMPLOYEE', '2025-05-19', 10001, 0),
(11019, 'Tina Cox', 'tina.cox@company.com', '$2a$10$ZAfCxeM2AjQTloKdX88UMerGQaJKVzaXOkUL6r025IKZpFSlYCosi', 'EMPLOYEE', '2025-05-19', 10001, 0),
(11020, 'Umar Turner', 'umar.turner@company.com', '$2a$10$DBAXrJkMlzGVOx2CdfzdAO./D/DeSqhbXHr3cd4YO.ioFLSQozcZu', 'EMPLOYEE', '2025-05-19', 10001, 0),
(11021, 'Vera Barnes', 'vera.barnes@company.com', '$2a$10$cDXbPDrBkAf874vaOBZthuTa2ULTQQlt.hCIfBU3U5Xjn3majpW6S', 'EMPLOYEE', '2025-05-19', 10002, 0),
(11022, 'Will Graham', 'will.graham@company.com', '$2a$10$K6gyR..9XhO9AF56d1rkeOXUXiOMLtN3cVLgqB.4IibT4yRMqu8He', 'EMPLOYEE', '2025-05-19', 10002, 0),
(11023, 'Xena Morgan', 'xena.morgan@company.com', '$2a$10$FM6UiALVc/fyZEhsqoiuEuEHPCoQHxcD5kBQkTyFzIRlxswCBOtcW', 'EMPLOYEE', '2025-05-19', 10002, 0),
(11024, 'Yusuf Hayes', 'yusuf.hayes@company.com', '$2a$10$ccqnZp.rcRpcLo.ZjqOHj.avllIO0dU6PELuVkNo9K6ejs9ESyV2i', 'EMPLOYEE', '2025-05-19', 10002, 0),
(11025, 'Zara Long', 'zara.long@company.com', '$2a$10$etd0vX0TX13HXJYQLLNSGeKXR2kMP1TWo9gy7dN3A2s0Xn5eKmiiq', 'EMPLOYEE', '2025-05-19', 10002, 0),
(11026, 'Aaron Knight', 'aaron.knight@company.com', '$2a$10$VqrrYWl9WjiQTqcYaun5XODYmkTshc8bq1/E2dm6Wb2K0CN48Jgnm', 'EMPLOYEE', '2025-05-19', 10003, 0),
(11027, 'Bella Ford', 'bella.ford@company.com', '$2a$10$BtwicYYcYX0brISZ4wrqmO0qe2SQjb4EOnuDCt2uQQxiRWyYiWSna', 'EMPLOYEE', '2025-05-19', 10003, 0),
(11028, 'Caleb Stone', 'caleb.stone@company.com', '$2a$10$0A4CYmqc/rovM6tACnzeOO9AwaB2XIE3FbMIoUIvVgKa8DwKcnh4i', 'EMPLOYEE', '2025-05-19', 10003, 0),
(11029, 'Dana Walsh', 'dana.walsh@company.com', '$2a$10$oXXdI2ebxiH4a/Wp9ANEoeD4cVc/90IedrvhxBCL5LeBZKIiF5Xn.', 'EMPLOYEE', '2025-05-19', 10003, 0),
(11030, 'Ethan Shaw', 'ethan.shaw@company.com', '$2a$10$2zjsAAwEePVd7/zHcewlt..6QEzfK0I/MI23/Lxi5EV7TdNiFHREG', 'EMPLOYEE', '2025-05-19', 10003, 0),
(11031, 'Fiona Hunt', 'fiona.hunt@company.com', '$2a$10$4B/IZ3kTcykUTztCnFZ1uu89Jy.ujWCu0uBgLBRydnHSnv2ZyOR6e', 'EMPLOYEE', '2025-05-19', 10004, 0),
(11032, 'George Bell', 'george.bell@company.com', '$2a$10$lSTShr3QWiKaTkPMvCARcuJRTwV.a2FpzyMFL5fO2XKFB4yHM.no6', 'EMPLOYEE', '2025-05-19', 10004, 0),
(11033, 'Hannah Watts', 'hannah.watts@company.com', '$2a$10$3w5.R52AlEvuDmHzxRVJBu.lSNdD/XBXDDQ4xJQV3hED47yTe7rVq', 'EMPLOYEE', '2025-05-19', 10004, 0),
(11034, 'Isaac Boyd', 'isaac.boyd@company.com', '$2a$10$2oq4i3yGPKv9PVZz8wU.QuxEpIPjTDVaT0O1qHtJgWuQ1RY1qI3g.', 'EMPLOYEE', '2025-05-19', 10004, 0),
(11035, 'Jenna Neal', 'jenna.neal@company.com', '$2a$10$lzI9/QCftJsGjPnYctwx.u/.Q/pq1Bwl3SfsRs7xpKE.zg68JETrG', 'EMPLOYEE', '2025-05-19', 10004, 0),
(11036, 'Kyle Sims', 'kyle.sims@company.com', '$2a$10$fTeAdsdKp08XcRZWTAspNOt1M0PoKsC0pH23uQsOHGBRnYT5XYwoa', 'EMPLOYEE', '2025-05-19', 10005, 0),
(11037, 'Lily Watts', 'lily.watts@company.com', '$2a$10$.8/jqRRiWh9NFrT/G0rCOu6BuqgaTfE.Cftd/SgGhsIh1hvQP8v4W', 'EMPLOYEE', '2025-05-19', 10005, 0),
(11038, 'Miles Dean', 'miles.dean@company.com', '$2a$10$EGnip9s/wG4hgbUUw/8ryum7KbeFL5Vyyt4yI9/d3d8z7EmPIYC/C', 'EMPLOYEE', '2025-05-19', 10005, 0),
(11039, 'Nina Fox', 'nina.fox@company.com', '$2a$10$WEaxT90RnZo9brTf7UBA/.sCZn43cD.J1Mapn./gpCCJJ5rpDBsmK', 'EMPLOYEE', '2025-05-19', 10005, 0),
(11040, 'Owen Lane', 'owen.lane@company.com', '$2a$10$PqO4hcOV3.lBN7GlvFs/.eD1c00p/JYtWxBk4zizleIfO.Of/cSp2', 'EMPLOYEE', '2025-05-19', 10005, 0);



INSERT INTO assets (
    asset_id, serial_number, brand, model, purchase_date, status, maintenance_count
) VALUES
(12000, 'SN0012000', 'Dell', 'XPS13', '2022-05-15', 'ALLOCATED', 3),
(12001, 'SN0012001', 'HP', 'EliteBook', '2021-11-23', 'ALLOCATED', 2),
(12002, 'SN0012002', 'Apple', 'MacBook Pro', '2023-02-18', 'ALLOCATED', 4),
(12003, 'SN0012003', 'Lenovo', 'ThinkPad X1', '2022-08-10', 'ALLOCATED', 1),
(12004, 'SN0012004', 'Acer', 'Aspire 5', '2021-06-30', 'ALLOCATED', 5),
(12005, 'SN0012005', 'Dell', 'Latitude 7420', '2022-01-25', 'ALLOCATED', 2),
(12006, 'SN0012006', 'HP', 'Pavilion', '2020-12-12', 'ALLOCATED', 3),
(12007, 'SN0012007', 'Apple', 'MacBook Air', '2023-03-08', 'ALLOCATED', 4),
(12008, 'SN0012008', 'Lenovo', 'IdeaPad 3', '2022-09-20', 'ALLOCATED', 1),
(12009, 'SN0012009', 'Acer', 'Swift 3', '2021-07-14', 'ALLOCATED', 3),
(12010, 'SN0012010', 'Dell', 'XPS15', '2021-04-01', 'ALLOCATED', 2),
(12011, 'SN0012011', 'HP', 'ProBook 450', '2020-10-29', 'ALLOCATED', 5),
(12012, 'SN0012012', 'Apple', 'MacBook Pro M1', '2023-01-17', 'ALLOCATED', 4),
(12013, 'SN0012013', 'Lenovo', 'Yoga Slim 7', '2022-07-05', 'ALLOCATED', 1),
(12014, 'SN0012014', 'Acer', 'Nitro 5', '2021-05-11', 'ALLOCATED', 2),
(12015, 'SN0012015', 'Dell', 'Inspiron 15', '2021-09-18', 'ALLOCATED', 3),
(12016, 'SN0012016', 'HP', 'Spectre x360', '2020-11-01', 'ALLOCATED', 4),
(12017, 'SN0012017', 'Apple', 'MacBook Air M2', '2023-04-10', 'ALLOCATED', 1),
(12018, 'SN0012018', 'Lenovo', 'ThinkBook 14', '2022-03-21', 'ALLOCATED', 3),
(12019, 'SN0012019', 'Acer', 'TravelMate', '2021-08-27', 'ALLOCATED', 2),
(12020, 'SN0012020', 'Dell', 'XPS13 Plus', '2022-06-16', 'ALLOCATED', 5),
(12021, 'SN0012021', 'HP', 'Envy x360', '2021-03-30', 'ALLOCATED', 1),
(12022, 'SN0012022', 'Apple', 'MacBook Pro M2', '2023-05-12', 'ALLOCATED', 4),
(12023, 'SN0012023', 'Lenovo', 'Flex 5', '2022-10-03', 'ALLOCATED', 2),
(12024, 'SN0012024', 'Acer', 'Spin 5', '2021-02-22', 'ALLOCATED', 3),
(12025, 'SN0012025', 'Dell', 'Vostro 5510', '2021-12-15', 'ALLOCATED', 1),
(12026, 'SN0012026', 'HP', 'Omen 15', '2020-09-09', 'ALLOCATED', 2),
(12027, 'SN0012027', 'Apple', 'MacBook Air M1', '2023-06-01', 'ALLOCATED', 3),
(12028, 'SN0012028', 'Lenovo', 'ThinkPad E14', '2022-04-25', 'ALLOCATED', 4),
(12029, 'SN0012029', 'Acer', 'Predator Helios', '2021-01-08', 'ALLOCATED', 2),
(12030, 'SN0012030', 'Dell', 'Precision 5550', '2021-07-29', 'ALLOCATED', 5),
(12031, 'SN0012031', 'HP', 'ZBook Studio', '2020-08-18', 'ALLOCATED', 3),
(12032, 'SN0012032', 'Apple', 'MacBook Pro 16"', '2023-07-20', 'ALLOCATED', 1),
(12033, 'SN0012033', 'Lenovo', 'ThinkPad P15', '2022-11-11', 'ALLOCATED', 4),
(12034, 'SN0012034', 'Acer', 'Extensa 15', '2021-04-16', 'ALLOCATED', 2),
(12035, 'SN0012035', 'Dell', 'G15', '2022-02-09', 'ALLOCATED', 5),
(12036, 'SN0012036', 'HP', 'Elite Dragonfly', '2020-06-04', 'ALLOCATED', 3),
(12037, 'SN0012037', 'Apple', 'MacBook Air 13"', '2023-08-15', 'ALLOCATED', 4),
(12038, 'SN0012038', 'Lenovo', 'ThinkPad T14', '2022-12-12', 'ALLOCATED', 2),
(12039, 'SN0012039', 'Acer', 'Chromebook 14', '2021-03-05', 'ALLOCATED', 3),

-- AVAILABLE
(12040, 'SN0012040', 'Dell', 'Latitude 5400', '2021-06-10', 'AVAILABLE', 0),
(12041, 'SN0012041', 'HP', 'ProBook 440', '2022-02-12', 'AVAILABLE', 0),
(12042, 'SN0012042', 'Apple', 'MacBook Pro 13"', '2023-03-14', 'AVAILABLE', 0),
(12043, 'SN0012043', 'Lenovo', 'Yoga 7i', '2021-08-19', 'AVAILABLE', 0),
(12044, 'SN0012044', 'Acer', 'Aspire 7', '2020-12-01', 'AVAILABLE', 0),
(12045, 'SN0012045', 'Dell', 'Inspiron 14', '2022-09-05', 'AVAILABLE', 0),
(12046, 'SN0012046', 'HP', 'Notebook 15', '2023-01-10', 'AVAILABLE', 0),
(12047, 'SN0012047', 'Apple', 'MacBook Air Retina', '2021-11-27', 'AVAILABLE', 0),
(12048, 'SN0012048', 'Lenovo', 'Legion 5', '2022-06-30', 'AVAILABLE', 0),
(12049, 'SN0012049', 'Acer', 'Swift X', '2021-07-17', 'AVAILABLE', 0),

-- UNDER_MAINTENANCE
(12050, 'SN0012050', 'Dell', 'XPS17', '2021-05-20', 'UNDER_MAINTENANCE', 4),
(12051, 'SN0012051', 'HP', 'EliteBook x360', '2022-03-15', 'UNDER_MAINTENANCE', 5),
(12052, 'SN0012052', 'Apple', 'MacBook Pro 14"', '2023-04-02', 'UNDER_MAINTENANCE', 3),
(12053, 'SN0012053', 'Lenovo', 'ThinkPad L14', '2021-12-12', 'UNDER_MAINTENANCE', 2),
(12054, 'SN0012054', 'Acer', 'TravelMate P2', '2020-10-08', 'UNDER_MAINTENANCE', 3),

-- DISPOSED
(12055, 'SN0012055', 'Dell', 'Inspiron 13', '2019-09-25', 'DISPOSED', 2),
(12056, 'SN0012056', 'HP', 'Stream 14', '2018-07-16', 'DISPOSED', 1),
(12057, 'SN0012057', 'Apple', 'MacBook 12"', '2019-02-05', 'DISPOSED', 2),
(12058, 'SN0012058', 'Lenovo', 'ThinkPad T480', '2017-11-11', 'DISPOSED', 3),
(12059, 'SN0012059', 'Acer', 'Aspire One', '2016-04-22', 'DISPOSED', 4),

-- Recent ALLOCATED
(12060, 'SN0012060', 'Dell', 'Latitude 5430', '2025-05-01', 'ALLOCATED', 1),
(12061, 'SN0012061', 'HP', 'EliteBook 845', '2025-05-01', 'ALLOCATED', 3),
(12062, 'SN0012062', 'Apple', 'MacBook Pro 14"', '2025-05-01', 'ALLOCATED', 2),
(12063, 'SN0012063', 'Lenovo', 'ThinkPad Z13', '2025-05-01', 'ALLOCATED', 4),
(12064, 'SN0012064', 'Acer', 'Aspire Vero', '2025-05-01', 'ALLOCATED', 5),
(12065, 'SN0012065', 'Dell', 'XPS 13 Plus', '2025-05-01', 'ALLOCATED', 3),
(12066, 'SN0012066', 'HP', 'ProBook 455 G9', '2025-05-01', 'ALLOCATED', 1),
(12067, 'SN0012067', 'Apple', 'MacBook Air M3', '2025-05-01', 'ALLOCATED', 2),
(12068, 'SN0012068', 'Lenovo', 'ThinkBook 16p', '2025-05-01', 'ALLOCATED', 4),
(12069, 'SN0012069', 'Acer', 'Swift Go 14', '2025-05-01', 'ALLOCATED', 3),
(12070, 'SN0012070', 'Dell', 'Inspiron 16', '2025-05-01', 'ALLOCATED', 1);






INSERT INTO department_asset_tracking (
    id, department_id, user_id, asset_id,
    policy_compliance, allocation_date
) VALUES
(13000, 10005, 11001, 12000, 'NO', '2023-01-30'),
(13001, 10003, 11030, 12001, 'NO', '2023-11-09'),
(13002, 10004, 11030, 12002, 'YES', '2023-04-04'),
(13003, 10001, 11007, 12003, 'YES', '2023-07-30'),
(13004, 10004, 11004, 12004, 'YES', '2023-12-04'),
(13005, 10003, 11009, 12005, 'YES', '2023-12-03'),
(13006, 10005, 11006, 12006, 'YES', '2024-04-10'),
(13007, 10001, 11005, 12007, 'NO', '2023-11-23'),
(13008, 10004, 11026, 12008, 'NO', '2023-04-02'),
(13009, 10005, 11020, 12009, 'NO', '2023-10-19'),
(13010, 10003, 11024, 12010, 'NO', '2024-04-20'),
(13011, 10001, 11023, 12011, 'YES', '2024-01-25'),
(13012, 10003, 11029, 12012, 'YES', '2023-10-14'),
(13013, 10001, 11028, 12013, 'YES', '2024-02-07'),
(13014, 10000, 11002, 12014, 'YES', '2023-04-04'),
(13015, 10002, 11011, 12015, 'NO', '2023-12-28'),
(13016, 10003, 11019, 12016, 'YES', '2024-05-01'),
(13017, 10002, 11022, 12017, 'YES', '2023-06-11'),
(13018, 10001, 11025, 12018, 'YES', '2023-09-17'),
(13019, 10004, 11017, 12019, 'NO', '2023-08-14'),
(13020, 10001, 11013, 12020, 'YES', '2023-06-05'),
(13021, 10005, 11010, 12021, 'YES', '2024-01-30'),
(13022, 10004, 11018, 12022, 'NO', '2024-02-20'),
(13023, 10003, 11016, 12023, 'YES', '2023-08-01'),
(13024, 10000, 11012, 12024, 'NO', '2024-03-04'),
(13025, 10002, 11008, 12025, 'YES', '2023-12-10'),
(13026, 10002, 11003, 12026, 'YES', '2023-05-15'),
(13027, 10000, 11021, 12027, 'NO', '2024-04-09'),
(13028, 10003, 11027, 12028, 'YES', '2023-09-29'),
(13029, 10005, 11014, 12029, 'YES', '2023-10-22'),
(13030, 10000, 11015, 12030, 'YES', '2024-02-13'),
(13031, 10001, 11001, 12031, 'YES', '2023-07-21'),
(13032, 10002, 11007, 12032, 'NO', '2024-03-31'),
(13033, 10004, 11005, 12033, 'YES', '2023-10-16'),
(13034, 10002, 11006, 12034, 'YES', '2023-05-18'),
(13035, 10005, 11004, 12035, 'YES', '2023-11-20'),
(13036, 10001, 11009, 12036, 'NO', '2024-05-10'),
(13037, 10001, 11001, 12037, 'YES', '2024-01-14'),
(13038, 10000, 11010, 12038, 'YES', '2023-12-30'),
(13039, 10003, 11011, 12039, 'YES', '2023-09-03'),
(13040, 10000, 11000, 12060, 'YES', '2025-05-20'),
(13041, 10001, 11001, 12061, 'YES', '2025-05-20'),
(13042, 10002, 11002, 12062, 'YES', '2025-05-20'),
(13043, 10003, 11003, 12063, 'YES', '2025-05-20'),
(13044, 10004, 11004, 12064, 'YES', '2025-05-20'),
(13045, 10005, 11005, 12065, 'YES', '2025-05-20'),
(13046, 10001, 11006, 12066, 'YES', '2025-05-20'),
(13047, 10001, 11007, 12067, 'YES', '2025-05-20'),
(13048, 10001, 11008, 12068, 'YES', '2025-05-20'),
(13049, 10001, 11009, 12069, 'YES', '2025-05-20'),
(13050, 10001, 11010, 12070, 'YES', '2025-05-20');







INSERT INTO asset_request (request_id, user_id, status, request_date, decision_date) VALUES
(14000, 11001, 'PENDING', '2023-04-12', NULL),
(14001, 11002, 'ALLOCATED', '2023-05-03', '2023-05-06'),
(14002, 11003, 'REJECTED', '2023-06-15', '2023-06-20'),
(14003, 11004, 'ALLOCATED', '2023-03-25', '2023-03-30'),
(14004, 11005, 'PENDING', '2023-08-02', NULL),
(14005, 11006, 'REJECTED', '2023-01-17', '2023-01-25'),
(14006, 11007, 'ALLOCATED', '2023-02-10', '2023-02-12'),
(14007, 11008, 'PENDING', '2023-07-20', NULL),
(14008, 11009, 'ALLOCATED', '2023-03-01', '2023-03-03'),
(14009, 11010, 'REJECTED', '2023-04-05', '2023-04-12'),
(14010, 11011, 'PENDING', '2023-06-22', NULL),
(14011, 11012, 'ALLOCATED', '2023-05-15', '2023-05-17'),
(14012, 11013, 'REJECTED', '2023-08-19', '2023-08-22'),
(14013, 11014, 'PENDING', '2023-07-10', NULL),
(14014, 11015, 'ALLOCATED', '2023-01-08', '2023-01-09'),
(14015, 11016, 'REJECTED', '2023-09-01', '2023-09-03'),
(14016, 11017, 'PENDING', '2023-04-25', NULL),
(14017, 11018, 'ALLOCATED', '2023-03-11', '2023-03-13'),
(14018, 11019, 'REJECTED', '2023-06-01', '2023-06-04'),
(14019, 11020, 'PENDING', '2023-05-20', NULL),
(14020, 11021, 'ALLOCATED', '2023-08-10', '2023-08-12'),
(14021, 11022, 'PENDING', '2023-07-01', NULL),
(14022, 11023, 'REJECTED', '2023-03-05', '2023-03-07'),
(14023, 11024, 'ALLOCATED', '2023-09-18', '2023-09-19'),
(14024, 11025, 'PENDING', '2023-10-01', NULL),
(14025, 11026, 'REJECTED', '2023-04-14', '2023-04-18'),
(14026, 11027, 'PENDING', '2023-05-25', NULL),
(14027, 11028, 'ALLOCATED', '2023-02-18', '2023-02-20'),
(14028, 11029, 'REJECTED', '2023-06-06', '2023-06-09'),
(14029, 11030, 'PENDING', '2023-07-14', NULL),
(14030, 11001, 'ALLOCATED', '2023-04-07', '2023-04-08'),
(14031, 11002, 'REJECTED', '2023-01-20', '2023-01-21'),
(14032, 11003, 'PENDING', '2023-08-30', NULL),
(14033, 11004, 'ALLOCATED', '2023-06-10', '2023-06-12'),
(14034, 11005, 'REJECTED', '2023-07-27', '2023-07-30'),
(14035, 11006, 'PENDING', '2023-03-22', NULL),
(14036, 11007, 'ALLOCATED', '2023-05-29', '2023-06-01'),
(14037, 11008, 'REJECTED', '2023-02-11', '2023-02-15'),
(14038, 11009, 'PENDING', '2023-09-21', NULL),
(14039, 11010, 'ALLOCATED', '2023-01-31', '2023-02-02');







INSERT INTO support_tickets (ticket_id, user_id, assigned_to, asset_id, status, priority, created_at)
VALUES
(15000, 11000, 11006, 12000, 'OPEN', 'HIGH', '2023-01-15'),
(15001, 11001, 11007, 12001, 'IN_PROGRESS', 'MEDIUM', '2023-01-20'),
(15002, 11002, 11008, 12002, 'RESOLVED', 'LOW', '2023-02-10'),
(15003, 11003, 11009, 12003, 'CLOSED', 'HIGH', '2023-02-15'),
(15004, 11004, 11010, 12004, 'OPEN', 'MEDIUM', '2023-03-01'),
(15005, 11005, 11006, 12005, 'IN_PROGRESS', 'LOW', '2023-03-05'),
(15006, 11011, 11007, 12006, 'RESOLVED', 'MEDIUM', '2023-03-10'),
(15007, 11012, 11008, 12007, 'CLOSED', 'LOW', '2023-03-18'),
(15008, 11013, 11009, 12008, 'OPEN', 'HIGH', '2023-04-01'),
(15009, 11014, 11010, 12009, 'IN_PROGRESS', 'MEDIUM', '2023-04-05'),
(15010, 11015, 11006, 12010, 'RESOLVED', 'LOW', '2023-04-10'),
(15011, 11016, 11007, 12011, 'CLOSED', 'HIGH', '2023-04-15'),
(15012, 11017, 11008, 12012, 'OPEN', 'MEDIUM', '2023-04-20'),
(15013, 11018, 11009, 12013, 'IN_PROGRESS', 'LOW', '2023-05-01'),
(15014, 11019, 11010, 12014, 'RESOLVED', 'MEDIUM', '2023-05-05'),
(15015, 11020, 11006, 12015, 'CLOSED', 'LOW', '2023-05-10'),
(15016, 11021, 11007, 12016, 'OPEN', 'HIGH', '2023-05-15'),
(15017, 11022, 11008, 12017, 'IN_PROGRESS', 'MEDIUM', '2023-05-20'),
(15018, 11023, 11009, 12018, 'RESOLVED', 'LOW', '2023-05-25'),
(15019, 11024, 11010, 12019, 'CLOSED', 'HIGH', '2023-06-01'),
(15020, 11025, 11006, 12020, 'OPEN', 'LOW', '2023-06-05'),
(15021, 11026, 11007, 12021, 'IN_PROGRESS', 'MEDIUM', '2023-06-10'),
(15022, 11027, 11008, 12022, 'RESOLVED', 'LOW', '2023-06-15'),
(15023, 11028, 11009, 12023, 'CLOSED', 'HIGH', '2023-06-20'),
(15024, 11029, 11010, 12024, 'OPEN', 'MEDIUM', '2023-07-01'),
(15025, 11030, 11006, 12025, 'IN_PROGRESS', 'LOW', '2023-07-05'),
(15026, 11031, 11007, 12026, 'RESOLVED', 'MEDIUM', '2023-07-10'),
(15027, 11032, 11008, 12027, 'CLOSED', 'LOW', '2023-07-15'),
(15028, 11033, 11009, 12028, 'OPEN', 'HIGH', '2023-07-20'),
(15029, 11034, 11010, 12029, 'IN_PROGRESS', 'MEDIUM', '2023-07-25'),
(15030, 11035, 11006, 12030, 'RESOLVED', 'LOW', '2023-08-01'),
(15031, 11036, 11007, 12031, 'CLOSED', 'HIGH', '2023-08-05'),
(15032, 11037, 11008, 12032, 'OPEN', 'LOW', '2023-08-10'),
(15033, 11038, 11009, 12033, 'IN_PROGRESS', 'MEDIUM', '2023-08-15'),
(15034, 11039, 11010, 12034, 'RESOLVED', 'LOW', '2023-08-20');







INSERT INTO returns (return_id, user_id, asset_id, reason, status, return_request_date, decision_date) VALUES
(16000, 11001, 12000, 'End of project usage', 'PENDING', '2023-01-12', NULL),
(16001, 11002, 12001, 'Device malfunctioning', 'APPROVED', '2023-01-20', '2023-01-22'),
(16002, 11003, 12002, 'No longer needed', 'REJECTED', '2023-02-01', '2023-02-04'),
(16003, 11004, 12003, 'Performance issues', 'APPROVED', '2023-02-10', '2023-02-13'),
(16004, 11005, 12004, 'Assigned new device', 'PENDING', '2023-03-01', NULL),
(16005, 11006, 12005, 'Cracked screen', 'REJECTED', '2023-03-12', '2023-03-14'),
(16006, 11007, 12006, 'Upgrade required', 'APPROVED', '2023-03-25', '2023-03-27'),
(16007, 11008, 12007, 'Power issue', 'PENDING', '2023-04-05', NULL),
(16008, 11009, 12008, 'Not used frequently', 'APPROVED', '2023-04-12', '2023-04-14'),
(16009, 11010, 12009, 'Too slow', 'REJECTED', '2023-04-20', '2023-04-23'),
(16010, 11011, 12010, 'Screen flickering', 'PENDING', '2023-05-01', NULL),
(16011, 11012, 12011, 'Damaged keyboard', 'APPROVED', '2023-05-05', '2023-05-08'),
(16012, 11013, 12012, 'Overheating issue', 'REJECTED', '2023-05-15', '2023-05-18'),
(16013, 11014, 12013, 'Work completed', 'PENDING', '2023-05-22', NULL),
(16014, 11015, 12014, 'Software issues', 'APPROVED', '2023-06-01', '2023-06-03'),
(16015, 11016, 12015, 'Device obsolete', 'REJECTED', '2023-06-10', '2023-06-13'),
(16016, 11017, 12016, 'Department switch', 'PENDING', '2023-06-20', NULL),
(16017, 11018, 12017, 'Assigned better asset', 'APPROVED', '2023-06-25', '2023-06-28'),
(16018, 11019, 12018, 'Return requested by admin', 'REJECTED', '2023-07-01', '2023-07-04'),
(16019, 11020, 12019, 'Broken USB port', 'PENDING', '2023-07-10', NULL),
(16020, 11021, 12020, 'Overused', 'APPROVED', '2023-07-15', '2023-07-17'),
(16021, 11022, 12021, 'Assigned for a short term', 'PENDING', '2023-07-20', NULL),
(16022, 11023, 12022, 'Issue with webcam', 'REJECTED', '2023-07-25', '2023-07-28'),
(16023, 11024, 12023, 'Returning for disposal', 'APPROVED', '2023-08-01', '2023-08-04'),
(16024, 11025, 12024, 'No longer required', 'PENDING', '2023-08-10', NULL),
(16025, 11026, 12025, 'Given to other team', 'REJECTED', '2023-08-15', '2023-08-18'),
(16026, 11027, 12026, 'Frequent crashes', 'PENDING', '2023-08-22', NULL),
(16027, 11028, 12027, 'Admin approval', 'APPROVED', '2023-08-30', '2023-09-01'),
(16028, 11029, 12028, 'No compatible software', 'REJECTED', '2023-09-05', '2023-09-08'),
(16029, 11030, 12029, 'Broken hinges', 'PENDING', '2023-09-12', NULL),
(16030, 11001, 12030, 'Too bulky', 'APPROVED', '2023-09-15', '2023-09-17'),
(16031, 11002, 12031, 'Request from team lead', 'REJECTED', '2023-09-20', '2023-09-23'),
(16032, 11003, 12032, 'End of support', 'PENDING', '2023-09-25', NULL),
(16033, 11004, 12033, 'Wi-Fi card issue', 'APPROVED', '2023-10-01', '2023-10-03'),
(16034, 11005, 12034, 'Loose keyboard', 'REJECTED', '2023-10-05', '2023-10-08'),
(16035, 11006, 12035, 'Shutdowns randomly', 'PENDING', '2023-10-10', NULL),
(16036, 11007, 12036, 'Broken screen corner', 'APPROVED', '2023-10-15', '2023-10-18'),
(16037, 11008, 12037, 'Battery issue', 'REJECTED', '2023-10-20', '2023-10-23'),
(16038, 11009, 12038, 'Heavy usage', 'PENDING', '2023-10-25', NULL),
(16039, 11010, 12039, 'Recalled by IT', 'APPROVED', '2023-10-30', '2023-11-01');









INSERT INTO disposals (disposal_id, asset_id, disposal_reason, disposal_date) VALUES

(17001, 12055, 'Damaged beyond repair due to water damage', '2023-01-25'),
(17002, 12056, 'Outdated specifications, not suitable for new software', '2023-02-10'),
(17003, 12057, 'Motherboard failure, not cost-effective to repair', '2023-02-18'),
(17004, 12058, 'Cracked screen and keyboard malfunction', '2023-02-25'),
(17005, 12059, 'Retired after 5 years of use', '2023-03-05'),
(17007, 12007, 'Asset returned in poor condition', '2023-03-22'),
(17031, 12031, 'Battery leakage detected', '2023-08-20'),
(17032, 12032, 'Failed security compliance audit', '2023-08-25'),
(17033, 12033, 'Outdated BIOS and hardware incompatibility', '2023-09-01'),
(17034, 12034, 'Broken LCD and missing keys', '2023-09-08'),
(17035, 12035, 'Replaced with energy-efficient model', '2023-09-15'),
(17036, 12036, 'No longer functioning after power surge', '2023-09-20'),
(17037, 12037, 'Asset scrapped after IT directive', '2023-09-25'),
(17038, 12038, 'Reasigned but returned in unusable state', '2023-10-01'),
(17039, 12039, 'Major component failure', '2023-10-05');







INSERT INTO vendors (vendor_id, vendor_name, contact_person, contact_email, contact_phone) VALUES
(18000, 'Tech Supplies Co.', 'John Carter', 'john.carter@techsupplies.com', '+1-202-555-0101'),
(18001, 'SmartTech Distributors', 'Ava Nguyen', 'ava.nguyen@smarttech.com', '+1-202-555-0102'),
(18002, 'Digital Gear Hub', 'Liam Patel', 'liam.patel@digitalgearhub.com', '+1-202-555-0103'),
(18003, 'NextGen Hardware', 'Emma Walker', 'emma.walker@nextgenhardware.com', '+1-202-555-0104'),
(18004, 'Elite IT Partners', 'Noah Lee', 'noah.lee@eliteit.com', '+1-202-555-0105'),
(18005, 'Prime Solutions Inc.', 'Olivia Brown', 'olivia.brown@primesolutions.com', '+1-202-555-0106'),
(18006, 'Global Devices Ltd.', 'William Kim', 'william.kim@globaldevices.com', '+1-202-555-0107'),
(18007, 'Fusion Electronics', 'Sophia Adams', 'sophia.adams@fusionelectronics.com', '+1-202-555-0108'),
(18008, 'Nova IT Supplies', 'James Chen', 'james.chen@novait.com', '+1-202-555-0109'),
(18009, 'Vertex Solutions', 'Mia Clark', 'mia.clark@vertexsolutions.com', '+1-202-555-0110');







INSERT INTO procurement_orders (order_id, vendor_id, quantity, order_status, order_date) VALUES
(19000, 18000, 25, 'PENDING', '2024-01-10'),
(19001, 18001, 30, 'RECEIVED', '2024-01-12'),
(19002, 18002, 15, 'CANCELLED', '2024-01-15'),
(19003, 18003, 40, 'RECEIVED', '2024-01-18'),
(19004, 18004, 20, 'PENDING', '2024-01-20'),
(19005, 18005, 35, 'RECEIVED', '2024-01-25'),
(19006, 18006, 10, 'PENDING', '2024-02-01'),
(19007, 18007, 45, 'RECEIVED', '2024-02-05'),
(19008, 18008, 12, 'CANCELLED', '2024-02-07'),
(19009, 18009, 22, 'RECEIVED', '2024-02-10'),
(19010, 18000, 18, 'PENDING', '2024-02-12'),
(19011, 18001, 28, 'RECEIVED', '2024-02-15'),
(19012, 18002, 33, 'PENDING', '2024-02-18'),
(19013, 18003, 14, 'CANCELLED', '2024-02-20'),
(19014, 18004, 38, 'RECEIVED', '2024-02-25'),
(19015, 18005, 26, 'RECEIVED', '2024-03-01'),
(19016, 18006, 20, 'PENDING', '2024-03-03'),
(19017, 18007, 50, 'RECEIVED', '2024-03-05'),
(19018, 18008, 13, 'CANCELLED', '2024-03-07'),
(19019, 18009, 17, 'RECEIVED', '2024-03-09'),
(19020, 18000, 24, 'RECEIVED', '2024-03-12'),
(19021, 18001, 32, 'PENDING', '2024-03-14'),
(19022, 18002, 11, 'CANCELLED', '2024-03-16'),
(19023, 18003, 41, 'RECEIVED', '2024-03-18'),
(19024, 18004, 27, 'RECEIVED', '2024-03-20'),
(19025, 18005, 19, 'PENDING', '2024-03-22'),
(19026, 18006, 30, 'RECEIVED', '2024-03-25'),
(19027, 18007, 36, 'PENDING', '2024-03-27'),
(19028, 18008, 16, 'CANCELLED', '2024-03-29'),
(19029, 18009, 23, 'RECEIVED', '2024-04-01'),
(19030, 18000, 21, 'PENDING', '2024-04-03'),
(19031, 18001, 29, 'RECEIVED', '2024-04-05'),
(19032, 18002, 34, 'CANCELLED', '2024-04-07'),
(19033, 18003, 42, 'RECEIVED', '2024-04-09'),
(19034, 18004, 37, 'RECEIVED', '2024-04-11'),
(19035, 18005, 31, 'PENDING', '2024-04-13'),
(19036, 18006, 20, 'RECEIVED', '2024-04-15'),
(19037, 18007, 39, 'CANCELLED', '2024-04-17'),
(19038, 18008, 43, 'RECEIVED', '2024-04-20'),
(19039, 18009, 44, 'RECEIVED', '2024-04-22');







INSERT INTO bulk_imports (import_id, file_name, uploaded_by, uploaded_date) VALUES
(20000, 'assets_jan2024.json', 11012, '2024-01-10');




INSERT INTO maintenance (maintenance_id, asset_id, description, scheduled_date, status) VALUES
(21000, 12001, 'Routine hardware inspection', '2024-01-10 00:00:00', 'AUTOMATED'),
(21001, 12002, 'Battery replacement required', '2024-01-20 00:00:00', 'AUTOMATED'),
(21002, 12003, 'OS upgrade and cleanup', '2024-01-25 00:00:00', 'AUTOMATED'),
(21003, 12004, 'Screen calibration', '2024-02-05 00:00:00', 'AUTOMATED'),
(21004, 12005, 'Internal cleaning', '2024-02-10 00:00:00', 'AUTOMATED'),
(21005, 12006, 'Keyboard malfunctioning', '2024-02-20 00:00:00', 'AUTOMATED'),
(21006, 12007, 'RAM upgrade scheduled', '2024-03-01 00:00:00', 'AUTOMATED'),
(21007, 12008, 'Hard disk performance check', '2024-03-05 00:00:00', 'AUTOMATED'),
(21008, 12009, 'Bluetooth not working', '2024-03-15 00:00:00', 'AUTOMATED'),
(21009, 12010, 'General performance tuning', '2024-03-20 00:00:00', 'AUTOMATED'),
(21010, 12011, 'Preventive maintenance', '2024-04-01 00:00:00', 'AUTOMATED'),
(21011, 12012, 'Screen replacement scheduled', '2024-04-10 00:00:00', 'AUTOMATED'),
(21012, 12013, 'Firmware update', '2024-04-20 00:00:00', 'AUTOMATED'),
(21013, 12014, 'System overheating', '2024-04-25 00:00:00', 'AUTOMATED'),
(21014, 12015, 'Battery diagnostics', '2024-05-01 00:00:00', 'AUTOMATED'),
(21015, 12016, 'Asset health check', '2024-05-05 00:00:00', 'AUTOMATED'),
(21016, 12017, 'Annual maintenance', '2024-05-10 00:00:00', 'AUTOMATED'),
(21017, 12018, 'SSD optimization', '2024-05-15 00:00:00', 'AUTOMATED'),
(21018, 12019, 'CPU fan noisy', '2024-05-20 00:00:00', 'AUTOMATED'),
(21019, 12020, 'Scheduled software patching', '2024-06-01 00:00:00', 'AUTOMATED'),
(21020, 12021, 'Security vulnerability check', '2024-06-10 00:00:00', 'AUTOMATED'),
(21021, 12022, 'Check display flicker', '2024-06-15 00:00:00', 'AUTOMATED'),
(21022, 12023, 'Evaluate memory usage', '2024-06-20 00:00:00', 'AUTOMATED'),
(21023, 12024, 'Touchpad not responsive', '2024-07-01 00:00:00', 'AUTOMATED'),
(21024, 12025, 'Monthly checkup', '2024-07-05 00:00:00', 'AUTOMATED'),
(21025, 12026, 'Performance monitoring', '2024-07-10 00:00:00', 'AUTOMATED'),
(21026, 12027, 'BIOS update required', '2024-07-15 00:00:00', 'AUTOMATED'),
(21027, 12028, 'Noise in fan', '2024-07-20 00:00:00', 'AUTOMATED'),
(21028, 12029, 'Mousepad loose', '2024-07-25 00:00:00', 'AUTOMATED'),
(21029, 12030, 'Camera not working', '2024-08-01 00:00:00', 'AUTOMATED'),
(21030, 12031, 'Replace thermal paste', '2024-08-10 00:00:00', 'AUTOMATED'),
(21031, 12032, 'Display brightness low', '2024-08-15 00:00:00', 'AUTOMATED'),
(21032, 12033, 'USB ports malfunctioning', '2024-08-20 00:00:00', 'AUTOMATED'),
(21033, 12034, 'Performance audit', '2024-08-25 00:00:00', 'AUTOMATED'),
(21034, 12035, 'General asset check', '2024-09-01 00:00:00', 'AUTOMATED'),
(21035, 12036, 'Fan noise observed', '2024-09-05 00:00:00', 'AUTOMATED'),
(21036, 12037, 'Hardware compatibility check', '2024-09-10 00:00:00', 'AUTOMATED'),
(21037, 12038, 'Memory leak diagnosis', '2024-09-15 00:00:00', 'AUTOMATED'),
(21038, 12039, 'Software cleanup', '2024-09-20 00:00:00', 'AUTOMATED'),
(21039, 12040, 'Data backup and system health', '2024-09-25 00:00:00', 'AUTOMATED');







INSERT INTO notifications (notification_id, user_id, request_id, description, status, date_created) VALUES
(22000, 11032, '16021', 'Your asset request has been received.', 'READ', '2024-01-15'),
(22002, 11018, '14029', 'Asset request rejected. Contact admin.', 'SENT', '2024-01-17'),
(22003, 11012, '14008', 'Maintenance scheduled for your allocated asset.', 'READ', '2024-01-18'),
(22004, 11031, '16034', 'Reminder: Return the allocated asset.', 'SENT', '2024-01-19'),
(22005, 11015, '16014', 'Return request approved.', 'READ', '2024-01-20'),
(22007, 11025, '16015', 'You have unread support ticket updates.', 'SENT', '2024-01-22'),
(22008, 11034, '16031', 'Asset status updated to UNDER_MAINTENANCE.', 'READ', '2024-01-23'),
(22009, 11019, '14022', 'Your return request has been rejected.', 'READ', '2024-01-24'),
(22012, 11018, '14027', 'Policy compliance check scheduled.', 'READ', '2024-01-27'),
(22013, 11009, '14012', 'Asset successfully returned.', 'SENT', '2024-01-28'),
(22014, 11012, '16033', 'Reminder: Maintenance scheduled tomorrow.', 'READ', '2024-01-29'),
(22015, 11002, '14003', 'New hardware has been allocated to you.', 'SENT', '2024-01-30'),
(22020, 11017, '16028', 'Return request is pending.', 'READ', '2024-02-04'),
(22022, 11003, '14009', 'Asset request under review.', 'SENT', '2024-02-06'),
(22025, 11029, '16024', 'Asset will be collected tomorrow.', 'SENT', '2024-02-09'),
(22026, 11035, '14016', 'Asset replacement request initiated.', 'SENT', '2024-02-10'),
(22027, 11038, '14030', 'Asset policy violation reported.', 'READ', '2024-02-11'),
(22029, 11005, '14031', 'Annual asset audit scheduled.', 'READ', '2024-02-13'),
(22030, 11021, '16008', 'Reminder: Data backup before maintenance.', 'SENT', '2024-02-14'),
(22032, 11030, '16012', 'Return request decision pending.', 'READ', '2024-02-16'),
(22033, 11013, '14006', 'Hardware request logged.', 'SENT', '2024-02-17'),
(22034, 11001, '14001', 'Notification: Unused asset detected.', 'READ', '2024-02-18'),
(22035, 11006, '14033', 'Security patch maintenance notice.', 'SENT', '2024-02-19'),
(22037, 11010, '14023', 'Reminder: Submit feedback.', 'SENT', '2024-02-21'),
(22038, 11027, '14014', 'New training asset assigned.', 'READ', '2024-02-22'),
(22039, 11037, '16007', 'Asset request delay expected.', 'SENT', '2024-02-23');





DELETE FROM department_asset_tracking
WHERE id IN (13003, 13005, 13006, 13021, 13025, 13032, 13034, 13036, 13038);

UPDATE assets SET status = 'AVAILABLE' WHERE asset_id IN (12003, 12005, 12006, 12021, 12025, 12032, 12034, 12036, 12038);

delete from support_tickets where asset_id in (select asset_id from assets where status="AVAILABLE");

update assets set status="DISPOSED" where asset_id in (select asset_id from support_tickets where status="CLOSED");

delete from department_asset_tracking where asset_id in (select asset_id from assets where status="DISPOSED");

update maintenance SET scheduled_date=NOW();

delete from maintenance where asset_id in (select asset_id from assets where status="DISPOSED");

delete from maintenance where asset_id in (select asset_id from assets where status="AVAILABLE");

delete from asset_request where user_id between 11000 and 11010;


--give me a correct input data: 4 department: each dept has 1 manager and each manager will have 1 asset, and there is no any request or anythiing related to that in any other table, 3 admins and same rules applied for admin as well as manager, except IT dept where all admins will be there add 2 employees to other 3 depts, and allocate 1 asset to each employee, let there be 25 assets, there will be no return data, disposal data, all allocation data will be mentioned in dept allocation table, there will be   no data in asset request, support tickrts also empty, return , disposals will be empty, vendor and procurements add 10 data each, bulk import empty, for each allocated asset add maintenance with date as NOW() and description as "TechDesk- Patch deployment sheduled, Please do not shoutdown your system, importemnt security updates are being installed on your computer, window will disppear after the installation, You may mininize the window", and for each user will have one notification with message " Welcome to TechDesk- IT Asset Management System",  