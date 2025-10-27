select * from stand_user;

-- Q1
select stand_name, upper(stand_name) "STAND_UPPER", lower(stand_name) "STAND_LOWER", INITCAP(stand_name) "STAND_TITLE" from stand_user;

-- Q2
select user_name, catchphrase, length(catchphrase) "PHRASE_LENGTH" from stand_user order by length(catchphrase) desc;

-- Q3
select stand_name, substr(stand_name, 1, 8) "stand_short" from stand_user;

-- Q4
select stand_name, instr(stand_name, 'World') from stand_user;

-- Q5
select user_name, lpad(power, 8, '*') from stand_user;

-- Q6
select user_name, power, round(power,-2) "ROUND_POWER", trunc(power,-2) "TRUNCATED_POWER", mod(power,300) "POWER_MOD_300" from stand_user;

-- Q7
select user_name, NVL(to_char(PRECISION),'Unknown') "precision_status" from stand_user;

-- Q8
select user_name, debut_date, Next_Day(add_months(debut_date,6),'MONDAY') "traing_review" from stand_user;

-- Q9
select user_name, round(months_between(current_date,debut_date),0) "Months_since_debut" from stand_user;

-- Q10
select user_name, stand_name, concat(concat(concat(concat('"',user_name), concat(concat('" wields "',stand_name), concat('" with power ',power))), ', but dreams of '),power*3) "Dream_statement" from stand_user;

-- Q11
select INITCAP(stand_name) from stand_user where INITCAP(stand_name) like '%World%';

-- Q12
select user_name, stand_name, soundex(stand_name) from stand_user order by soundex(stand_name);