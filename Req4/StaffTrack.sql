CREATE TABLE ExStaff (
    staff_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    finish_date DATE NOT NULL
);
Go

CREATE TRIGGER DeleteStaffTrigger
ON Staff
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO ExStaff (staff_id, name, date_of_birth, phone_number, finish_date)
    SELECT d.staff_id, d.name, d.date_of_birth, d.phone_number, GETDATE()
    FROM deleted d;
END;