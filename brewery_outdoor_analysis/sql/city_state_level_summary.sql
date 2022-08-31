with breweries_cleaned as (
    SELECT DISTINCT 
         yelp_id,
	     name, 
         original_search_city,
	     yelp_city,
	     rating,
	     state
    FROM breweries
    WHERE is_closed = FALSE
),

outdoor_stores_cleaned as (
    SELECT DISTINCT 
         yelp_id,
	     name, 
         original_search_city,
	     yelp_city,
	     rating,
	     state
    FROM outdoor 
    WHERE is_closed = FALSE
),

demographic_summary as (
    SELECT 
       zip_codes_cleaned.city, 
       income.state, 
	     AVG(income.total_income)::INTEGER as mean_income,
	     MIN(income.total_income)::INTEGER as min_income,
	     MAX(income.total_income)::INTEGER as max_income, 
	     PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY income.total_income)::INTEGER as median_income,
	     PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY income.total_income)::INTEGER as first_quartile_income,
	     PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY income.total_income)::INTEGER as third_quartile_income
	FROM zip_codes_cleaned 
	JOIN income_data income
		ON income.zip_code = zip_codes_cleaned.zip_code
	GROUP BY 1,2
),

brewery_summary as (
    SELECT 
         original_search_city,
         state,
         SUM(CASE WHEN rating = 1 THEN 1 ELSE 0 END) as num_one_star_reviews,
         SUM(CASE WHEN rating = 5 THEN 1 ELSE 0 END) as num_five_star_reviews,
         AVG(rating) as mean_rating,
         COUNT(*) as num_breweries
    FROM breweries_cleaned
	GROUP BY 1,2
),

outdoor_stores_summary as (
    SELECT 
         original_search_city,
         state,
         SUM(CASE WHEN rating = 1 THEN 1 ELSE 0 END) as num_one_star_reviews,
         SUM(CASE WHEN rating = 5 THEN 1 ELSE 0 END) as num_five_star_reviews,
         AVG(rating) as mean_rating,
         COUNT(*) as num_outdoor_stores
    FROM outdoor_stores_cleaned   
	GROUP BY 1,2
),

joined_summary as (
    SELECT 
         COALESCE(
          brewery_summary.original_search_city,
          outdoor_stores_summary.original_search_city,
          demographic_summary.city
          ) as city,
         COALESCE(
          brewery_summary.state,
          outdoor_stores_summary.state,
          demographic_summary.state
          ) as state,
         demographic_summary.mean_income,
         demographic_summary.min_income,
         demographic_summary.max_income,
         demographic_summary.median_income,
         demographic_summary.first_quartile_income,
         demographic_summary.third_quartile_income,
         COALESCE(brewery_summary.num_breweries, 0) as num_breweries,
         COALESCE(brewery_summary.num_one_star_reviews, 0) as breweries_num_one_star_reviews,
         COALESCE(brewery_summary.num_five_star_reviews, 0) as breweries_num_five_star_reviews,
         COALESCE(brewery_summary.mean_rating, 0) as breweries_mean_rating,
         COALESCE(outdoor_stores_summary.num_outdoor_stores, 0) as num_outdoor_stores,
		     COALESCE(outdoor_stores_summary.num_one_star_reviews, 0) as outdoor_num_one_star_reviews,
         COALESCE(outdoor_stores_summary.num_five_star_reviews, 0) as outdoor_num_five_star_reviews,
         COALESCE(outdoor_stores_summary.mean_rating, 0) as outdoor_mean_rating
    FROM demographic_summary
    LEFT JOIN brewery_summary 
        ON (
          brewery_summary.original_search_city = demographic_summary.city 
      AND brewery_summary.state = demographic_summary.state
      )
    LEFT JOIN outdoor_stores_summary
        ON (
          outdoor_stores_summary.original_search_city = demographic_summary.city        
      AND outdoor_stores_summary.state = demographic_summary.state
		)
),

final as (  -- filter for top US cities
    SELECT 
         joined_summary.*, 
		 top_us_cities.population::BIGINT,
         top_us_cities.lat,
         top_us_cities.lon,
		 NOW() as ts_updated
	FROM joined_summary
	JOIN top_us_cities
		ON (
      top_us_cities.city = joined_summary.city
	AND top_us_cities.state = joined_summary.state
  )
)

SELECT *
FROM final