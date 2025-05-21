create database ProjectDB
use ProjectDB

create table Table_Employee
(
EmpName varchar(100),EmailId varchar(80),
Age int,salary money,designation char(20),
DOJ date
)
alter table Table_Employee add Project varchar(40)
select * from Table_Employee

insert into Table_Employee values('John','john@g.c',30,40000,
'Analyst','01/01/2024','EShop')
insert into Table_Employee values('David','david@g.c',28,30000,
'Consultant','02/02/2024','Billing System')
insert into Table_Employee values('Rocky','rocky@g.c',35,50000,
'Manager','03/03/2024','HelpDesk')

--Retrieve All Rows ----
select * from Table_Employee

--Retrieve few columns from Table --
select EmpName,EmailID,Designation from Table_Employee

-- Print Rows based on condition  ----Where clause  ---(Manager -Name,Email,Project)
select EmpName 'Name',EmailID 'Email' ,Project from Table_Employee
where Designation='Manager'

--Print Employee -- Manager + Analyst ----> Where condition + Or operator 
-- IN 

select EmpName 'Name',EmailID 'Email' ,Project from Table_Employee
where Designation='Manager' or designation='Analyst'

select EmpName 'Name',EmailID 'Email' ,Project from Table_Employee
where designation In ('Manager','Analyst')

--Logical,Relational and Like operators 

create database CBO_TrainingDB;

use CBO_TrainingDB

Create table Employee_Table
(
EmpId int,EmpName varchar(50),
Age int,Salary money,
EmailID varchar(50),JoinDate date
)

Insert into Employee_Table values(1010,'Santhosh H B',34,10000,'sanhb@deloitte.com',
'10/10/2022')

Insert into Employee_Table values(1011,'John',32,15000,'john@deloitte.com',
'10/01/2023')

Insert into Employee_Table values(1012,'Rocky',30,22000,'rocky@deloitte.com',
'10/01/2021','Manager')

Insert into Employee_Table values(1013,'Adam',28,35000,'adam@deloitte.com',
'08/01/2022','Business Analyst')

Insert into Employee_Table values(1014,'Mohan',25,45000,'mohan@deloitte.com',
'01/02/2020','Business Analyst')


Select * from Employee_Table

select EmpId,EmpName,EmailID from Employee_Table

select * from Employee_Table where EmpId=1011

/* Print empName Salary>10000 */

select EmpName from Employee_Table where Salary>10000

Alter table Employee_Table add Designation varchar(50)

select * from Employee_Table

update Employee_Table set Designation='Manager' where EmpId=1010

update Employee_Table set Designation='Developer' where EmpId=1011



/* Operators -OR, IN , NOT IN , AND*/

/* Print Employee Details Manager Or Developer */
select * from Employee_Table where Designation='Manager' Or Designation='Developer'

select * from Employee_Table where Designation In ('Manager','Developer')

/* Print Employee Details - Except Manager*/

select * from Employee_Table where Designation Not In ('Manager')

/* Aggregate Functions - SUM() , AVG() , MAX() , MIN() , COUNT() */

select Sum(Salary) 'Total-Salary', Max(Salary) as 'Highest Salary',Min(salary) as 'Low Salary',
Count(*) as 'Total Employee 'from Employee_Table 

/*Sorting Order - Order By Keyword */

select * from Employee_Table order by EmpName

select * from Employee_Table order by EmpName desc

/* Print Employee Name Start with A -Like operator */

select * from Employee_Table where EmpName like 'A%'

/* Print List Of Designation Name without duplicates */

select distinct Designation from Employee_Table

/* Group By - Total Salary Paid by Designation */


select * from Employee_Table

select Sum(Salary) as 'Total Salary',Designation from Employee_Table group by 
Designation


/* Print Maximum Salary Paid -For Particular Designation-Sub Query */

/*Print Designation which has Minimum 2 or More Employees - Group By with Having Condition*/

select Designation from Employee_Table group by Designation having Count(Designation)>=2

/* CONSTRAINTS PRIMARY KEY , FOREIGN KEY , CHECK , DEFAULT */

create table Project_Table
(
ProjectId char(6) primary key,
ProjectName varchar(70),
ClientName varchar(50),
WorkLocation varchar(50),
IsBillableProject bit
)

create table EmpDetails_Table
(
EmpId int primary key,
EmpFName varchar(50),
EmpLName varchar(50) default 'N/A',
Salary money,
SkillSet varchar(50),
DOB date,
PID char(6) references Project_Table(ProjectId)
)
insert into EmpDetails_Table values
(105,'Mohan',DEFAULT,25000,'Dotnet','02/02/2000','ESHOP1')

