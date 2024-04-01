

CREATE TABLE Role (
    role_id INT PRIMARY KEY,
    role_name VARCHAR(50),
    role_desc VARCHAR(255)
);

INSERT INTO Role (role_id, role_name, role_desc) VALUES
(1, 'Admin', 'Administrator role'),
(2, 'User', 'Regular user role'),
(3, 'Manager', 'Managerial role'),
(4, 'Support', 'Support staff role'),
(5, 'Guest', 'Limited access role');

SELECT * FROM Role;


CREATE TABLE Login (
    login_id INT PRIMARY KEY,
    login_role_id INT,
    login_username VARCHAR(50),
    login_password VARCHAR(50),
    FOREIGN KEY (login_role_id) REFERENCES Role(role_id)
);

INSERT INTO Login (login_id, login_role_id, login_username, login_password) VALUES
(1, 1, 'admin_user', 'admin_password'),
(2, 2, 'regular_user', 'user_password'),
(3, 3, 'manager_user', 'manager_password'),
(4, 4, 'support_user', 'support_password'),
(5, 5, 'guest_user', 'guest_password');

SELECT * FROM Login;



CREATE TABLE User (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(50),
    user_mobile VARCHAR(15),
    user_email VARCHAR(100),
    user_address VARCHAR(255),
    login_id INT UNIQUE,
    FOREIGN KEY (login_id) REFERENCES Login(login_id)
);
INSERT INTO User (user_id, user_name, user_mobile, user_email, user_address, login_id) VALUES
(1, 'Admin User', '1234567890', 'admin@example.com', 'Admin Address', 1),
(2, 'Regular User', '0987654321', 'user@example.com', 'User Address', 2),
(3, 'Manager User', '9876543210', 'manager@example.com', 'Manager Address', 3),
(4, 'Support User', '1231231234', 'support@example.com', 'Support Address', 4),
(5, 'Guest User', '4564564567', 'guest@example.com', 'Guest Address', 5);
SELECT * FROM User;



CREATE TABLE Permission (
    per_id INT PRIMARY KEY,
    per_role_id INT,
    per_module VARCHAR(50),
    per_name VARCHAR(50),
    FOREIGN KEY (per_role_id) REFERENCES Role(role_id)
);
INSERT INTO Permission (per_id, per_role_id, per_module, per_name) VALUES
(1, 1, 'Admin Module', 'Admin Access'),
(2, 2, 'User Module', 'User Access'),
(3, 3, 'Manager Module', 'Manager Access'),
(4, 4, 'Support Module', 'Support Access'),
(5, 5, 'Guest Module', 'Guest Access');
SELECT * FROM Permission;

CREATE TABLE Customer (
    cus_name VARCHAR(100) PRIMARY KEY,
    cus_mobile VARCHAR(15),
    cus_add VARCHAR(255),
    cus_email VARCHAR(100),
    cus_pass VARCHAR(50)
);
INSERT INTO Customer (cus_name, cus_mobile, cus_add, cus_email, cus_pass) VALUES
('John Doe', '9876543210', '123 Main St, City', 'john.doe@example.com', 'john_password'),
('Jane Smith', '1234567890', '456 Elm St, Town', 'jane.smith@example.com', 'jane_password'),
('Michael Johnson', '5555555555', '789 Oak St, Village', 'michael.johnson@example.com', 'michael_password'),
('Emily Brown', '3333333333', '101 Pine St, Hamlet', 'emily.brown@example.com', 'emily_password'),
('David Wilson', '7777777777', '246 Maple St, Countryside', 'david.wilson@example.com', 'david_password');

SELECT * FROM Customer;


CREATE TABLE Registration (
    reg_id INT PRIMARY KEY,
    reg_type VARCHAR(50),
    reg_desc VARCHAR(255),
    cus_name VARCHAR(100),
    FOREIGN KEY (cus_name) REFERENCES Customer(cus_name)
);
INSERT INTO Registration (reg_id, reg_type, reg_desc, cus_name) VALUES
(1, 'Type A', 'Description A', 'John Doe'),
(2, 'Type B', 'Description B', 'Jane Smith'),
(3, 'Type C', 'Description C', 'Michael Johnson'),
(4, 'Type D', 'Description D', 'Emily Brown'),
(5, 'Type E', 'Description E', 'David Wilson');
SELECT * FROM Registration;


CREATE TABLE Insurance (
    ins_num INT PRIMARY KEY,
    ins_id INT,
    ins_type VARCHAR(50),
    ins_desc VARCHAR(255),
    ins_amt DECIMAL(10, 2),
    cus_name VARCHAR(100),
    FOREIGN KEY (cus_name) REFERENCES Customer(cus_name)
);
INSERT INTO Insurance (ins_num, ins_id, ins_type, ins_desc, ins_amt, cus_name) VALUES
(101, 1, 'Life Insurance', 'Life coverage', 50000.00, 'John Doe'),
(102, 2, 'Health Insurance', 'Health coverage', 10000.00, 'Jane Smith'),
(103, 3, 'Auto Insurance', 'Car coverage', 20000.00, 'Michael Johnson'),
(104, 4, 'Home Insurance', 'Property coverage', 75000.00, 'Emily Brown'),
(105, 5, 'Travel Insurance', 'Trip coverage', 3000.00, 'David Wilson');

SELECT * FROM Insurance;




SELECT COUNT(*) AS total_users FROM User;

SELECT SUM(ins_amt) AS total_insurance_amount FROM Insurance WHERE cus_name = 'John Doe';

SELECT AVG(ins_amt) AS average_insurance_amount FROM Insurance;

SELECT MAX(ins_amt) AS max_insurance_amount FROM Insurance;

SELECT MAX(ins_amt) AS max_insurance_amount FROM Insurance;

ALTER TABLE Customer ADD COLUMN cus_status VARCHAR(10);

DELETE FROM Registration WHERE reg_id = 1;

UPDATE Role SET role_name = 'Superuser' WHERE role_id = 1;

SELECT * FROM Customer WHERE cus_name LIKE 'J%';

SELECT * FROM User ORDER BY user_name;

SELECT reg_type, COUNT(*) AS num_registrations FROM Registration GROUP BY reg_type;

SELECT reg_type, COUNT(*) AS num_registrations FROM Registration GROUP BY reg_type HAVING COUNT(*) > 1;

SELECT c.cus_name, i.ins_type, i.ins_amt FROM Customer c INNER JOIN Insurance i ON c.cus_name = i.cus_name;

SELECT cus_name AS name FROM Customer
UNION
SELECT user_name AS name FROM User;


SELECT * FROM User WHERE EXISTS (SELECT 1 FROM Login WHERE User.login_id = Login.login_id);

SELECT * FROM User WHERE user_id IN (1, 3, 5);

SELECT user_id, (SELECT COUNT(*) FROM Login WHERE User.user_id = Login.login_id) AS num_logins FROM User;

SELECT user_name, 
       CASE 
          WHEN User.login_id IN (SELECT login_id FROM Login WHERE login_role_id = 1) THEN 'Admin'
           ELSE 'Regular' 
       END AS user_role
FROM User;


SELECT * FROM User LIMIT 5;

SELECT NULLIF(role_name, 'Admin') AS role_name FROM Role;



