# DBA
Project for Data Base Administration COMP338  
ERD : 
![image](https://github.com/itsomar278/DBA/assets/105004653/68b6f442-6f38-45bb-b8c3-7ca90c69b219)
Stored Procedures : 
1 -CheckLateAddFine that is scheduled to run every 24 hours if there was book rental 
where book isn't returned within 5 days it increases the late fine by 1 . 
Triggers :
1 - InsertRentTrigger (INSERT Trigger on BookRent Table):
   This trigger is fired after an INSERT operation on the "BookRent" table.
   It checks if the stock quantity of the book within the branch is sufficient for each inserted record.
   If any book has a stock quantity of 0, it raises an error and rolls back the transaction.
   If the stock quantity is sufficient, it reduces the quantity by 1 for each inserted book.
2 - DeleteCustomerTrigger (INSTEAD OF DELETE Trigger on Customer Table):
   This trigger is fired instead of a DELETE operation on the "Customer" table.
   It checks if the customer has any books in the "BookRent" table where the "is_returned" column is set to 'false' (indicating books not returned).
   If the customer has any books not returned, it raises an error and rolls back the transaction.
   If all associated books are returned, it performs the delete operation on the "Customer" table.

   
