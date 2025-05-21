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















