select * from stand_user;

-- Q1
select avg(power) "avg_power", max(power) "Max_power", min(power) "min_power" from stand_user;

-- Q2
select count(distinct precision) "known_precision", count(distinct user_name) from stand_user; 

-- Q3
select round(stddev(power),3) "stddv_power", round(variance(power),3) "variance_power" from stand_user;

-- Q4
select precision, avg(power) "avg_power" from stand_user where precision is not null group by precision;

-- Q5
select precision, avg(power) "avg_power" from stand_user where precision is not null group by precision having avg(power)>80;

-- Q6
select user_name, stand_name, power-(select avg(power) from stand_user) "diff_from_avg" from stand_user;

-- Q7
select round(avg(power), 2) "Rounded_avg_power" from stand_user;

-- Q8
select precision, sum(power) "Total_Power" from stand_user group by rollup(precision);

-- Q9
SELECT EXTRACT(YEAR FROM debut_date) AS debut_year,
       precision,
       SUM(power) AS total_power
FROM stand_user
GROUP BY CUBE(EXTRACT(YEAR FROM debut_date), precision)
ORDER BY debut_year, precision;