delete EmpDetails_Table where EmpID=105
select * from Project_Table
select * from EmpDetails_Table

/* Print Only Employees with EmployeeName and EmpID SkillSet and Project-Name Mapped to Particular Project */

Select e.EmpFName + ' ' + e.EmpLName as 'EmployeeName', e.EmpId ,e.SkillSet , p.ProjectName
from EmpDetails_Table e inner join Project_Table p
ON p.ProjectId=e.PID

/* Print All Employee Name and EmpId and their Project Details */

Select e.EmpFName + ' ' + e.EmpLName as 'EmployeeName', e.EmpId ,e.SkillSet , p.ProjectName
from EmpDetails_Table e left join Project_Table p
ON p.ProjectId=e.PID

/* Print All Project Names  their respective EmpName and EmpID Details */

Select e.EmpFName + ' ' + e.EmpLName as 'EmployeeName', e.EmpId ,e.SkillSet , p.ProjectName
from EmpDetails_Table e right join Project_Table p
ON p.ProjectId=e.PID

/* Print All Project Names  All  EmpName and EmpID Details */

select e.EmpFName + ' ' + e.EmpLName as 'EmployeeName', e.EmpId ,e.SkillSet , 
p.ProjectName,p.ProjectId from EmpDetails_Table e full outer join Project_Table p
on e.PID=p.ProjectId

select * from EmpDetails_Table
select * from Project_Table


Select * FROM EmpDetails_Table WHERE Salary = (SELECT MIN(Salary) FROM EmpDetails_Table);

Select * FROM EmpDetails_Table WHERE PID in 
(SELECT ProjectID FROM Project_Table 
where ProjectName='CBO' or ProjectName='HMS');

Create table Products_Table
(
ProductId int primary key,
ProductName varchar(50),
ProductCost money,
ProductDescription varchar(80)
)
go
create procedure Proc_ProductRegister
(
@ProductId int,@Name varchar(50),@ProductAmount money,@ProductDetails varchar(80)
)
as
begin
   insert into Products_Table values(@ProductId,@Name,@ProductAmount,@ProductDetails)
end

go

exec Proc_ProductRegister 1001,'Vivo 9091',20000,'Good Product'

select * from Products_Table

go

create procedure Proc_GetProduct
(
@ProductId int
)
as
begin
	select * from Products_Table where ProductId=@ProductId
end

exec Proc_GetProduct 1001


/* Proc- Output Parameter */

create table Table_OrderDetails
(
OrderId int primary key Identity(100,1),
OrderName varchar(50),
ShippingAddress varchar(150),
ContactNumber bigint
)
go

create procedure Proc_GetOrderDetails
(
@OrderName varchar(50),@ShippingAddress varchar(150),@ContactNumber bigint,
@OrderID int output
)
as 
begin
insert into Table_OrderDetails values(@OrderName,@ShippingAddress,@ContactNumber)
select @OrderID=SCOPE_IDENTITY()
end

go

declare @OrderId int
exec Proc_GetOrderDetails 'Mobile Orders','Banglore Marthalli',9090909090,@OrderID output
select @OrderId as 'Order ID'

create table Table_Project
(
ProjectId char(8) primary key,ProjectName varchar(100),
WorkLocation varchar(100),ClientName varchar(80),IsBillable bit
)
create table Table_EmployeeDetail
(
EmpId int primary key,EmpFirstName varchar(80),
EmailId varchar(100) unique,Salary money ,
EmpLastName varchar(80) default 'N/A',
EmpAge int check (EmpAge>20 and EmpAge<50),
ProjID char(8) foreign key references Table_Project(ProjectId)
)
select * from Table_Project
select * from Table_EmployeeDetail

insert into Table_Project values ('ES101','E-Shoping','BLR','Infix',1)
insert into Table_Project values ('BANK101','BankSystem','HYD','RollFix',1)
insert into Table_Project values ('HM101','Healthcare','BLR','Appollo',1)
insert into Table_Project values ('EBILL10','E-Bill','Pune','Paypal',0)

insert into Table_EmployeeDetail values(101,'John S','johns@g.c',
40000,default,24,'ES101')
insert into Table_EmployeeDetail values(102,'David ','davidb@g.c',
50000,'Ben',30,'ES101')
insert into Table_EmployeeDetail values(103,'Anand ','anand@g.c',
60000,default,35,'HM101')
insert into Table_EmployeeDetail values(104,'Teena','teenat@g.c',
40000,'Tania',32,'EBILL10')
insert into Table_EmployeeDetail values(105,'Sonam','sonam@g.c',
60000,'sony',30,null)
insert into Table_EmployeeDetail values(106,'Mohan','mohan@g.c',
60000,'madan',30,'HM101')
select * from Table_Project
select * from Table_EmployeeDetail

