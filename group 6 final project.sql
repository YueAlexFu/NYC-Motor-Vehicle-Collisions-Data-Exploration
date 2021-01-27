-- 1. List the top 10 states by number of complaints (descending order)
select count(*) as Num, State 
from complaints
group by State
order by Num Desc
limit 10;

-- 2. List the top 10 states by number of complaints per capita (descending order)
select A.State, Num,`Population-in-2015`, Num/`Population-in-2015` as 'Complaints per capita'
from
(select count(*) as Num, State
from complaints
group by State) as A
join states on states.Abbreviation = A.State
order by `Complaints per capita` desc
limit 10;





-- 3. For the most populous three states, list the top 5 companies most complained about in each state.
-- method 1
CREATE VIEW E AS
SELECT complaints.state, company, 
count(DISTINCT complaintid) AS 'number of complaints'
FROM complaints
JOIN 
(SELECT states.state, Abbreviation
FROM states
ORDER BY `Population-in-2015` desc
limit 3) AS B ON B.abbreviation=complaints.state
group by state, company;

SELECT rn, state, company, `number of complaints`
FROM 
(SELECT *, row_number() 
OVER 
(partition by state 
order by `number of complaints` desc) rn from E) AS V 
WHERE rn<=5;


-- method 2
SELECT *
FROM
(
	SELECT *,
    @State_RANK := IF(@CURRENT_State = State, 
						@State_RANK+1, 
						1
					) AS State_RANK,
    @CURRENT_State := State
    FROM (SELECT State, Company, count(complaintid)
		from
			(SELECT Abbreviation, `Population-in-2015`
			from states
			order by `Population-in-2015`desc
			limit 3) as S
	join complaints as C on C.State=S.Abbreviation
	group by State, Company
	order by State, count(complaintid) desc
    ) AS R
) RANKED
WHERE State_RANK <= 5;
-- reference: https://www.databasejournal.com/features/mysql/selecting-the-top-n-results-by-group-in-mysql.html


-- 4. List for all states, the income per capita plus the number of complaints for the state
Select T.State, 
`Total Income per State`,
`Population-in-2015`,
`Total Income per State`/`Population-in-2015` as 'Income per capita', 
count(complaintid) as 'complaint #'
from
	(
    Select D.State, sum(`Total Income`) as 'Total Income per State', `Population-in-2015`
	from demographics as D
	join states on states.Abbreviation=D.State
	group by D.State
    ) AS T
join complaints on complaints.State=T.State
group by T.State; 

 

-- 5. List the top 10 companies appearing in the complaints table by count of complaints in the top 3 most populous states.
select Company, count(complaintid) as '# complaints', C.State
from
	(
    SELECT Abbreviation as State, `Population-in-2015`
	from states
	order by `Population-in-2015`desc
	limit 3
    ) as P
join complaints as C on C.State=P.State
group by Company
order by count(complaintid) desc
limit 10;


