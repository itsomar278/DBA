CREATE TRIGGER DeleteCustomerTrigger
ON Customer
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the customer has any books not returned
    IF EXISTS (
        SELECT 1
        FROM deleted d
        INNER JOIN BookRent br ON d.id = br.customer_id
        WHERE br.is_returned = 'false'
    )
    BEGIN
        -- Rollback the transaction
        RAISERROR ('Cannot delete customer with books not returned. Transaction has been rolled back.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- Perform the delete operation
        DELETE FROM Customer
        WHERE EXISTS (
            SELECT 1
            FROM deleted d
            WHERE Customer.id = d.id
        );
    END
END;