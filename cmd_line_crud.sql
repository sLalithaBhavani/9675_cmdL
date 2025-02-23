CREATE TABLE user_details (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_num VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    address TEXT
);

CREATE TABLE bank_accounts (
    bank_account_id INT AUTO_INCREMENT PRIMARY KEY,
    account_number VARCHAR(20) UNIQUE NOT NULL,
    ifsc_code VARCHAR(15) NOT NULL,
    bank_name VARCHAR(100) NOT NULL,
    bank_account_branch_location VARCHAR(100),
    user_id INT,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (user_id) REFERENCES user_details(user_id)
);

CREATE TABLE user_account_details (
    user_account_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    account_open_date DATE NOT NULL,
    current_wallet_balance DECIMAL(15,2) DEFAULT 0.00,
    linked_bank_accounts_count INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES user_details(user_id)
);

CREATE TABLE source_types (
    source_id INT AUTO_INCREMENT PRIMARY KEY,
    source_type_code VARCHAR(10) UNIQUE NOT NULL,
    source_type_desc VARCHAR(50) NOT NULL
);

CREATE TABLE txn_details (
    txn_id INT AUTO_INCREMENT PRIMARY KEY,
    txn_date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    source_id INT,
    target_id INT,
    source_type_id INT,
    destination_type_id INT,
    FOREIGN KEY (source_id) REFERENCES source_types(source_id),
    FOREIGN KEY (target_id) REFERENCES source_types(source_id),
    FOREIGN KEY (source_type_id) REFERENCES source_types(source_id),
    FOREIGN KEY (destination_type_id) REFERENCES source_types(source_id)
);

-- Inserting users
INSERT INTO user_details (user_name, password, first_name, last_name, phone_num, email, address) 
VALUES 
('rajesh_sharma', 'pass123', 'Rajesh', 'Sharma', '9876543210', 'rajesh.sharma@example.com', 'MG Road, Bengaluru'),
('sneha_verma', 'mypassword', 'Sneha', 'Verma', '8765432109', 'sneha.verma@example.com', 'Connaught Place, Delhi'),
('arun_nair', 'securepass', 'Arun', 'Nair', '7654321098', 'arun.nair@example.com', 'Marine Drive, Mumbai');

-- Inserting bank accounts
INSERT INTO bank_accounts (account_number, ifsc_code, bank_name, bank_account_branch_location, user_id, is_active) 
VALUES 
('111122223333', 'HDFC0001234', 'HDFC Bank', 'Indiranagar, Bengaluru', 1, TRUE),
('222233334444', 'SBI0005678', 'State Bank of India', 'Chandni Chowk, Delhi', 2, TRUE),
('333344445555', 'ICIC0007890', 'ICICI Bank', 'Bandra, Mumbai', 3, TRUE);

-- Inserting user account details
INSERT INTO user_account_details (user_id, account_open_date, current_wallet_balance, linked_bank_accounts_count) 
VALUES 
(1, '2024-01-01', 10000.00, 1),
(2, '2024-01-05', 7500.00, 1),
(3, '2024-02-01', 5000.00, 1);

-- Inserting source types
INSERT INTO source_types (source_type_code, source_type_desc) 
VALUES 
('BA', 'Bank Account'),
('WA', 'Wallet Account'),
('TPT', 'Third Party Transaction');

-- Insert transactions
INSERT INTO txn_details (txn_date_time, source_id, target_id, source_type_id, destination_type_id) 
VALUES 
('2024-02-01 10:30:00', 1, 2, 1, 2),
('2024-02-02 11:00:00', 2, 3, 2, 1),
('2024-02-03 15:45:00', 3, 1, 1, 3);

-- Retrieve all users and their bank accounts
SELECT u.user_id, u.user_name, u.first_name, u.last_name, 
       b.bank_name, b.account_number, b.ifsc_code, b.bank_account_branch_location 
FROM user_details u 
JOIN bank_accounts b ON u.user_id = b.user_id;


-- Finding users with the highest wallet balance
SELECT user_id, current_wallet_balance 
FROM user_account_details 
ORDER BY current_wallet_balance DESC 
LIMIT 1;

-- Update wallet balance after a transaction
UPDATE user_account_details 
SET current_wallet_balance = current_wallet_balance - 500 
WHERE user_id = 1;

-- Deletion
DELETE FROM bank_accounts WHERE user_id = 29;
DELETE FROM user_account_details WHERE user_id = 29;
DELETE FROM user_details WHERE user_id = 29;
