/*******************

  Create the schema

********************/

CREATE TABLE IF NOT EXISTS customers (
	ssn CHAR(11) PRIMARY KEY,
	first_name VARCHAR(32),
	last_name VARCHAR(32),
	country VARCHAR(16)
);

CREATE TABLE IF NOT EXISTS credit_cards (
	ssn CHAR(11) REFERENCES customers(ssn), 
	number VARCHAR(20) PRIMARY KEY, 
	type VARCHAR(32)
);

CREATE TABLE IF NOT EXISTS merchants (
	code CHAR(10) PRIMARY KEY,
	name VARCHAR(64),
	country VARCHAR(16)
);


CREATE TABLE IF NOT EXISTS transactions(
    identifier INTEGER PRIMARY KEY,  
    number VARCHAR(20) REFERENCES credit_cards(number),  
    code CHAR(10) REFERENCES merchants(code),  
    datetime TIMESTAMP,  
    amount NUMERIC
);
