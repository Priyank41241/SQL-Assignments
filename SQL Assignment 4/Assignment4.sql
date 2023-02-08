 CREATE PROCEDURE spRuleBasedAvgFreight 
  @CustomerId nchar(5),
  @AvgFreight money output

 AS
 BEGIN 
	  SELECT @AvgFreight = AVG(Freight) FROM Orders Where CustomerID = @CustomerId ;
 END



ALTER TRIGGER OrdersModifyOnInsert
 ON Orders 
 INSTEAD OF INSERT 
 AS
 BEGIN 
	DECLARE @AvgFreight money
	DECLARE @OrderId int
	DECLARE @CustID nchar(5)
	DECLARE @EmployeeId int
	DECLARE @OrderDate datetime
	DECLARE @RequiredDate datetime
	DECLARE @ShippedDate datetime
	DECLARE	@ShipVia int
	DECLARE @Freight money
	DECLARE @ShipName nvarchar(40)
	DECLARE @ShipAddress nvarchar(60)
	DECLARE	@ShipCity nvarchar(15)
	DECLARE @ShipRegion nvarchar(15)
	DECLARE @ShipPostalCode nvarchar(10)
	DECLARE @ShipCountry nvarchar(15)
	
	SELECT @OrderId = OrderID from inserted 
	SELECT @CustID = CustomerID FROM inserted
	SELECT @EmployeeId = EmployeeID FROM inserted
	SELECT @OrderDate = OrderDate FROM inserted
	SELECT @RequiredDate = RequiredDate FROM inserted
	SELECT @ShippedDate = ShippedDate FROM inserted
	SELECT @ShipVia = ShipVia FROM inserted
	SELECT @Freight = Freight FROM inserted
	SELECT @ShipName = ShipName FROM inserted
	SELECT @ShipAddress = ShipAddress FROM inserted
	SELECT @ShipCity = ShipCity FROM inserted
	SELECT @ShipRegion = ShipRegion FROM inserted
	SELECT @ShipPostalCode = ShipPostalCode FROM inserted
	SELECT @ShipCountry = ShipCountry FROM inserted

	EXEC spRuleBasedAvgFreight @CustId , @AvgFreight OUTPUT 

	IF (@Freight <=  @AvgFreight)
	BEGIN
		PRINT 'Freight value is higher than average value...'
	END
	ELSE
	BEGIN 
		INSERT INTO Orders values ( @CustID, @EmployeeId, @OrderDate, @RequiredDate, @ShippedDate, @ShipVia, @Freight, @ShipName, @ShipAddress, @ShipCity, @ShipRegion, @ShipPostalCode, @ShipCountry)
	END
 END


 CREATE TRIGGER OrdersModifyOnUpdate
 ON Orders 
 INSTEAD OF UPDATE 
 AS
 BEGIN 
	DECLARE @AvgFreight money
	DECLARE @OrderId int
	DECLARE @CustID nchar(5)
	DECLARE @EmployeeId int
	DECLARE @OrderDate datetime
	DECLARE @RequiredDate datetime
	DECLARE @ShippedDate datetime
	DECLARE	@ShipVia int
	DECLARE @Freight money
	DECLARE @ShipName nvarchar(40)
	DECLARE @ShipAddress nvarchar(60)
	DECLARE	@ShipCity nvarchar(15)
	DECLARE @ShipRegion nvarchar(15)
	DECLARE @ShipPostalCode nvarchar(10)
	DECLARE @ShipCountry nvarchar(15)
	
	SELECT @OrderId = OrderID from inserted  
	SELECT @CustID = CustomerID FROM inserted
	SELECT @EmployeeId = EmployeeID FROM inserted
	SELECT @OrderDate = OrderDate FROM inserted
	SELECT @RequiredDate = RequiredDate FROM inserted
	SELECT @ShippedDate = ShippedDate FROM inserted
	SELECT @ShipVia = ShipVia FROM inserted
	SELECT @Freight = Freight FROM inserted
	SELECT @ShipName = ShipName FROM inserted
	SELECT @ShipAddress = ShipAddress FROM inserted
	SELECT @ShipCity = ShipCity FROM inserted
	SELECT @ShipRegion = ShipRegion FROM inserted
	SELECT @ShipPostalCode = ShipPostalCode FROM inserted
	SELECT @ShipCountry = ShipCountry FROM inserted


	EXEC spRuleBasedAvgFreight 'RATTC' , @AvgFreight OUTPUT 

	IF (@Freight <= @AvgFreight)
	BEGIN
		PRINT 'Freight value is higher than average value...';
	END
	ELSE
	BEGIN 
		INSERT INTO Orders values (@OrderId, @CustID, @EmployeeId, @OrderDate, @RequiredDate, @ShippedDate, @ShipVia, @Freight, @ShipName, @ShipAddress, @ShipCity, @ShipRegion, @ShipPostalCode, @ShipCountry)
	END
 END


 DECLARE @AvgFreight1 money
 	EXEC spRuleBasedAvgFreight 'RATTC' , @AvgFreight1 OUTPUT
	PRINT @AvgFreight1

	INSERT INTO Orders VALUES (N'RATTC',1,'5/6/1998','6/3/1998',NULL,2,8.53,
	N'Rattlesnake Canyon Grocery',N'2817 Milton Dr.',N'Albuquerque',
	N'NM',N'87110',N'USA')

	INSERT INTO Orders VALUES (N'RATTC',1,'5/6/1998','6/3/1998',NULL,2,228.53,
	N'Rattlesnake Canyon Grocery',N'2817 Milton Dr.',N'Albuquerque',
	N'NM',N'87110',N'USA')

	SELECT * FROM Orders WHERE CustomerID = 'RATTC' and Freight = 228.53 

	


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROC spEmployeeSalesByCountry
AS 
BEGIN
		Select e.EmployeeID, e.FirstName, e.LastName, e.Country, SUM( p.OrderSum ) as [Employee Sales]
		from Employees e
		Left join (Select o.OrderID, o.EmployeeID, od.OrderSum from Orders o
		Left join (Select OrderId, (SUM(CONVERT(money,( UnitPrice * Quantity * (1-Discount)/100))*100)) as [OrderSum] FROM [Order Details] GROUP BY OrderID) od
		on o.OrderID = od.OrderID) p
		on e.EmployeeID = p.EmployeeID
		Group by e.EmployeeID, e.FirstName, e.LastName, e.Country
