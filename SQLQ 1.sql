/*_____________________discover our dataset_____________________*/
/*get an idea of the data */
select * from geo;
select * from people;
select * from products;
select * from sales;

/*find the number of rows in a table */
select count(*)
from sales;

/*describe the data*/
SP_COLUMNS 'geo';
SP_COLUMNS 'people';
SP_COLUMNS 'products';
SP_COLUMNS 'sales';

/*find distict values*/
select distinct Geo;
from geo;

/*finding the missing values (some exemples )*/
select product,Product_ID;
from products;
where size is null;

/* count how much missing valus are there */
select count (product)
from products
where size is null;

/* finde duplicates */
select SP_ID, count(*) from people
group by SP_ID;

/*drop all duplicates if existe */
with products as
(
select * , ROW_NUMBER() over (partition by Product_ID order by Product_ID ) as RowNumber
from products
)
delete from products where RowNumber >1;

/*__________________________analysis phase____________________________*/

/*totales sales for the year 2021*/
select sum(Amount)
from sales 
where Date>='2021-01-01' and Date<= '2021-12-30';

/*the sales of each  product */
select product ,amount=sum (Amount) 
from sales
group by Product;

/*the sales by each saler */
select Sales_Person ,amount=sum (Amount) 
from sales
group by Sales_Person;

/*the enformation of the salers based on their sales */
select   p.SP_ID, s.Sales_Person , p.Team,p.Location , Amount= sum(s.Amount) 
from sales as s
join people as p on s.Sales_Person=p.SP_ID
group by s.Sales_Person, p.Team, p.SP_ID,p.Location;





