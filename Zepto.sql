create database if not exists zepto;
use zepto;
select *from zepto_v2 ;
# how many different product Categories
create view type_of_Product as
select distinct category from zepto_v2 order by category;
select * from type_of_product;

# how many product in stock vs out of stock
create view stock_vs_out_of_stock as 
select outOfStock, count(name) from zepto_v2 group by outOfStock;

select * from stock_vs_out_of_stock;

# which product name present multiple times
create view products_multiple_time as
select name,count(name)  as' numbers o fproduct' from zepto_v2 
group by name 
having count(name) > 1  
order by count(name) desc; 
select * from products_multiple_time ;

# products with price = 0
select * from zepto_v2 where mrp = 0 or discountedSellingPrice = 0;
delete from zepto_v2 where mrp =0;

# convert paise to rupees
update zepto_v2 set mrp =mrp/100.0,discountedSellingPrice =discountedSellingPrice /100.0;
select mrp,discountedSellingPrice  from zepto_v2;

# find the top 10 best value products based on the discount percentage
create view top_10_best_value_product as
select distinct name,mrp,discountPercent
from zepto_v2
order by discountPercent desc
limit 10; 

select * from top_10_best_value_product;

# what are the product with high mrp but out of stock
create view high_mrp_but_out_of_stock as
select distinct name,mrp 
from zepto_v2
where outOfstock = 'True' and mrp >300
order by mrp desc;

select * from high_mrp_but_out_of_stock ;

# calculate Estimated Revenue for each category
create view revenue_for_each_category as 
 select category,sum(discountedSellingPrice * availableQuantity) as total_revenue
from zepto_v2
group by category;

select * from revenue_for_each_category ;

# find all products where mrp is greater than 500 And discount is less than 10%
create view mrp_greater_than_500 as
 select distinct name , mrp ,discountPercent
from zepto_v2 
where mrp > 500 and discountPercent < 10
order by mrp desc,discountPercent desc ;

select * from mrp_greater_than_500 ;

# Identify the top 5 categories offering the highest average discount percentage
create view top_5_categories_highest_avg as 
select category ,
round(avg(discountPercent),2) as avg_discount
from zepto_v2
group by category
order by avg_discount desc limit 5;

select * from top_5_categories_highest_avg ;

# find the price per gram for product above 100g and sort by best value
create view Price_per_gram as
select distinct name,weightInGms , discountedSellingprice,
round(discountedSellingprice/weightInGms,2) as Price_per_gram
from zepto_v2
where weightInGms >= 100
order by Price_per_gram;

select * from Price_per_gram;

# Group the products into categories like Low,Medium,Bulk
create view categories as 
select distinct name,weightInGms,
case when weightInGms < 1000 then'Low'
     when weightInGms < 5000 then 'Medium'
     else 'Bulk'
     end as weight_category
from zepto_v2;

select * from categories ;

# what is the Total Inventory  Weight  Per category
create view Total_inventaory_weight as 
select category,
sum(weightInGms * availableQuantity) as total_weight
from zepto_v2
group by category
order by total_weight;

select * from Total_inventaory_weight ;


# 1 how many different product Categories
select * from type_of_product;

# 2 how many product in stock vs out of stock
select * from stock_vs_out_of_stock;

# 3 which product name present multiple times
select * from products_multiple_time ;

# 4 find the top 10 best value products based on the discount percentage
select * from top_10_best_value_product;

# 5 what are the product with high mrp but out of stock
select * from high_mrp_but_out_of_stock ;

# 6 calculate Estimated Revenue for each category
select * from revenue_for_each_category ;

# 7 find all products where mrp is greater than 500 And discount is less than 10%
select * from mrp_greater_than_500 ;

# 8 Identify the top 5 categories offering the highest average discount percentage
select * from top_5_categories_highest_avg ;

# 9 find the price per gram for product above 100g and sort by best value
select * from Price_per_gram;

# 10 Group the products into categories like Low,Medium,Bulk
select * from categories ;

# 11 what is the Total Inventory  Weight  Per category
select * from Total_inventaory_weight ;