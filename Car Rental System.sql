create database car_rental_system;
use car_rental_system;
drop database car_rental_system;

CREATE TABLE Vehicle ( vehicleID INT PRIMARY KEY, make VARCHAR(50) , model VARCHAR(50), year INT, dailyRate DECIMAL(10, 2),status INT,
						passengerCapacity INT,engineCapacity INT );

CREATE TABLE Customer (customerID INT PRIMARY KEY ,firstName VARCHAR(50) ,lastName VARCHAR(50),email VARCHAR(50),phoneNumber CHAR(12));

CREATE TABLE Lease (leaseID INT PRIMARY KEY,vehicleID INT,customerID INT,startDate DATE,endDate DATE, leaseType VARCHAR(50),
                    FOREIGN KEY (vehicleID) REFERENCES Vehicle(vehicleID) on delete cascade,
					FOREIGN KEY (customerID) REFERENCES Customer(customerID) on delete cascade);

CREATE TABLE Payment (paymentID INT PRIMARY KEY,leaseID INT,paymentDate DATE,amount DECIMAL(10, 2),
                       FOREIGN KEY (leaseID) REFERENCES Lease(leaseID) on delete cascade);


INSERT INTO Vehicle (vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
VALUES(1, 'Toyota', 'Camry', 2022, 50.00, 1, 4, 1450),
    (2, 'Honda', 'Civic', 2023, 45.00, 1, 7, 1500),
    (3, 'Ford', 'Focus', 2022, 48.00, 0, 4, 1400),
    (4, 'Nissan', 'Altima', 2023, 52.00, 1, 7, 1200),
    (5, 'Chevrolet', 'Malibu', 2022, 47.00, 1, 4, 1800),
    (6, 'Hyundai', 'Sonata', 2023, 49.00, 0, 7, 1400),
    (7, 'BMW', '3 Series', 2023, 60.00, 1, 7, 2499),
    (8, 'Mercedes', 'C-Class', 2022, 58.00, 1, 8, 2599),
    (9, 'Audi', 'A4', 2022, 55.00, 0, 4, 2500),
    (10, 'Lexus', 'ES', 2023, 54.00, 1, 4, 2500);
    
SELECT * FROM vehicle;

INSERT INTO Customer (customerID,firstName, lastName, email, phoneNumber)
VALUES(1,'John', 'Doe', 'johndoe@example.com', '555-555-5555'),
    (2,'Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
    (3,'Robert', 'Johnson', 'robert@example.com', '555-789-1234'),
    (4,'Sarah', 'Brown', 'sarah@example.com', '555-456-7890'),
    (5,'David', 'Lee', 'david@example.com', '555-987-6543'),
    (6,'Laura', 'Hall', 'laura@example.com', '555-234-5678'),
    (7,'Michael', 'Davis', 'michael@example.com', '555-876-5432'),
    (8,'Emma', 'Wilson', 'emma@example.com', '555-432-1098'),
    (9,'William', 'Taylor', 'william@example.com', '555-321-6547'),
    (10,'Olivia', 'Adams', 'olivia@example.com', '555-765-4321');

SELECT * FROM customer;

select c.firstname,l.leaseid,l.startdate,l.enddate,l.leasetype 
from customer c inner join lease l on l.customerid=c.customerid where c.firstname='david';

INSERT INTO Lease (leaseID, vehicleID, customerID, startDate, endDate, Leasetype)
VALUES(1, 1, 1, '2023-01-01', '2023-01-05', 'Daily'),
    (2, 2, 2, '2023-02-15', '2023-02-28', 'Monthly'),
    (3, 3, 3, '2023-03-10', '2023-03-15', 'Daily'),
    (4, 4, 4, '2023-04-20', '2023-04-30', 'Monthly'),
    (5, 5, 5, '2023-05-05', '2023-05-10', 'Daily'),
    (6, 4, 3, '2023-06-15', '2023-06-30', 'Monthly'),
    (7, 7, 7, '2023-07-01', '2023-07-10', 'Daily'),
    (8, 8, 8, '2023-08-12', '2023-08-15', 'Monthly'),
    (9, 3, 3, '2023-09-07', '2023-09-10', 'Daily'),
    (10, 10, 10, '2023-10-10', '2023-10-31', 'Monthly');

SELECT * FROM Lease;

INSERT INTO Payment (paymentID, leaseID, paymentDate, amount)
VALUES(1, 1, '2023-01-03', 200.00),
    (2, 2, '2023-02-20', 1000.00),
    (3, 3, '2023-03-12', 75.00),
    (4, 4, '2023-04-25', 900.00),
    (5, 5, '2023-05-07', 60.00),
    (6, 6, '2023-06-18', 1200.00),
    (7, 7, '2023-07-03', 40.00),
    (8, 8, '2023-08-14', 1100.00),
    (9, 9, '2023-09-09', 80.00),
    (10, 10, '2023-10-25', 1500.00);
    
Select * from payment;
select * from vehicle;


-- 1. Update the daily rate for a Mercedes car to 68.
update vehicle set dailyRate=68 where make='Mercedes';
select * from vehicle;

-- 2. Delete a specific customer and all associated leases and payments.
delete from customer where customerID=2;
select * from customer;
select * from lease;

-- 3. Rename the "paymentDate" column in the Payment table to "transactionDate".
alter table payment rename column  paymentDate to transactionDate;
select * from payment;

-- 4. Find a specific customer by email.
select * from customer where email='david@example.com';

-- 5. Get active leases for a specific customer.
SELECT * FROM Lease WHERE customerID = 3 AND curdate()<enddate; 

-- 6. Find all payments made by a customer with a specific phone number.
SELECT p.paymentID, p.leaseID, p.transactionDate, p.amount  
FROM Payment p  
INNER JOIN Lease l ON p.leaseID = l.leaseID  
INNER JOIN Customer c ON l.customerID = c.customerID  
WHERE c.phoneNumber = '555-789-1234'; 

-- 7. Calculate the average daily rate of all available cars.
select avg(dailyrate) as average from vehicle;

-- 8. Find the car with the highest daily rate.
SELECT vehicleid,make,model,dailyrate FROM Vehicle WHERE dailyRate = (SELECT MAX(dailyRate) FROM Vehicle);

-- 9. Retrieve all cars leased by a specific customer.
SELECT v.vehicleID, v.make, v.model, v.year, v.dailyRate, v.status, v.passengerCapacity, v.engineCapacity  
FROM Vehicle v  
INNER JOIN Lease l ON v.vehicleID = l.vehicleID  
INNER JOIN Customer c ON l.customerID = c.customerID  
WHERE c.customerID = 3;

-- 10. Find the details of the most recent lease.
SELECT * FROM Lease WHERE startDate = (SELECT MAX(startDate) FROM Lease);

-- 11.List all payments made in the year 2023.
SELECT * FROM Payment WHERE YEAR(Date) = 2023;

-- 12. Retrieve customers who have not made any payments.
SELECT c.customerID, c.firstName, c.lastName, c.email, c.phoneNumber  
FROM Customer c  
LEFT JOIN Lease l ON c.customerID = l.customerID  
LEFT JOIN Payment p ON l.leaseID = p.leaseID  
WHERE p.paymentID IS NULL;

-- 13. Retrieve Car Details and Their Total Payments.
SELECT v.vehicleID, v.make, v.model, v.year, v.dailyRate, SUM(p.amount) AS totalPayments  
FROM Vehicle v  
INNER JOIN Lease l 
ON v.vehicleID = l.vehicleID  
INNER JOIN Payment p ON l.leaseID = p.leaseID GROUP BY v.vehicleID, v.make, v.model, v.year, v.dailyRate;  

-- 14.Calculate Total Payments for Each Customer.
SELECT c.customerID, c.firstName, c.lastName, c.email, c.phoneNumber,  sum(p.amount) AS totalPayments  
FROM Customer c  
INNER JOIN Lease l ON c.customerID = l.customerID  
INNER JOIN Payment p ON l.leaseID = p.leaseID  
GROUP BY c.customerID, c.firstName, c.lastName, c.email, c.phoneNumber;  

-- 15. List Car Details for Each Lease.
SELECT L.leaseID, V.make, V.model, V.year  
FROM Lease L  
inner JOIN Vehicle V ON L.vehicleID = V.vehicleID;

-- 16. Retrieve Details of Active Leases with Customer Information and car details.
select  l.leaseid,l.vehicleid,l.customerid,c.firstname,c.lastname,c.email,c.phonenumber,v.make,v.model,v.Year
from lease l 
inner join customer c on l.customerid=c.customerid 
inner join vehicle v on l.vehicleid=v.vehicleid;

-- 17.Find the Customer Who Has Spent the Most on Lease  
SELECT c.customerID, c.firstName, c.lastName, c.email, c.phoneNumber, p.amount  
FROM Customer c  
INNER JOIN Lease l ON c.customerID = l.customerID  
INNER JOIN Payment p ON l.leaseID = p.leaseID  
WHERE p.amount = (SELECT MAX(amount) FROM Payment);


-- 18.List All Cars with Their Current Lease Information.
select  v.vehicleid,v.make,l.leaseid,l.startdate,l.enddate,l.leasetype 
from vehicle v 
inner join lease l on l.vehicleid=v.vehicleid;




