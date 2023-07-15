execute sp_addrole @rolename = 'Branch_Manager';
execute sp_addrole @rolename = 'Stock_Manager';


Grant select , update 
On Staff 
To Branch_Manager ;

Grant select , insert , update , delete 
On Customer 
To Branch_Manager ;

Grant select , insert 
On Feedback 
To Branch_Manager ;

Grant select , insert , update 
On BookRent 
To Branch_Manager ;

GRANT ALL PRIVILEGES
On Stock 
To Branch_Manager ;

Grant select 
On Branch 
To Branch_Manager ;

Grant select 
On Customer 
To Stock_Manager ;

Grant select 
On Feedback 
To Stock_Manager ;

Grant select , update 
On Customer 
To Stock_Manager ;

Grant select , insert , update , delete 
On Stock 
To Stock_Manager ;

