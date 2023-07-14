CREATE DATABASE Albayan;
GO

USE Albayan;
GO

CREATE TABLE Customer (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    phone_number VARCHAR(15) NOT NULL
);

CREATE TABLE Staff (
    staff_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    phone_number VARCHAR(15) NOT NULL
);


CREATE TABLE Branch (
    branch_id INT IDENTITY(1,1) PRIMARY KEY,
    branch_location VARCHAR(100) NOT NULL,
    manager_id INT NOT NULL,
    FOREIGN KEY (manager_id) REFERENCES Staff(staff_id)
);

ALTER TABLE Staff
ADD branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id);


	CREATE TABLE Stock (
    ISBN BIGINT,
    branch_id INT,
    author_name VARCHAR(100) NOT NULL,
    book_name VARCHAR(100) NOT NULL,
    quantity INT CHECK (quantity >= 0),
    PRIMARY KEY (ISBN, branch_id),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);


CREATE TABLE Feedback (
    id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    ISBN BIGINT,
    rate INT CHECK (rate >= 1 AND rate <= 5),
    feedback_text VARCHAR(MAX),
    FOREIGN KEY (customer_id) REFERENCES Customer(id)
);


CREATE TABLE BookRent (
    rental_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    ISBN BIGINT,
    branch_id INT,
    rent_date DATE,
    is_late VARCHAR(5) DEFAULT 'false' CHECK (is_late IN ('true', 'false')),
    late_fines FLOAT DEFAULT 0.0 CHECK (late_fines >= 0),
    rent_price FLOAT CHECK (rent_price > 0),
    FOREIGN KEY (customer_id) REFERENCES Customer(id),
    FOREIGN KEY (ISBN, branch_id) REFERENCES Stock(ISBN, branch_id)
);
