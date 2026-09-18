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
--Queries
--List Customers That Their Contracts Ends Today
select Name from Customers 
join Contract on Customers.Customer_id=Contract.Customer_Id
where End_Date=CAST(getdate()as DATE)
--List Customers Where Claim Status Is Active
select Name from Customers 
join Claims on Customers.Customer_id=Claims.Customers_Id
where Status='Active' 
--Calculate The Sum Of The Claims Where It's Status Is Active And Its Date Between The Claim Date And Today
select SUM(Total_Amount)as Total_Paid from Claims
where Status='Active' and Claim_Date between Claim_Date and CAST(getdate()as DATE)
--View All The Providers Info
select Name,Type,Phone,City,Address from Provider
