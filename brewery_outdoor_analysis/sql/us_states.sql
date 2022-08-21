/* 
create table with US states and their corresponding abbreviations for more easily mapping between datasets
sourced: https://www.faa.gov/air_traffic/publications/atpubs/cnt_html/appendix_a.html
*/
CREATE TABLE states (
    state TEXT,
    abbr TEXT 
)
;

INSERT INTO states (state, abbr)
VALUES 
    ('Alabama', 'AL'),
    ('Kentucky', 'KY'),
    ('Ohio', 'OH'),
    ('Alaska', 'AK'),
    ('Louisiana', 'LA'),
    ('Oklahoma', 'OK'),
    ('Arizona', 'AZ'),
    ('Maine', 'ME'),
    ('Oregon', 'OR'),
    ('Arkansas', 'AR'),
    ('Maryland', 'MD'),
    ('Pennsylvania', 'PA'),
    ('American Samoa', 'AS'),
    ('Massachusetts','MA' ),
    ('Puerto Rico', 'PR'),
    ('California', 'CA'),
    ('Michigan', 'MI'),
    ('Rhode Island', 'RI'),
    ('Colorado', 'CO'),
    ('Minnesota', 'MN'),
    ('South Carolina', 'SC'),
    ('Connecticut', 'CT'),
    ('Mississippi', 'MS'),
    ('South Dakota', 'SD'),
    ('Delaware', 'DE'),
    ('Missouri', 'MO'),
    ('Tennessee', 'TN'),
    ('District of Columbia', 'DC'),
    ('Montana', 'MT'),
    ('Texas', 'TX'),
    ('Florida', 'FL'),
    ('Nebraska', 'NE'),
    ('Trust Territories', 'TT'),
    ('Georgia', 'GA'),
    ('Nevada', 'NV'),
    ('Utah', 'UT'),
    ('Guam', 'GU'),
    ('New Hampshire', 'NH'),
    ('Vermont', 'VT'),
    ('Hawaii', 'HI'),
    ('New Jersey', 'NJ'),
    ('Virginia', 'VA'),
    ('Idaho', 'ID'),
    ('New Mexico', 'NM'),
    ('Virgin Islands', 'VI'),
    ('Illinois', 'IL'),
    ('New York', 'NY'),
    ('Washington', 'WA'),
    ('Indiana', 'IN'),
    ('North Carolina', 'NC'),
    ('West Virginia', 'WV'),
    ('Iowa', 'IA'),
    ('North Dakota', 'ND'),
    ('Wisconsin', 'WI'),
    ('Kansas', 'KS'),
    ('Northern Mariana Islands', 'CM'),
    ('Wyoming', 'WY')
;

/*
create table for top_us_cities with state abbreviation
*/
CREATE TABLE temp_cities AS (
	SELECT 
	 	city, state, abbr, population, lat, lon
	FROM top_us_cities
	JOIN states ON states.state = top_us_cities.states
)
;

/*
empty original top_us_cities, add new abbr column, rename states column to state, then insert values into emptied table. 
*/
TRUNCATE TABLE top_us_cities
;

ALTER TABLE top_us_cities 
ADD COLUMN abbr TEXT
;

ALTER TABLE top_us_cities
RENAME COLUMN states to state
;

INSERT INTO top_us_cities (city, state, abbr, population, lat, lon)
SELECT *
FROM temp_cities
;

/*
drop the temporary table
*/
DROP TABLE temp_cities
;