END

EXEC spEmployeeSalesByCountry






--EmployeeID, LastName, FirstName, 


--select * from [Order Details]


--Select OrderId, (SUM(CONVERT(money,( UnitPrice * Quantity * (1-Discount)/100))*100)) FROM [Order Details] GROUP BY OrderID

--Select * from Orders o
--Left join (Select OrderId, (SUM(CONVERT(money,( UnitPrice * Quantity * (1-Discount)/100))*100)) as [OrderSum] FROM [Order Details] GROUP BY OrderID) od
--on o.OrderID = od.OrderID 
 

 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROC spEmployeeSalesByYear
AS 
BEGIN
		Select e.EmployeeID, e.FirstName, e.LastName, p.Salesyear, SUM( p.OrderSum ) as [Employee Sales]
		from Employees e
		Left join (Select o.OrderID, o.EmployeeID,YEAR(o.OrderDate) as [Salesyear], od.OrderSum from Orders o
		Left join (Select OrderId, (SUM(CONVERT(money,( UnitPrice * Quantity * (1-Discount)/100))*100)) as [OrderSum] FROM [Order Details] GROUP BY OrderID) od
		on o.OrderID = od.OrderID) p
		on e.EmployeeID = p.EmployeeID
		Group by e.EmployeeID, e.FirstName, e.LastName,p.Salesyear
END

EXEC spEmployeeSalesByYear

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\



--Select  ProductID, (SUM(CONVERT(money,( UnitPrice * Quantity * (1-Discount)/100))*100)) as [OrderSum] FROM [Order Details] GROUP BY  ProductID



--select  p.CategoryID,SUM(s.OrderSum) from Products p
--left join (Select  ProductID, (SUM(CONVERT(money,( UnitPrice * Quantity * (1-Discount)/100))*100)) as [OrderSum] FROM [Order Details] GROUP BY  ProductID) s
--on p.ProductID = s.ProductID
--Group by p.CategoryID

CREATE PROC spSalesByCategory
AS
BEGIN 
	SELECT c.CategoryID, c.CategoryName, ct.[Total sales]  FROM Categories c
	inner join (select  p.CategoryID,SUM(s.OrderSum) as [Total sales] from Products p
	left join (Select  ProductID, (SUM(CONVERT(money,( UnitPrice * Quantity * (1-Discount)/100))*100)) as [OrderSum] FROM [Order Details] GROUP BY  ProductID) s
	on p.ProductID = s.ProductID
	Group by p.CategoryID) ct
	on c.CategoryID = ct.CategoryID
END

EXEC spSalesByCategory

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROC spTenMostExpnsProducts
AS
BEGIN
	SELECT TOP(10) * FROM Products ORDER BY UnitPrice DESC
END

EXEC spTenMostExpnsProducts
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROC spInsertOrderDetails
@OrderId int, 
@ProductId int,
@UnitPrice money,
@Quantity smallint, 
@Discount real

AS
BEGIN
	INSERT INTO [Order Details] VALUES (@OrderId, @ProductId,@UnitPrice, @Quantity, @Discount)
END

EXEC spInsertOrderDetails 10248,2,1,1,1
SELECT * FROM [Order Details] WHERE OrderID = 10248


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROC spUpdateOrderDetails
@OrderId int, 
@ProductId int,
@NewUnitPrice money,
@NewQuantity smallint, 
@NewDiscount real
AS
BEGIN
	UPDATE [Order Details]
	SET UnitPrice = @NewUnitPrice, Quantity = @NewQuantity, Discount = @NewDiscount
	WHERE OrderID = @OrderId AND ProductID = @ProductId
END

EXEC spUpdateOrderDetails 10248,2,5,5,0.05
SELECT * FROM [Order Details] WHERE OrderID = 10248

----------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROC spEmployeeOrderSalesByCountry
AS
BEGIN
	SELECT e.EmployeeID, e.FirstName, e.LastName, e.Country, COUNT(O.OrderID) as [Total Order] FROM Employees e 
	LEFT JOIN Orders o
	ON E.EmployeeID = O.EmployeeID
	GROUP BY e.EmployeeID, e.FirstName, e.LastName, e.Country
END

EXEC spEmployeeOrderSalesByCountry

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE PROC spEmployeeOrderSalesByYear
AS
BEGIN
	SELECT e.EmployeeID, e.FirstName, e.LastName, o.[Order Year],  COUNT(o.[Total Orders]) as [Order count] FROM Employees e
	INNER JOIN (SELECT EmployeeID, YEAR(OrderDate) as [Order Year], COUNT(OrderID) as [Total Orders] FROM Orders GROUP BY EmployeeID, OrderDate) o
	ON e.EmployeeID = o.EmployeeID 
	GROUP BY e.EmployeeID, e.FirstName, e.LastName, o.[Order Year]
	ORDER BY o.[Order Year] 
END

create proc abcd
as
begin

select e.EmployeeID,e.FirstName,e.LastName, YEAR(O.OrderDate) as [Order Year], COUNT(O.OrderID) as [Total Orders]
from Employees e, Orders o
 
end



