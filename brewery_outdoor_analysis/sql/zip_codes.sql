/*
source: https://www.unitedstateszipcodes.org/zip-code-database/
table populationed with file: '../../Resources/zip_code_database.csv'
*/

CREATE TABLE zip_code_database_raw (
	zip INTEGER PRIMARY KEY, 
	type TEXT, 
	decommissioned INTEGER, 
	primary_city TEXT, 
	acceptable_cities TEXT, 
	unacceptable_cities TEXT, 
	state TEXT, 
	county TEXT, 
	timezone TEXT, 
	area_codes TEXT, 
	world_region TEXT, 
	country TEXT, 
	latitude DECIMAL, 
	longitude DECIMAL, 
	irs_estimated_population INTEGER
)
;

/*
- clean up unneeded data: 
  - exclude decommissioned zip codes, 
  - only keep standard zip codes, 
  - only keep common, 5-digit zip codes
*/
CREATE TABLE zip_codes_cleaned AS (
    SELECT 
		 zip as zip_code,
		 primary_city as city, 
		 state,
		 county,
	  	 latitude, 
		 longitude, 
		 irs_estimated_population
	FROM zip_code_database_raw
	WHERE decommissioned = 0
	  AND type = 'STANDARD'
	  AND LENGTH(zip::TEXT) = 5
)
;