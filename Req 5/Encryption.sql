CREATE SYMMETRIC KEY SymKey
WITH ALGORITHM = AES_256
ENCRYPTION BY PASSWORD = 'StrongPassword123';
Go

OPEN SYMMETRIC KEY SymKey
DECRYPTION BY PASSWORD = 'StrongPassword123';
GO

ALTER TABLE Feedback
ADD encrypted_feedback_text VARBINARY(MAX);
Go

ALTER TABLE Feedback
DROP COLUMN feedback_text;
Go

EXEC sp_rename 'Feedback.encrypted_feedback_text', 'feedback_text', 'COLUMN';
GO

CREATE TRIGGER EncryptFeedbackTextTrigger
ON Feedback
AFTER INSERT
AS
BEGIN
    OPEN SYMMETRIC KEY SymKey
    DECRYPTION BY PASSWORD = 'StrongPassword123';

    UPDATE f
    SET f.feedback_text = ENCRYPTBYKEY(KEY_GUID('SymKey'), i.feedback_text)
    FROM Feedback f
    INNER JOIN inserted i ON f.id = i.id;
    
    CLOSE SYMMETRIC KEY SymKey;
END;