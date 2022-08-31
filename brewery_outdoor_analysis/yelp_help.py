import pandas as pd
from yelpapi import YelpAPI

from config import api_key

class YelpBusinessResults:

    default_api_key = api_key

    def __init__(
        self, 
        search_term, 
        location, 
        business_types, 
        key=None
        ):
        self.search_term = search_term
        self.location = location
        self.business_types = business_types
        if key is None:
            key = self.default_api_key
        self.key = key

        self.output_list = []

        # call the `_get_businesses()` method to fill in the above `output_list`
        self._get_businesses()

    def _get_businesses(self):
        
        limit = 50

        with YelpAPI(self.key) as yelp_api:
            
            # grab the first page of results, also use this to get the total number of results
            city_data = yelp_api.search_query(
                term=self.search_term,
                location=self.location, 
                limit=limit # look at adding the business_types to this initial request
                )

            num_results = city_data['total']
            pages = (num_results // limit) + 1

            self._parse_response(city_data['businesses'])

            # pull the remaining pages of data, not past 1000 results (this is the Yelp-imposed max number of results)
            for n in range(1, pages):
                offset = limit * n
                if offset < 1000:
                    city_data = yelp_api.search_query(
                        term=self.search_term,
                        location=self.location, 
                        limit=limit,
                        offset=offset
                        )
                    self._parse_response(city_data['businesses'])
                    
    def _parse_response(self, businesses_list):
        for i,c in enumerate(businesses_list):
            try:
                country = businesses_list[i]['location']['country']
                business_type = businesses_list[i]['categories'][0]['alias']
                original_search_city = self.location.split(',')[0]

                if country == 'US' and business_type in self.business_types:
                    yelp_id = businesses_list[i]['id']
                    name = businesses_list[i]['name']
                    lat = businesses_list[i]['coordinates']['latitude']
                    long = businesses_list[i]['coordinates']['longitude']
                    yelp_city = businesses_list[i]['location']['city']
                    is_closed = businesses_list[i]['is_closed']
                    rating = businesses_list[i]['rating']
                    zip_code = businesses_list[i]['location']['zip_code']
                    state = businesses_list[i]['location']['state']
                    
                    response_data = {
                        'yelp_id':yelp_id,
                        'name':name, 
                        'lat':lat, 
                        'lng': long, 
                        'original_search_city':original_search_city,
                        'yelp_city':yelp_city, 
                        'business`_type':business_type, 
                        'is_closed':is_closed, 
                        'rating':rating, 
                        'zip_code':zip_code, 
                        'state':state
                        }
                    self.output_list.append(response_data)
            except IndexError:
                print(i, c)