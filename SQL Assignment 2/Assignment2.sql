SELECT s.[name] as [Salesman Name], c.cust_name as [Customer Name], s.city as City
from salesman s
inner join customer c
on s.salesman_id = c.salesman_id
where s.city = c.city

select o.ord_no as [Order No.], o.purch_amt as [Purchase Amount], c.cust_name as [Customer Name], c.city as [Customer City]
from orders o
inner join customer c 
on o.customer_id = c.customer_id
where purch_amt between 500 and 2000

select c.cust_name as [Customer name],c.city as City, s.[name] as [Salesman name], s.commission [Salesman commission] 
from customer c
inner join salesman s
on c.salesman_id = s.salesman_id



select c.cust_name as [Customer name],c.city as City, s.[name] as [Salesman name], s.commission as [Salesman commission]
from customer c
inner join salesman s
on c.salesman_id = s.salesman_id
where s.commission > 0.12

SELECT  c.cust_name as [Customer Name], c.city as [Customer City], s.[name] as [Salesman Name], s.city as [Salesman City], s.commission as [Salesman commission]
from salesman s
inner join customer c
on s.salesman_id = c.salesman_id
where s.city != c.city and s.commission > 0.12



select o.ord_no as [Order no.], o.ord_date as [Order Date], o.purch_amt as [Purchase amount], c.cust_name as [Customer name], c.grade as [Grade], s.[name] as [Salesman name], s.commission as [Salesman commission]  
from orders o
inner join customer c
on o.customer_id = c.customer_id
inner join salesman s
on o.salesman_id = s.salesman_id



select o.ord_no as [Order no.], o.ord_date as [Order Date], o.purch_amt as [Purchase amount], c.*, s.[name] as [Salesman name], s.city as [Salesman city], s.commission as [Commission]
from orders o
inner join customer c
on o.customer_id = c.customer_id
inner join salesman s
on o.salesman_id = s.salesman_id



select c.cust_name as [Customer name],c.city as City, c.grade as Grade, s.[name] as [Salesman name],s.city as [Salesman city]
from customer c
inner join salesman s
on c.salesman_id = s.salesman_id
order by c.customer_id


select c.cust_name as [Customer name],c.city as City, c.grade as Grade, s.[name] as [Salesman name],s.city as [Salesman city]
from customer c
inner join salesman s
on c.salesman_id = s.salesman_id
where c.grade < 300
order by c.customer_id




select c.cust_name as [Customer Name], o.ord_no as [Order No.], o.ord_date as [Order date], o.purch_amt as [Order Amount], c.city as [Customer City]
from customer c
left join orders o 
on o.customer_id = c.customer_id
order by o.ord_date


select c.cust_name as [Customer name], c.city as [Customer city], o.ord_no as [Order no.],  o.ord_date as [Order date], o.purch_amt as [Order Amount], s.[name] as [Salesman name], s.commission as [Commission]
from customer c
left join orders o
on o.customer_id = c.customer_id
inner join salesman s
on o.salesman_id = s.salesman_id



select s.[name] as [Salesman name], count(c.customer_id) as [Customers engaged]
from salesman s
left join customer c
on s.salesman_id = c.salesman_id
group by s.[name]


select s.[name] as [Salesman name], c.cust_name as [Customer name], c.city as [Customer city], c.grade as [Grade] , o.ord_no as [Order no.],  o.ord_date as [Order date], o.purch_amt as [Order Amount]
from salesman s
left join customer c
on c.salesman_id = s.salesman_id
inner join orders o
on o.customer_id = c.customer_id 




select s.[name] as [Salesman name], c.cust_name as [Customer name], c.grade as [Grade] , o.ord_no as [Order no.],  o.ord_date as [Order date], o.purch_amt as [Order Amount]
from salesman s
left join customer c
on c.salesman_id = s.salesman_id
inner join orders o
on o.customer_id = c.customer_id 
where o.purch_amt > 2000 and c.grade is not null 


select s.[name] as [Salesman name], c.cust_name as [Customer name], c.grade as [Grade] , o.ord_no as [Order no.],  o.ord_date as [Order date], o.purch_amt as [Order Amount]
from salesman s
left join customer c
on c.salesman_id = s.salesman_id
inner join orders o
on o.customer_id = c.customer_id 
where o.purch_amt > 2000 and c.grade is not null


select * 
from customer c
right join (select customer_id, count(ord_no) as orderCount from orders group by customer_id having count(ord_no) > 0) o
on c.customer_id = o.customer_id
where (c.grade is not null) 



select * from salesman cross join customer


select * from salesman cross join customer 
where salesman.city = customer.city



select * from salesman cross join customer 
where salesman.city = customer.city AND customer.grade is not null


select * from salesman cross join customer 
where salesman.city != customer.city AND customer.grade is not null