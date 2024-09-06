
--#Andhra pradesh Election 2024

select *from election2024.dbo.Apelection2024$

select *from election2024.dbo.Odisha_election_2024$
----.Data cleaning

--1.check duplicate values
select
    Constituency, 
    count(*) as DuplicateCount
from
    election2024.dbo.Apelection2024$
group by
    Constituency
having
    count(*) > 1;


--2.converting uppercase into eachword uppercase and remainng lower case and update 

	update election2024.dbo.Apelection2024$
set 
    LeadingCandidate = concat(upper(LEFT(LeadingCandidate, 1)), lower(substring(LeadingCandidate, 2, len(LeadingCandidate)))),
    TrailingCandidate = concat(upper(LEFT(TrailingCandidate, 1)), lower(substring(TrailingCandidate, 2, len(TrailingCandidate))));



select distinct (leadingparty) as parties
from election2024.dbo.apelection2024$;

---#### Data exploration


-- 1. Select leading party and candidate where candidate matches specific names
select 
    [leadingparty] as parties,
    [leadingcandidate] as party_leaders
from 
    election2024.dbo.apelection2024$
where 
    [leadingcandidate] in ('chandrababu naidu nara', 'konidala pawan kalyan', 'ys jagan mohan reddy');

-- 2. Count the number of constituencies
select count(constituency)
from election2024.dbo.apelection2024$;

-- 3. Count the number of constituencies where the leading party is 'Telugu Desam'
select count(constituency)
from election2024.dbo.apelection2024$
where [leadingparty] = 'telugu desam';

-- 4. Count the number of constituencies for each leading party, ordered by count
select [leadingparty], count(constituency) as constituencycount
from election2024.dbo.apelection2024$
group by [leadingparty]
order by constituencycount desc;

-- 5. Count the number of constituencies for each trailing party, ordered by count
select [trailingparty], count(constituency) as constituencycount
from election2024.dbo.apelection2024$
group by [trailingparty]
order by constituencycount desc;

-- 6. Select constituency, trailing party, and trailing candidate
select constituency, trailingparty, trailingcandidate
from election2024.dbo.apelection2024$;

-- 7. Select constituency, trailing party, trailing candidate, and margin where trailing party is 'Telugu Desam'
select constituency, trailingparty, trailingcandidate, margin
from election2024.dbo.apelection2024$
where [trailingparty] = 'telugu desam';

-- 8. Select top 5 leading party, leading candidate, and margin, ordered by margin descending
select top 5 leadingparty, leadingcandidate, margin
from election2024.dbo.apelection2024$
order by margin desc;

-- 9. Select top 5 constituency, leading party, and margin, ordered by margin descending
select top 5 constituency, leadingparty, margin
from election2024.dbo.apelection2024$
order by margin desc;

-- 10. Select top 5 constituency, leading candidate, and margin, ordered by margin descending
select top 5 constituency, leadingcandidate, margin
from election2024.dbo.apelection2024$
order by margin desc;


------------[odisha Election 2024]------

select *from election2024.dbo.Odisha_election_2024$


----[Data cleaning]-------

--1.check duplicate values
select
    Constituency, 
    count(*) as DuplicateCount
from
    election2024.dbo.odisha_election_2024$
group by
    Constituency
having
    count(*) > 1;


--2.converting uppercase into eachword uppercase and remainng lower case and update 

	update election2024.dbo.odisha_election_2024$
set 
    LeadingCandidate = concat(upper(LEFT(LeadingCandidate, 1)), lower(substring(LeadingCandidate, 2, len(LeadingCandidate)))),
    TrailingCandidate = concat(upper(LEFT(TrailingCandidate, 1)), lower(substring(TrailingCandidate, 2, len(TrailingCandidate))));




-- 1. Select leading party and candidate where candidate matches specific names
select 
    [leadingparty] as parties,
    [leadingcandidate] as party_leaders
from 
    election2024.dbo.odisha_election_2024$
where 
    [leadingcandidate] in ('chandrababu naidu nara', 'konidala pawan kalyan', 'ys jagan mohan reddy');

-- 2. Count the number of constituencies
select count(constituency)
from election2024.dbo.odisha_election_2024$;

-- 3. Count the number of constituencies where the leading party is 'Telugu Desam'
select count(constituency) as seats_by_bjd
from election2024.dbo.odisha_election_2024$
where [leadingparty] = 'Biju Janata Dal';

-- 4. Count the number of constituencies for each leading party, ordered by count
select [leadingparty], count(constituency) as constituencycount
from election2024.dbo.odisha_election_2024$
group by [leadingparty]
order by constituencycount desc;

-- 5. Count the number of constituencies for each trailing party, ordered by count
select [trailingparty], count(constituency) as constituencycount
from election2024.dbo.odisha_election_2024$
group by [trailingparty]
order by constituencycount desc;

-- 6. Select constituency, trailing party, and trailing candidate
select constituency, trailingparty, trailingcandidate
from election2024.dbo.odisha_election_2024$;

-- 7. Select constituency, trailing party, trailing candidate, and margin where trailing party is 'Telugu Desam'
select constituency, trailingparty, trailingcandidate, margin
from election2024.dbo.odisha_election_2024$
where [trailingparty] = 'Biju Janata Dal';

-- 8. Select top 5 leading party, leading candidate, and margin, ordered by margin descending
select top 5 leadingparty, leadingcandidate, margin
from election2024.dbo.odisha_election_2024$
order by margin desc;

-- 9. Select top 5 constituency, leading party, and margin, ordered by margin descending
select top 5 constituency, leadingparty, margin
from election2024.dbo.odisha_election_2024$
order by margin desc;

-- 10. Select top 5 constituency, leading candidate, and margin, ordered by margin descending
select top 5 constituency, leadingcandidate, margin
from election2024.dbo.odisha_election_2024$
order by margin desc;
