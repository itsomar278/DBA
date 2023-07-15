

CREATE TABLE SalaryHistory (
    staff_id INT,
    name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    old_salary DECIMAL(10, 2) NOT NULL,
    new_salary DECIMAL(10, 2) NOT NULL,
    type VARCHAR(10) NOT NULL,
    modified_date DATETIME NOT NULL
);
Go

CREATE TRIGGER SalaryHistoryTrigger
ON Staff
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO SalaryHistory (staff_id, name, date_of_birth, phone_number, old_salary, new_salary, type, modified_date)
    SELECT i.staff_id, i.name, i.date_of_birth, i.phone_number, d.salary, i.salary,
           CASE WHEN i.salary > d.salary THEN 'Raise' ELSE 'Cut' END,
           GETDATE()
    FROM inserted i
    INNER JOIN deleted d ON i.staff_id = d.staff_id;
END;