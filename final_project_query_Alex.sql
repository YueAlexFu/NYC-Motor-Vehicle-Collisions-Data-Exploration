-- load data into exist table
SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\allcomplaints.csv'
INTO TABLE consumer_complaints
FIELDS TERMINATED by ';'
LINES TERMINATED by '\n';

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\demographics.csv'
INTO TABLE demographic
FIELDS TERMINATED by ';'
LINES TERMINATED by '\n';


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\states.csv'
INTO TABLE state_populations
FIELDS TERMINATED by ';'
LINES TERMINATED by '\n';

-- set foreign keys
SET FOREIGN_KEY_CHECKS = 0;
SET FOREIGN_KEY_CHECKS = 1;

SELECT * FROM consumer_complaints;
SELECT * FROM demographic;
SELECT * FROM state_populations;

-- delete the null state in consumer_complaints
delete
from consumer_complaints
where State = '';

-- 1. List the top 10 states by number of complaints (descending order)
select count(*) as Num, State 
from consumer_complaints
group by State
order by Num Desc
limit 10;

-- 2. List the top 10 states by number of complaints per capita (descending order)
-- A.State, Num, Num/Population2015 as 'Complaints per capita'
select A.State, Num, Num/`Population2015` as 'Complaints per capita'
from
(select count(*) as Num, State
from consumer_complaints
group by State) as A
join state_populations on state_populations.StateAbbreviation = A.State
order by `Complaints per capita` desc
limit 10;






-- 3. For the most populous three states, list the top 5 companies most complained about in each state.

-- 4. List for all states, the income per capita plus the number of complaints for the state

-- 5. List the top 10 companies appearing in the complaints table by count of complaints in the top 3 most populous states.