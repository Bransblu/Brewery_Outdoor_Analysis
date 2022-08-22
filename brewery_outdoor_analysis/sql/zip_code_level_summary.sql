/*
Note: this sql file is available for use if needeed. That said, at the time of this writing (2022-08-01), tables have not been created. 
*/

with breweries_cleaned as (
    SELECT DISTINCT ON (yelp_id) 
         yelp_id,
	     name, 
         original_search_city,
	     yelp_city,
	     rating,
	     zip_code,
	     state
    FROM breweries
    WHERE is_closed = FALSE
      AND business_type IN (
        'brewpubs', 'breweries'
        )
),

outdoor_stores_cleaned as (
    SELECT DISTINCT ON (yelp_id) 
         yelp_id,
	     name, 
         original_search_city,
	     yelp_city,
	     rating,
	     zip_code,
	     state
    FROM outdoor 
    WHERE is_closed = FALSE
      AND business_type IN (
        'atvrentals', 'sportswear', 'climbing', 'surfshop', 'outdoorgear', 
        'sportgoods', 'skishops', 'menscloth', 'boating', 'fishing', 
        'militarysurplus', 'paddleboarding', 'rafting', 'rvrental', 'huntingfishingsupplies', 
        'rock_climbing', 'bikerentals', 'tennis', 'womenscloth', 'fitnessequipment',
        'shoes', 'bikes', 'guns_and_ammo', 'skateshops', 'archery', 
        'golf'
      )
),

demographic_summary as (
    SELECT 
	     zip_codes_cleaned.city, income.state, 
	     zip_codes_cleaned.zip_code, 
	     AVG(income.total_income)::INTEGER as mean_income,
	     MIN(income.total_income)::INTEGER as min_income,
	     MAX(income.total_income)::INTEGER as max_income, 
	     PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY income.total_income)::INTEGER as median_income,
	     PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY income.total_income)::INTEGER as    first_quartile_income,
	     PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY income.total_income)::INTEGER as third_quartile_income
FROM zip_codes_cleaned 
JOIN income_data income
	ON income.zip_code = zip_codes_cleaned.zip_code
GROUP BY 1,2,3	
),

brewery_summary as (
    SELECT 
         original_search_city,
         state,
         zip_code,
         COUNT(*) as num_breweries
    FROM breweries_cleaned
	GROUP BY 1,2,3
),

outdoor_stores_summary as (
    SELECT 
         original_search_city,
         state,
         zip_code,
         COUNT(*) as num_outdoor_stores
    FROM outdoor_stores_cleaned   
	GROUP BY 1,2,3
),

joined_summary as (
    SELECT 
		 COALESCE(demographic_summary.city,
				  brewery_summary.original_search_city,
				  outdoor_stores_summary.original_search_city				  
		 ) as city,
	
		 COALESCE(demographic_summary.state,
				  brewery_summary.state,
				  outdoor_stores_summary.state				  
		 ) as state,
         demographic_summary.zip_code,
         demographic_summary.mean_income,
         demographic_summary.min_income,
         demographic_summary.max_income,
         demographic_summary.median_income,
         demographic_summary.first_quartile_income,
         demographic_summary.third_quartile_income,
         COALESCE(brewery_summary.num_breweries, 0) as num_breweries,
         COALESCE(outdoor_stores_summary.num_outdoor_stores, 0) as num_outdoor_stores
    FROM demographic_summary
    LEFT JOIN brewery_summary 
        ON brewery_summary.zip_code = demographic_summary.zip_code 
    LEFT JOIN outdoor_stores_summary
        ON outdoor_stores_summary.zip_code = demographic_summary.zip_code        
),

final as ( -- filter for top US cities
	SELECT joined_summary.*
	FROM joined_summary
	JOIN top_us_cities
		ON (
			top_us_cities.city = joined_summary.city
	    AND top_us_cities.abbr = joined_summary.state
		)
)

SELECT *
FROM final