# DBA
Project for Database Administration COMP338

ERD:
![ERD Image](https://github.com/itsomar278/DBA/assets/105004653/68b6f442-6f38-45bb-b8c3-7ca90c69b219)

Stored Procedures:
1. CheckLateAddFine:
   -- Description: Scheduled to run every 24 hours. If there are book rentals where the books haven't been returned within 5 days, it increases the late fine by 1.
   -- Usage: Handles late fines for overdue book rentals.

Triggers:
1. InsertRentTrigger (INSERT Trigger on BookRent Table):
   -- Description: Fired after an INSERT operation on the "BookRent" table.
   -- Functionality:
      - Checks if the stock quantity of the book within the branch is sufficient for each inserted record.
      - Raises an error and rolls back the transaction if any book has a stock quantity of 0.
      - Reduces the stock quantity by 1 for each inserted book if the quantity is sufficient.

2. DeleteCustomerTrigger (INSTEAD OF DELETE Trigger on Customer Table):
   -- Description: Fired instead of a DELETE operation on the "Customer" table.
   -- Functionality:
      - Checks if the customer has any books in the "BookRent" table where the "is_returned" column is set to 'false' (indicating books not returned).
      - Raises an error and rolls back the transaction if the customer has any books not returned.
      - Performs the delete operation on the "Customer" table if all associated books are returned.



