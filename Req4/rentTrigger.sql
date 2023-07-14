CREATE TRIGGER InsertRentTrigger
ON BookRent
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the book stock quantity is sufficient
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN Stock s ON i.ISBN = s.ISBN AND i.branch_id = s.branch_id
        WHERE s.quantity = 0
    )
    BEGIN
        -- Rollback the transaction
        RAISERROR ('Insufficient stock quantity. Transaction has been rolled back.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- Update the book stock quantity
        UPDATE Stock
        SET quantity = quantity - 1
        WHERE EXISTS (
            SELECT 1
            FROM inserted i
            WHERE Stock.ISBN = i.ISBN AND Stock.branch_id = i.branch_id
        );
    END
END;