-- FUNCTIONS  ---
--AGGREGATE FUNCTIONS ---Sum() , Max() , Min , Average() , Count()

select Sum(Salary) 'totalSal',Max(salary) 'High Sal',
Min(salary) 'Low Sal',AVG(salary) 'Average',COunt(EmpId) 'total Count'
from Table_EmployeeDetail

--Print Number Of Employees based on Project ID -----

select count(projId) 'Employee Count',sum(salary) 'TotalAmount',
projid from Table_EmployeeDetail 
group by projid

--Print ProjectName which has 2 or More employee ---
select ProjectName from Table_Project where projectId in
(select count(projId) 'Employee Count', projid from Table_EmployeeDetail 
group by projid having count(projid)>=2)

--Get Employee details with project who allocated to project --

select ProjectId,ProjectName,EmpFirstName,EmailID
from Table_Project inner join Table_EmployeeDetail
on Table_Project.ProjectId=Table_EmployeeDetail.ProjId

--Get ALl Project_Details and Employee Working in respective project --
select * from Table_Project
select * from Table_EmployeeDetail

select ProjectId,ProjectName,EmpFirstName,EmailID
from Table_Project left join Table_EmployeeDetail
on Table_Project.ProjectId=Table_EmployeeDetail.ProjId

--Get ALl Employee Details  and respective project details--

select ProjectId,ProjectName,EmpFirstName,EmailID
from Table_Project right join Table_EmployeeDetail
on Table_Project.ProjectId=Table_EmployeeDetail.ProjId

--All Project Details and All Employee Details --

select ProjectId,ProjectName,EmpFirstName,EmailID
from Table_Project full join Table_EmployeeDetail
on Table_Project.ProjectId=Table_EmployeeDetail.ProjId







create table Table_Project
(
ProjectId char(8) primary key,ProjectName varchar(100),
WorkLocation varchar(100),ClientName varchar(80),IsBillable bit
)
create table Table_EmployeeDetail
(
EmpId int primary key,EmpFirstName varchar(80),
EmailId varchar(100) unique,Salary money ,
EmpLastName varchar(80) default 'N/A',
EmpAge int check (EmpAge>20 and EmpAge<50),
ProjID char(8) foreign key references Table_Project(ProjectId)
)
select * from Table_Project
select * from Table_EmployeeDetail

insert into Table_Project values ('ES101','E-Shoping','BLR','Infix',1)
insert into Table_Project values ('BANK101','BankSystem','HYD','RollFix',1)
insert into Table_Project values ('HM101','Healthcare','BLR','Appollo',1)
insert into Table_Project values ('EBILL10','E-Bill','Pune','Paypal',0)

insert into Table_EmployeeDetail values(101,'John S','johns@g.c',
40000,default,24,'ES101')
insert into Table_EmployeeDetail values(102,'David ','davidb@g.c',
50000,'Ben',30,'ES101')
insert into Table_EmployeeDetail values(103,'Anand ','anand@g.c',
60000,default,35,'HM101')
insert into Table_EmployeeDetail values(104,'Teena','teenat@g.c',
40000,'Tania',32,'EBILL10')
insert into Table_EmployeeDetail values(105,'Sonam','sonam@g.c',
60000,'sony',30,null)
insert into Table_EmployeeDetail values(106,'Mohan','mohan@g.c',
60000,'madan',30,'HM101')
select * from Table_Project
select * from Table_EmployeeDetail

-- FUNCTIONS  ---
--AGGREGATE FUNCTIONS ---Sum() , Max() , Min , Average() , Count()

select Sum(Salary) 'totalSal',Max(salary) 'High Sal',
Min(salary) 'Low Sal',AVG(salary) 'Average',COunt(EmpId) 'total Count'
from Table_EmployeeDetail

--Print Number Of Employees based on Project ID -----

select count(projId) 'Employee Count',sum(salary) 'TotalAmount',
projid from Table_EmployeeDetail 
group by projid

--Print ProjectName which has 2 or More employee ---
select ProjectName from Table_Project where projectId in
(select count(projId) 'Employee Count', projid from Table_EmployeeDetail 
group by projid having count(projid)>=2)

--Get Employee details with project who allocated to project --

