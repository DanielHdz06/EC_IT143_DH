----HAB Dataset

----Q1 - What are the trends in the average price of avocados by region from 2015 to 2018? Please include data on volume sold and the types of avocados.
----A: 
SELECT 
    year, 
    region, 
    type, 
    AVG(AveragePrice) AS AveragePrice, 
    SUM(Total_Volume) AS TotalVolume
FROM 
    avocado
GROUP BY 
    year, 
    region, 
    type
ORDER BY 
    year, 
    region, 
    type;

----Q2 - Can you provide a detailed comparison of avocado sales volumes, prices, and bag sizes in different regions for the year 2017?
----A:
SELECT 
    region, 
    AVG(AveragePrice) AS AveragePrice, 
    SUM(Total_Volume) AS TotalVolume, 
    SUM(Small_Bags) AS SmallBags, 
    SUM(Large_Bags) AS LargeBags, 
    SUM(XLarge_Bags) AS XLargeBags
FROM 
    avocado
WHERE 
    year = 2017
GROUP BY 
    region
ORDER BY 
    region;

----Q3 - How do the total sales volumes and average prices of avocados in different cities and regions compare for the first quarter of 2015? Please include a breakdown by bag size.
----A:
SELECT 
    a.region, 
    AVG(a.AveragePrice) AS AveragePrice, 
    SUM(a.Total_Volume) AS TotalVolume, 
    SUM(a.Small_Bags) AS SmallBags, 
    SUM(a.Large_Bags) AS LargeBags, 
    SUM(a.XLarge_Bags) AS XLargeBags,
    g.area_type
FROM 
    avocado a
JOIN 
    avocado_area_geocode g ON a.region = g.area_name
WHERE 
    YEAR(a.Date) = 2015 AND 
    DATEPART(qq, a.Date) = 1
GROUP BY 
    a.region, 
    g.area_type
ORDER BY 
    g.area_type, 
    a.region;

----Q4 - What is the relationship between avocado sales and geographic locations (latitude and longitude) across the United States?
----A:
SELECT 
    g.latitude, 
    g.longitude, 
    SUM(a.Total_Volume) AS TotalVolume, 
    AVG(a.AveragePrice) AS AveragePrice
FROM 
    avocado AS a
JOIN 
    avocado_area_geocode g ON a.region = g.area_name
GROUP BY 
    g.latitude, 
    g.longitude
ORDER BY 
    TotalVolume DESC;

----Q5 - How did the sales and prices of avocados vary across different states in the first half of 2018? Specifically, focus on the impact of bag sizes and types of avocados.
----A:
SELECT 
    g.state_resolve, 
    AVG(a.AveragePrice) AS AveragePrice, 
    SUM(a.Total_Volume) AS TotalVolume, 
    SUM(a.Small_Bags) AS SmallBags, 
    SUM(a.Large_Bags) AS LargeBags, 
    SUM(a.XLarge_Bags) AS XLargeBags, 
    a.type
FROM 
    avocado a
JOIN 
    avocado_area_geocode g ON a.region = g.area_name
WHERE 
    YEAR(a.Date) = 2018 AND 
    MONTH(a.Date) BETWEEN 1 AND 6
GROUP BY 
    g.state_resolve, 
    a.type
ORDER BY 
    g.state_resolve, 
    a.type;

----Q6 - Can you analyze the total volume and average price of avocados sold in different cities and states for the year 2016? Include insights on the most popular bag sizes and types of avocados.
----A:
SELECT 
    g.city_resolve, 
    g.state_resolve, 
    AVG(a.AveragePrice) AS AveragePrice, 
    SUM(a.Total_Volume) AS TotalVolume, 
    SUM(a.Small_Bags) AS SmallBags, 
    SUM(a.Large_Bags) AS LargeBags, 
    SUM(a.XLarge_Bags) AS XLargeBags, 
    a.type
FROM 
    avocado a
JOIN 
    avocado_area_geocode g ON a.region = g.area_name
WHERE 
    year = 2016
GROUP BY 
    g.city_resolve, 
    g.state_resolve, 
    a.type
ORDER BY 
    g.state_resolve, 
    g.city_resolve, 
    a.type;
