-- PLEASE READ THIS BEFORE RUNNING THE EXERCISE

--  IMPORTANT: This SQL file may crash due to two common issues: comments and missing semicolons.

--  Suggestions:
-- 1) Always end each SQL query with a semicolon `;`
-- 2) Ensure comments are well-formed:
--    - Use `--` for single-line comments only
--    - Avoid inline comments after queries
--    - Do not use `/* */` multi-line comments, as they may break execution

-- -----------------------------------------------
-- queries.sql
-- Complete each mission by writing your SQL query
-- directly below the corresponding instruction
-- -----------------------------------------------

SELECT * FROM regions;
SELECT * FROM species;
SELECT * FROM climate;
SELECT * FROM observations;


-- MISSION 1
-- Your query here;
select * from observations 
 LIMIT 10;

-- MISSION 2
-- Your query here;
SELECT distinct region_id from observations;



-- MISSION 3
-- Your query here;
select  count(distinct species_id) as total_species from observations;


-- MISSION 4
-- Your query here;
select * from Observations
 where region_id=2;


-- MISSION 5
-- Your query here;
select * from observations 
where observation_date='1998-08-08';


-- MISSION 6
-- Your query here;
select  region_id,count(*) as observation_count 
from observations
group by region_id;
order by observation_count DESC
LIMIT 1;




-- MISSION 7
-- Your query here;
select species_id, count(*) as most_frequent_species
from observations
group by species_id
order by most_frequent_species DESC
LIMIT 5;

SELECT species_id, COUNT(*) AS total_records
FROM observations
GROUP BY species_id
ORDER BY total_records DESC
LIMIT 5;


-- MISSION 8
-- Your query here;
select species_id, count(*) as observation_count
from observations
group by species_id
having observation_count <5;


-- MISSION 9
-- Your query here;
select observer, count(*) as observed_total
from observations
group by observer
order by observed_total DESC;



-- MISSION 10
-- Your query here;
select observations.id,regions.name as region_name
 from observations, regions
 where observations.region_id = regions.id;


-- MISSION 11
-- Your query here;
select observations.id, species.scientific_name
from observations,species
where observations.species_id =  species.id


-- MISSION 12
-- Your query here;
select regions.name as region, species.scientific_name as speciesName, count(*) as total_observed
from observations
JOIN species ON observations.species_id = species.id
JOIN regions ON observations.region_id = regions.id
group by region, speciesName
order by region, total_observed,region DESC;


-- MISSION 13
-- Your query here;
INSERT INTO observations
(species_id, region_id, observer, observation_date, "count")
   VALUES (1, 3, 'TestOb', '1994-11-01', 0);
COMMIT;

select * from observations order by id desc limit 10;


-- MISSION 14
-- Your query here;
UPDATE species
set scientific_name = 'parakeet para'
where scientific_name = 'Lalage tricolor'--id = 3;
commit;
select * from species where scientific_name = 'parakeet para';


-- MISSION 15
--Your query here;
DELETE FROM observations
WHERE id = 1;

commit;

select * from observations where id = 1;