select ProjectId,ProjectName,EmpFirstName,EmailID
from Table_Project inner join Table_EmployeeDetail
on Table_Project.ProjectId=Table_EmployeeDetail.ProjId

--Get ALl Project_Details and Employee Working in respective project --
select * from Table_Project
select * from Table_EmployeeDetail

select ProjectId,ProjectName,EmpFirstName,EmailID
from Table_Project left join Table_EmployeeDetail
on Table_Project.ProjectId=Table_EmployeeDetail.ProjId

--Get ALl Employee Details  and respective project details--

select ProjectId,ProjectName,EmpFirstName,EmailID
from Table_Project right join Table_EmployeeDetail
on Table_Project.ProjectId=Table_EmployeeDetail.ProjId

--All Project Details and All Employee Details --

select ProjectId,ProjectName,EmpFirstName,EmailID
from Table_Project full join Table_EmployeeDetail
on Table_Project.ProjectId=Table_EmployeeDetail.ProjId


Data Integrity
Integrity is the process by which data is validated and consistency is enforced.
It provides quality for data stored in database.
Integrity can be achieved using Constraints.
Integrity can also be programmatic or declarative.
Entity Integrity
Entity integrity shows how each row in a table is a uniquely identifiable entity.
It can be applied to a table by specifying a PRIMARY KEY constraint.
Referential Integrity
Referential integrity helps to maintain the relationships between tables remain preserved when data is inserted, deleted, and modified.
Domain Integrity
It defines a logical set of values that make up the valid values or range of values in a column.


========================================

Examples

create database TrainingDBP1

use TrainingDBP1

/* Project Table		BaseTable -PK
	Employee Table		ForeinKey Table 
*/

create table ProjectTable
(
ProjectId int primary key, ProjectName varchar(100),ProjectDuration int,
ClientName varchar(100),WorkLocation varchar(100)
)
insert into ProjectTable values(1,'E-Shop',70,'FlipKart','Banglore')
insert into ProjectTable values(2,'E-Bill',50,'Ascention','Bangalore')
insert into ProjectTable values(3,'E-Banking',70,'HDFC','Chennai')
insert into ProjectTable values(4,'E-HealthCare',100,'Apollo','Delhi')
insert into ProjectTable values(5,'E-Learning',150,'MSDN','Pune')

update ProjectTable set WorkLocation='Banglore' where ProjectId=2

/* Get All Projects available either in Chennai, Bangalore */

select * from ProjectTable where WorkLocation='Chennai' or WorkLocation='Banglore'
select * from ProjectTable where WorkLocation in('Chennai','Banglore')

/* Get ProjectNames By LocationWise */

select count(ProjectName) ,WorkLocation from ProjectTable group by WorkLocation

/* Get TotalDuration By Location */

select sum(ProjectDuration) ,WorkLocation from ProjectTable group by WorkLocation


/* Get LocationName which has more than One Project */

select WorkLocation,count(ProjectName) from ProjectTable where Count(ProjectName)>1 group by WorkLocation 

select WorkLocation,count(ProjectName) from ProjectTable group by WorkLocation having Count(ProjectName)>1  


/* Group By 
	SYNTAX 
	select ColumnName1,ColumnName2 from TableName group by KeyName <Condition>
	
   1. It can fetch only Column present in GroupBy Keyword or Column which contains Aggregate function

   2. Condition 
		2 Clauses
		Where		----> Condition does not contain aggregate function Where keyword used
		Having		----> Condition contain aggregate Function Having must be used.
		

*/

select * from ProjectTable

create table EmployeeTable
(
EmployeeId int primary key,joiningDate date,
FirstName varchar(100),LastName varchar(100) default 'N/A',
EmailId varchar(100) unique,Age int check(age>20 and age<40),Salary money,
ProjectId int foreign key references ProjectTable(ProjectId)
)
alter table EmployeeTable add Skill varchar(100) 
select * from EmployeeTable

/* Skill ---Add New Column or Remove Column ..Alter Procedure 
Alter 
*/		
insert into EmployeeTable values(101,'01/15/2022','Santhosh','H B','san@g.com',30,40000,1,'Dotnet')
insert into EmployeeTable values(102,'02/15/2022','Sony',default,'sony@g.com',32,30000,2,'BI')
insert into EmployeeTable values(103,'03/20/2023','Adam','George','adam@g.com',32,50000,3,'Oracle')

/* Get EmployeeName and Email Have Sal>25000 and Sal<50000 */

select (FirstName+LastName) 'Name',EmailId from EmployeeTable where Salary>25000 and Salary<50000




































