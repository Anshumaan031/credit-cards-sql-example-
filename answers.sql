INSERT INTO customers (ssn, first_name, last_name, country)
VALUES ('254-21-0283', 'Lewis', 'Hamilton', 'Singapore');

INSERT INTO credit_cards (ssn, number, type)
VALUES ('254-21-0283', '3580818351657323', 'jcb');

INSERT INTO merchants (code, name, country)
VALUES ('50-5893740', 'Carloz Sainz', 'Singapore');

INSERT INTO transactions (identifier, number, code, datetime, amount)
VALUES (30199, '3580818351657323', '50-5893740', '2017-12-06 18:56:04.452884', 300.00);


--give an sql code for an update to the table customers that violates a constraint on table credit_cards

UPDATE customers
SET ssn = '628-92-2000'
WHERE ssn = '608-71-2352';

--find the amount of transaction made with am merchant in thailand by a customer with last name "Antonazzi". Print customers ssn, the mechant's name, and the year abd amount of transaction

SELECT c.ssn, m.name, t.datetime, t.amount
FROM credict cards cc, merchants m, transactions t, customers c
WHERE cc.county = 'thailand'
AND c.name LIKE '%Antonazzi'

SELECT c.ssn, m.name, EXTRACT(YEAR FROM t.datetime) AS transaction_year, t.amount
FROM customers c JOIN credit_cards cc ON c.ssn = cc.ssn
JOIN transactions t ON cc.number = t.number
JOIN merchants m ON t.code = m.code
WHERE c.country = 'thailand'
AND c.last_name = '%Antonazzi';

--for each singaporean customer, find first name and last name and total expenditure. Implicitly ignore customers who did not use credit cars or do not have a credit card

SELECT c.first_name,last_name, SUM(t.amount)
FROM customers c LEFT JOIN credit_cards cc ON c.ssn = cc.ssn
LEFT JOIN transactions t ON cc.number = t.number
WHERE C.country = 'Singapore'
GROUP BY c.first_name, c.last_name;

--To find the first name, last name of different customers in singapore who own both a JCB and visa credit card. Make sure the same customer is not printed twice.

SELECT DISTINCT c.first_name, c.last_name
FROM customers c
INNER JOIN credit_cards cc_jcb
    ON c.ssn = cc_jcb.ssn AND cc_jcb.type = 'JCB'
INNER JOIN credit_cards cc_visa
    ON c.ssn = cc_visa.ssn AND cc_visa.type = 'Visa'
WHERE c.country = 'Singapore';

SELECT DISTINCT c.first_name, c.last_name
FROM customers c
WHERE c.country = 'Singapore'
AND EXISTS (
    SELECT 1
    FROM credit_cards cc1
    WHERE cc1.ssn = c.ssn
    AND cc1.type = 'JCB'
)
AND EXISTS (
    SELECT 1
    FROM credit_cards cc2
    WHERE cc2.ssn = c.ssn
    AND cc2.type = 'Visa'
);