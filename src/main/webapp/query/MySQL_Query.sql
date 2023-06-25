CREATE DATABASE chan;

CREATE TABLE User (
	userID				VARCHAR(20),
	userPassword		VARCHAR(20),
	userName			VARCHAR(20),
	userContact			VARCHAR(11),
    adminAvailable		BOOLEAN,
	PRIMARY KEY (userID)
);

CREATE TABLE Auth (
	authCode			VARCHAR(10),
    adminAvailable		BOOLEAN,
    PRIMARY KEY (authCode)
);

INSERT INTO Auth VALUES ("student01", FALSE), ("admin01", TRUE);

CREATE TABLE Product (
	productID			INT,
	productName			VARCHAR(20),
	productCount		INT,
	productDeposit		INT,
	rentAvailable		BOOLEAN,
	PRIMARY KEY (productID)
);

CREATE TABLE Rent (
	rentID				INT,
	userID				VARCHAR(20),
    productID			INT,
	productName			VARCHAR(20),
    rentDate			DATE,
    rentExpr			DATE,
	productDeposit		INT,
	PRIMARY KEY (rentID)
);

CREATE TABLE Returned (
	returnID			INT,
	userID				VARCHAR(20),
    productID			INT,
	productName			VARCHAR(20),
    rentDate			DATE,
    returnDate			DATE,
	PRIMARY KEY (returnID)
);