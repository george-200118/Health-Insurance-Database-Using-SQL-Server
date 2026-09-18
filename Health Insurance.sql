create database Health_Insurance
use Health_Insurance
create table Customers(
Customer_id int identity(1,1),
Name varchar(50) ,
DateOfBirth date ,
Gender varchar(6) ,
Address varchar(50) ,
City varchar(50) ,
Phone varchar(50) ,
primary key(Customer_id)
)
create table Coverage(
Coverage_Id int identity(1,1),
Type varchar(20),
Amount int , 
primary key(Coverage_Id),
)
create table Contract(
Contract_Id int identity(1,1),
Customer_Id int,
Start_Date date,
End_Date date,
primary key(Contract_Id),
foreign key(Customer_Id) references Customers(Customer_Id)
)
create table Claims(
Claims_Id int identity(1,1),
Customers_Id int,
Claim_Date date,
Total_Amount int,
Status varchar(10),
Provider_Id int,
primary key(Claims_Id),
foreign key(Customers_Id) references Customers(Customer_Id),
foreign key(Provider_Id) references Provider(Provider_Id)
)
create table Coverage_Claims(
Coverage_Id int,
Claims_Id int,
foreign key (Coverage_Id) references Coverage(Coverage_Id),
foreign key (Claims_Id) references Claims(Claims_Id)
)
create table Provider(
Provider_Id int identity(1,1),
Type varchar(50),
Name varchar(50),
Phone varchar(50),
City varchar(50),
Address varchar(100),
primary key (Provider_Id),
)
select * from Coverage_Claims
insert into Customers values('Õ”«„','2007-07-22','–ﬂ—','«·“»œ«‰Ì-‘«—⁄ «·›—œÊ”-»‰«¡ —ﬁ„ 15','ÿ—ÿÊ”','0988730409')
insert into Coverage values('œÊ«¡',30000)
insert into Contract values(10,'2023-11-02','2024-11-02')
insert into Claims values(10,'2024-01-11',225000,'Active',10)
insert into Provider values('ÿ»Ì» √”‰«‰','œ.»”«„ œ—Ê»Ì','0114444500','œ„‘ﬁ','«·ﬁ’«⁄-„ﬁ«»· „‘›Ï «·“Â—«ÊÌ')
insert into Coverage_Claims values(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10)

select Name from Customers 
join Contract on Customers.Customer_id=Contract.Customer_Id
where End_Date=CAST(getdate()as DATE)

select Name from Customers 
join Claims on Customers.Customer_id=Claims.Customers_Id
where Status='Active' 

select SUM(Total_Amount)as Total_Paid from Claims
where Status='Active' and Claim_Date between Claim_Date and CAST(getdate()as DATE)

select Name,Type,Phone,City,Address from Provider
DBCC CHECKIDENT ('Claims', RESEED, 7);
