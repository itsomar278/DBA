EXECUTE sp_addlogin @loginame =  'Omar', @passwd = '123'
EXECUTE sp_addlogin @loginame =  'D.Abdallah', @passwd = '111'


EXECUTE sp_adduser 'Omar', 'omar'
EXECUTE sp_adduser 'D.Abdallah', 'Abdallah'