use blinkitdb
Select * from dbo.blinkit_data

update blinkit_data
set Item_Fat_Content =
case
when Item_Fat_Content in ('LF','lowfat') then 'Low Fat'
when Item_Fat_Content = 'reg' then 'Regular'
Else Item_Fat_Content
end

select distinct(Item_Fat_Content) from dbo.blinkit_data

--total sales
select concat(cast(sum(Total_Sales)/1000000 as decimal(10,2)),'Millions') as Total_Sales_Millions
from blinkit_data

--average of total sales
select cast(AVG(Total_Sales)as decimal (10,3)) as Avg_Sales from dbo.blinkit_data

--no of items
select count(*) as No_Of_Items from dbo.blinkit_data

--total sales for LOWFAT
select cast(sum(Total_Sales)/1000000 as decimal(10,2))
from blinkit_data
where Item_Fat_Content = 'Low Fat' and Outlet_Establishment_Year=2022

--total sales for year 2022
select cast(sum(Total_Sales)/1000000 as decimal(10,2)) as Total_Sales_Millions
from blinkit_data
where Outlet_Establishment_Year=2022

--avg rating for items sold
select cast(avg(Rating) as Decimal(10,2))as Avg_Rating from blinkit_data

Select * from dbo.blinkit_data

-- 1) Total sales BY fat content (avg sales,no of items,avg rating)
select Item_Fat_Content,
       concat(cast(sum(Total_Sales)/1000 as decimal(10,2)),'thousand') as Total_Sales_Thousand,
       cast(AVG(Total_Sales)as decimal (10,3)) as Avg_Sales,
       count(*) as No_Of_Items,
       cast(avg(Rating) as Decimal(10,2))as Avg_Rating
from blinkit_data
group by Item_Fat_Content
order by Total_Sales_Thousand desc

--only for establishment year 2022(summa)
select Item_Fat_Content,
       cast(sum(Total_Sales)/1000 as decimal(10,2))as Total_Sales_Thousand,--say sepatately
       cast(AVG(Total_Sales)as decimal (10,2)) as Avg_Sales,
       count(*) as No_Of_Items,
       cast(avg(Rating) as Decimal(10,2))as Avg_Rating
from blinkit_data
where Outlet_Establishment_Year=2022
group by Item_Fat_Content
order by Total_Sales_Thousand desc

--2) total sales BY item type
select top 5 Item_Type,
       cast(sum(Total_Sales) as decimal(10,2))as Total_Sales,--say sepatately
       cast(AVG(Total_Sales)as decimal (10,2)) as Avg_Sales,
       count(*) as No_Of_Items,
       cast(avg(Rating) as Decimal(10,2))as Avg_Rating
from blinkit_data
group by Item_Type
order by Total_Sales 

--3) fat content BY Outlet for total sales(avg sales,no of items,avg rating)

SELECT Outlet_Location_Type,
ISNULL([Low Fat], 0) AS Low_Fat,
ISNULL([Regular], 0) AS Regular
FROM
(
SELECT Outlet_Location_Type, Item_Fat_Content,
 CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
 cast(AVG(Total_Sales)as decimal (10,3)) as Avg_Sales,
 count(*) as No_Of_Items,
       cast(avg(Rating) as Decimal(10,2))as Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT
( 
SUM(Total_Sales)
FOR Item_Fat_Content IN ([Low Fat], [Regular])) AS PivotTable
ORDER BY Outlet_Location_Type;

--4) total sales BY Outlet Establishment(avg sales,no of items,avg rating)
select Outlet_Establishment_Year,
       cast(sum(Total_Sales)as decimal(10,2)) as Total_Sales,
       cast(AVG(Total_Sales)as decimal (10,3)) as Avg_Sales,
 count(*) as No_Of_Items,
       cast(avg(Rating) as Decimal(10,2))as Avg_Rating
from blinkit_data
group by Outlet_Establishment_Year 
order by Total_Sales asc

--5) percentage of sales BY outlet size
select Outlet_Size,
cast(sum(Total_Sales)as decimal(10,2))as Total_Sales,
cast((sum(Total_Sales)*100.0/sum(sum(Total_Sales))Over())as decimal(10,2))as Sales_Percentage
from blinkit_data
group by Outlet_Size
Order by Total_Sales desc

-- 6) sales BY Outlet location
select Outlet_Location_Type,cast(sum(Total_Sales)as decimal(10,2))as Total_Sales
from blinkit_data
group by Outlet_Location_Type
order by Total_Sales DEsc

-- 7) all metrices BY outlet type (total sales,avg sales,no of items,avg rating)
select Outlet_Type,
cast(sum(Total_Sales)as decimal(10,2))as Total_Sales,
cast(AVG(Total_Sales)as decimal (10,2)) as Avg_Sales,
       count(*) as No_Of_Items,
cast(avg(Rating) as Decimal(10,2))as Avg_Rating
from blinkit_data
group by Outlet_Type
order by Total_Sales













































