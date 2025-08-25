use blinkitdb 
select * from blinkit_data

-- Total sales
select concat(cast(sum(Sales)/1000000 as decimal(10,2)),'Millions')  
as Total_sales from blinkit_data

-- Average Sales
select cast(AVG(Sales) as decimal(10,2)) as Average_sales from blinkit_data 

--Total number of items
select Count(*) as Total_items from blinkit_data

--Average Rating for item sold
select cast(avg(Rating) as decimal(10,1)) 
as Avg_rating from blinkit_data

-- Total sales by fat content
SELECT Item_Fat_Content, CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales 
FROM blinkit_data 
GROUP BY Item_Fat_Content
--
select Item_Fat_Content,
cast(sum(Sales) as decimal(10,2)) as Total_sales,
cast(AVG(Sales) as decimal(10,2)) as Average_sales,
Count(*) as Total_items,
cast(avg(Rating) as decimal(10,1)) as Avg_rating
from blinkit_data
group by Item_Fat_Content
order by Total_sales desc

-- Total sales by item type
select Item_Type,cast(sum(Sales) as decimal(10,2)) as Total_sales 
from blinkit_data
Group by Item_Type
order by Total_Sales desc
--
select Item_Type,
cast(sum(Sales) as decimal(10,2)) as Total_sales,
cast(AVG(Sales) as decimal(10,2)) as Average_sales,
Count(*) as Total_items,
cast(avg(Rating) as decimal(10,1)) as Avg_rating
from blinkit_data
group by Item_Type
order by Total_sales desc

-- Fat content by outlet for total sales
select Outlet_Location_Type,Item_Fat_Content,
cast(sum(Sales) as decimal(10,2)) as Total_sales,
cast(AVG(Sales) as decimal(10,2)) as Average_sales,
Count(*) as Total_items,
cast(avg(Rating) as decimal(10,1)) as Avg_rating
from blinkit_data
group by Outlet_Location_Type,Item_Fat_Content
order by Total_sales asc
--
SELECT Outlet_Location_Type,  
       ISNULL([Low Fat], 0) AS Low_Fat,  
       ISNULL([Regular], 0) AS Regular 
FROM  
(SELECT Outlet_Location_Type, Item_Fat_Content,  
           CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales 
           FROM blinkit_data 
    GROUP BY Outlet_Location_Type, Item_Fat_Content 
) AS SourceTable 
PIVOT  
( SUM(Total_Sales)  
    FOR Item_Fat_Content IN ([Low Fat], [Regular]) 
) AS PivotTable 
ORDER BY Outlet_Location_Type;

--Total sales by outlet establishment

SELECT Outlet_Establishment_Year, CAST(SUM(Sales)
AS DECIMAL(10,2)) AS Total_Sales 
FROM blinkit_data 
GROUP BY Outlet_Establishment_Year 
ORDER BY Outlet_Establishment_Year 
--
select Outlet_Establishment_Year,
cast(sum(Sales) as decimal(10,2)) as Total_sales,
cast(AVG(Sales) as decimal(10,1)) as Average_sales,
Count(*) as Total_items,
cast(avg(Rating) as decimal(10,2)) as Avg_rating
from blinkit_data
group by Outlet_Establishment_Year
order by Total_sales Desc

-- Percentage of sales by outlet size
SELECT  Outlet_Size,  
CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales, 
CAST((SUM(Sales) * 100.0 / SUM(SUM(Sales))
OVER()) AS DECIMAL(10,2)) AS Sales_Percentage 
FROM blinkit_data 
GROUP BY Outlet_Size 
ORDER BY Total_Sales DESC; 

--Sales by outlet location
select Outlet_Location_Type,
cast(sum(Sales) as decimal(10,2)) as Total_sales,
CAST((SUM(Sales) * 100.0 / SUM(SUM(Sales))
OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
cast(AVG(Sales) as decimal(10,2)) as Average_sales,
Count(*) as Total_items,
cast(avg(Rating) as decimal(10,1)) as Avg_rating
from blinkit_data
group by Outlet_Location_Type
order by Total_sales desc

--All metrics by outlet type
select Outlet_Type,
cast(sum(Sales) as decimal(10,2)) as Total_sales,
CAST((SUM(Sales) * 100.0 / SUM(SUM(Sales))
OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
cast(AVG(Sales) as decimal(10,2)) as Average_sales,
Count(*) as Total_items,
cast(avg(Rating) as decimal(10,1)) as Avg_rating
from blinkit_data
group by Outlet_Type
order by Total_sales desc
