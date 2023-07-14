USE Albayan;
GO

CREATE PROCEDURE CheckLateAddFine
AS
BEGIN
    DECLARE @CurrentDate DATE;
    
    SET @CurrentDate = GETDATE();
    UPDATE BookRent
    SET is_late = 'true',
        late_fines = late_fines + 1.0
    WHERE DATEDIFF(DAY, rent_date, @CurrentDate) >= 5
          AND is_returned = 'false';
END;
