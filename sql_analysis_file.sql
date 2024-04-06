use capstrone;

-- query for all tables in data
select * from etfs;
select * from mutualfunds;
select * from etfprices;
select * from mprice;

-- MutualFunds Returns of 1 year,3year, 5 year
select concat(sum(fund_return_1year)/1000,'K') from mutualfunds;
select concat(sum(fund_return_3years)/1000,'K') from mutualfunds;
select concat(sum(fund_return_5years)/1000,'K') from mutualfunds;

-- ETFs Fund Returns of 1 year,3year, 5 year
select concat(sum(fund_return_1year)/1000,'K') from etfs;
select concat(sum(fund_return_3years)/1000,'K') from etfs;
select concat(sum(fund_return_5years)/1000,'K') from etfs;

-- ETFs Sum of total_net_assets by fund_category
select concat(sum(total_net_assets)/1000000000000,'T'), fund_category from etfs group by fund_category;


-- Mutual Funds Sum of total_net_assets by fund_category
select concat(sum(total_net_assets)/1000000000000,'T'), fund_category from mutualfunds group by fund_category;

-- Nav_per_share and Count of Mutual_Funds
select concat(sum(nav_per_share)/1000000,'M'), concat(count(fund_symbol)/1000000,'M'),price_date
 from mprice group by price_date;
 
--  volume and count of symbol of etfs 
 select concat(sum(volume)/1000000,'M'), concat(count(fund_symbol)/1000000,'M'),price_date
 from etfprices group by price_date;
 
--  ETFs Average return
select avg (fund_return_2014 + fund_return_2015 + fund_return_2016 + fund_return_2017
 + fund_return_2018 + fund_return_2019 + fund_return_2020) as Etfs_fund_return
from etfs;

--  MutualFunds Average return
select avg (fund_return_2014 + fund_return_2015 + fund_return_2016 + fund_return_2017
 + fund_return_2018 + fund_return_2019 + fund_return_2020) as Mutual_fund_return
from mutualfunds;

-- Sum of ETF Count Vs Sum of Mutual_Fund Count 
select 
 Year(e.inception_date) AS year,
 COUNT(DISTINCT e.fund_symbol) AS etf_count,
 COUNT(DISTINCT m.fund_symbol) AS mutual_fund_count
from 
 etfs  e 
join mutualfunds  m on Year(e.inception_date) = Year(m.inception_date)
where 
 Year(e.inception_date) >=2010
group by
 Year(e.inception_date);
 
--  Neg_Etf_fund_return by fund_category
select fund_category,count(fund_return_5years) as neg_fund_return from etfs where fund_return_5years<0
group by fund_category order by neg_fund_return;

--  Neg_Mutual_fund_return by fund_category
select fund_category,count(fund_return_5years) as neg_fund_return from mutualfunds where fund_return_5years<0
group by fund_category order by neg_fund_return;

# Cards
select avg(annual_holdings_turnover) from etfs;

select avg(annual_holdings_turnover) from mutualfunds;

select concat(sum(fund_alpha_3years)/1000,'k'),concat(sum(fund_alpha_5years)/1000,'k'),concat(sum(fund_beta_5years)/1000,'k') from mutualfunds;

select concat(sum(fund_alpha_3years)/1000,'k'),concat(sum(fund_alpha_5years)/1000,'k'),concat(sum(fund_beta_5years)/1000,'k') from etfs;

select dense_rank() over(order by avg (fund_return_2014 + fund_return_2015 + fund_return_2016 + fund_return_2017
 + fund_return_2018 + fund_return_2019 + fund_return_2020)desc) as DRank, avg (fund_return_2014 + fund_return_2015 + fund_return_2016 + fund_return_2017
 + fund_return_2018 + fund_return_2019 + fund_return_2020) as Mutual_fund_return,fund_family from mutualfunds group by fund_family;
 
 
select dense_rank() over(order by avg (fund_return_2014 + fund_return_2015 + fund_return_2016 + fund_return_2017
 + fund_return_2018 + fund_return_2019 + fund_return_2020)desc) as DRank, avg (fund_return_2014 + fund_return_2015 + fund_return_2016 + fund_return_2017
 + fund_return_2018 + fund_return_2019 + fund_return_2020) as Mutual_fund_return,fund_family from etfs group by fund_family;
 
-- Pie Chart 
SELECT investment_type,count(investment_type),
CONCAT(ROUND((COUNT(investment_type) * 100.0) / (SELECT COUNT(*) FROM etfs), 2), '%') AS investment_type_percentage
FROM etfs GROUP BY investment_type;

SELECT investment_type,concat(count(investment_type)/1000,'k'),
CONCAT(ROUND((COUNT(investment_type) * 100.0) / (SELECT COUNT(*) FROM etfs), 2), '%') AS investment_type_percentage
FROM mutualfunds GROUP BY investment_type;

select total_net_assets, sum(fund_annual_report_net_expense_ratio),sum(fund_return_5years),sum(total_net_assets) from etfs group by total_net_assets;


select total_net_assets, sum(fund_annual_report_net_expense_ratio),sum(fund_return_5years),sum(total_net_assets) from mutualfunds group by total_net_assets;

SELECT investment_type,count(investment_type),Year(inception_date) Year
FROM etfs where Year(inception_date)>2009 GROUP BY investment_type,Year(inception_date) order by Year(inception_date);

SELECT investment_type,count(investment_type),Year(inception_date) Year
FROM mutualfunds where Year(inception_date)>2009 GROUP BY investment_type,Year(inception_date) order by Year(inception_date);


-- Dashboard -3
select avg(week52_high_change),avg(week52_high_low_change),avg(week52_low_change),avg(fund_beta_3years) from etfs;

select avg(week52_high_change),avg(week52_high_low_change),avg(week52_low_change),avg(fund_beta_3years) from mutualfunds;

select Year(inception_date),fund_category,sum(day200_moving_average) from mutualfunds 
group by Year(inception_date),fund_category order by Year(inception_date);

select Year(inception_date),fund_category,sum(day200_moving_average) from etfs 
group by Year(inception_date),fund_category order by Year(inception_date);

select concat(sum(fund_return_1month)/1000,'k'),concat(sum(fund_return_1year)/1000,'k'),concat(sum(fund_return_3months)/1000,'k'),
concat(sum(fund_return_3years)/1000,'k'),concat(sum(fund_return_5years)/1000,'k') from mutualfunds;


select sum(fund_return_1month),sum(fund_return_1year),sum(fund_return_3months),
sum(fund_return_3years),sum(fund_return_5years) from etfs;