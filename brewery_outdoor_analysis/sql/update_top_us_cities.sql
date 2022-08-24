INSERT INTO top_us_cities (
	SELECT 
		 city,
		 state,
		 SUM(irs_estimated_population) as population,
		 AVG(latitude) as lat,
		 AVG(longitude) as lon
	FROM zip_codes_cleaned
	GROUP BY 1,2
	ORDER BY population DESC
	LIMIT 1000
)