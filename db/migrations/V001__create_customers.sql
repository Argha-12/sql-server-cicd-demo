CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Salary DECIMAL(10,2)
);

INSERT INTO Employee
VALUES (1, 'Argha', 30000);

SELECT * FROM Employee;