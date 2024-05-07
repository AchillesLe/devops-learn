CREATE TABLE employees (
    id int AUTO_INCREMENT PRIMARY KEY,
    lastName varchar(255),
    firstName varchar(255),
    city varchar(255)
);

INSERT INTO employees (lastName, firstName, city) VALUES ('anna', 'sweet', 'paris')