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

3.SalaryHistoryTrigger (AFTER UPDATE Trigger on Staff Table):
- Description: Fired after an UPDATE operation on the "Staff" table.
- Functionality:
  - Tracks the salary history for staff members.
  - Inserts the staff information, along with the old and new salaries, into the "SalaryHistory" table.
  - Determines the type of modification (Raise or Cut) based on whether the new salary is greater than the old salary.
  - Records the date and time of the modification.

4.DeleteStaffTrigger (AFTER DELETE Trigger on Staff Table):
- Description: Fired after a DELETE operation on the "Staff" table.
- Functionality:
  - Tracks the deletions of staff members and saves their information in the "ExStaff" table.
  - Records the staff information, including the staff ID, name, date of birth, phone number, and finish date (date of deletion).
  - Allows for historical tracking of deleted staff members.

5.EncryptFeedbackTextTrigger (AFTER INSERT Trigger on Feedback Table):
-Description: Fired after an INSERT operation on the "Feedback" table.
-Functionality:
   -Opens the symmetric key SymKey for decryption using the password 'StrongPassword123'.
   -Updates the feedback_text column in the Feedback table with the encrypted value of the inserted feedback_text using the symmetric key.
   -Applies the encryption operation for each inserted row by joining the Feedback table with the inserted pseudo table on the ID.
   -Closes the symmetric key SymKey after the encryption process.



