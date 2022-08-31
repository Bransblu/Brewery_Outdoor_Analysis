import pandas as pd 
from database_connection import ENGINE
from update_city_summary import update_city_summary
from yelp_help import YelpBusinessResults

top_us_cities_query = '''
SELECT *
FROM top_us_cities
'''
cities = pd.read_sql(
    top_us_cities_query,
    con=ENGINE
)

# cities = cities.sample(10) # remove this after testing
cities_list = cities['city'] + ', ' + cities['state']

def assemble_results_to_dataframe(
    search_term,
    business_types,
    list_of_cities=cities_list
    ):
    
    # instantiate an empty list to hold the results
    output = []

    for city in list_of_cities:
        print(f'Current city is: {city}.\n\n')
        try:
            city_results = YelpBusinessResults(
                search_term=search_term,
                location=city,
                business_types=business_types
                )
            output.append(city_results.output_list)
        except Exception as e:
            print(e)
            print(f'An exception has occurred for {city}.')
    
    # reduce the dimensionality of the output so that it can be turned into a DataFrame
    output_flat = [business for city_location in output for business in city_location]
    output_df = pd.DataFrame(output_flat)

    # ensure we don't have any blank zip codes, ensure we treat zip codes as integers
    output_df = output_df.loc[output_df['zip_code'] != '']
    output_df['zip_code'] = output_df['zip_code'].astype('int')

    return output_df

if __name__ == '__main__':
    brewery_search_term = 'Breweries'
    brewery_business_types = ['breweries', 'brewpubs']

    breweries_df = assemble_results_to_dataframe(
        search_term=brewery_search_term,
        business_types=brewery_business_types
        )

    outdoor_search_term = 'Outdoor Gear'
    outdoor_business_types = ['outdoorgear', 'sportswear', 'sportgoods']

    outdoor_df = assemble_results_to_dataframe(
        search_term=outdoor_search_term,
        business_types=outdoor_business_types
        )

    breweries_df.to_sql(
        'breweries', 
        con=ENGINE, 
        if_exists='replace',
        index=False
        )

    outdoor_df.to_sql(
        'outdoor', 
        con=ENGINE, 
        if_exists='replace',
        index=False
        )
    
    # update the city_summary table
    update_city_summary()