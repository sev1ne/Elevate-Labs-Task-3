
select GeoID,count(*)  AS total_sales
 from sales
 where amount>10
 group by GeoID
 order by total_sales desc;
 
 select s.SPID,
 p.Product,
 s.amount,
 p.Cost_per_box
 from sales s
 INNER JOIN products p ON s.PID=p.PID;
 
 select p.Product,
 s.amount,
 s.SaleDate
 from products p
 left join sales s on p.PID=s.PID;
 
 select r.Region,
 s.amount
 from sales s
 right join geo r on s.GeoID=r.GeoID;
 
 select * from sales;
 select *  from products;
 
 SELECT 
    s.PID,
    SUM(s.Amount * p.Cost_per_box) AS total_sales
FROM sales s
JOIN products p ON s.PID= p.PID
GROUP BY s.PID
HAVING total_sales > (
    SELECT AVG(total_product_sales) FROM (
        SELECT 
            s2.PID,
            SUM(s2.Amount * p2.Cost_per_box) AS total_product_sales
        FROM sales s2
        JOIN products p2 ON s2.PID = p2.PID
        GROUP BY s2.PID
    ) AS subquery
);


SELECT 
    s.GeoID,
    SUM(s.Amount * p.Cost_per_box) AS total_sales,
    AVG(s.Amount * p.Cost_per_box) AS avg_sale_per_transaction
FROM sales s
JOIN products p ON s.PID = p.PID
GROUP BY s.GeoID;

CREATE VIEW monthly_SalesView AS
SELECT 
    DATE_FORMAT(s.SaleDate, '%Y-%m') AS month,
    SUM(s.Amount * p.Cost_per_box) AS total_sales
FROM sales s
JOIN products p ON s.PID = p.PID
GROUP BY DATE_FORMAT(s.SaleDate, '%Y-%m')
ORDER BY month;

CREATE INDEX idx_sales_date ON sales(SaleDate);

CREATE INDEX idx_sales_region_id ON sales(GeoID);