# Brewery_Outdoor_Analysis
## Topic

Local craft breweries and their correlation to outdoor retailers.

## Purpose

Our team believed there was potential for retail growth based on locations in the nearby vicinity of breweries. The increasing popularity of both breweries and outdoor clothing establishments may lead to data that could assist future development.

## Possible questions to answer

- Is there a strong current correlation between breweries and outdoor clothing stores?
- What is the potential market opportunity for clothing store expansion based on brewery locations?
- What is the potential market opportunity for brewery expansion based on outdoor clothing locations?

## Machine Learning Model

*  Data is preprocessed and cleaned by removing unneeded columns, merging zip code/cities datasets, and limiting dataset to the top 1,000 most populated cities.
*  To obtain the best possible predictive results, preliminary features should be explored, engineered, and carefully selected. Possible preliminary features for this model could be average income per zipcode, income per capita, and clothing stores per brewery count.
*  The importance of correlation between breweries and outdoor clothing stores will drive which features will be engineered and selected, ultimately answering the hypothesis.
*  Data was split into training and testing sets using train_test_split and a random state of 24. This will assist in evaluating the performance of the model in relation to the dataset.
*  A linear regression model was chosen to best illustrate correlation between brewery location and outdoor clothing store location. Is there a strong relationship between the two? The benefits of using a linear regression is readability and abiility to answer basic questions. Limitations of a linear regression model will be sensitivity to outliers. 

[Brewery-Outdoor Analysis-Machine Learning Model](https://github.com/Bransblu/Brewery_Outdoor_Analysis/blob/e16a03d1e5d09fd6af2d59606a65604d9586c63f/brewery_outdoor_analysis/machine_learning_mockup.ipynb)

<!--Significant correlation
## Conclusions

- The amount of breweries and outdoor clothing stores in a location have significant impact on each other. Locations with a high count of breweries are good opportunities .

### Future hypotheses

With a significant correlation of breweries and outdoor stores, there are possible other exploratory hypotheses to add value to the analysis. 
- Any establishment serving alcohol (not solely breweries) will have a strong correlation to outdoor stores leading to improved market opportunity.
- Hybrid brewery and outdoor clothing stores would be a profitable business expansion opportunity.

-->


## Conclusions


- The amount of breweries and outdoor clothing stores in a location have little impact on each other. While customers may like both shops, there is not a strong correlation to the two variables based on the machine learning model. 
- Cities similar to Portland, Oregon may be outliers and simply have an above average amount of both breweries and outdoor stores, independent of each other. We observed that regionally there is a correlation between the two variables and specific regions.
- The amount of breweries and outdoor clothing stores in a location have little impact on each other. While customers may like both shops, there is not a strong correlation to the two
variables. 
- Cities similar to Portland, Oregon may be outliers and simply have an above average amount of both breweries and outdoor stores, independent of each other. There is also the possibility that the original hypothesis is biased towards being a Pacific Northwest phenomemom. 

### Future hypotheses

With the low correlation of breweries and outdoor stores, the team recommends looking into possible other hypotheses.
- Regionally there may a stronger correlation between breweries and outdoor stores.
- Areas with higher levels of disposable income have greater opportunities for outdoor clothing stores.
- Areas with high foot traffic have more outdoor stores and/or breweries.
- Areas with both higher income and lower real estate costs have more breweries or outdoor clothing stores.
<!-- Breweries with numerous non-alcoholic options positively impact outdoor clothing stores in "dry counties".-->

## Data Sources

#### **Yelp**

Using the [`yelpapi`](https://github.com/lanl/yelpapi) python package, we queried business information from the Yelp [`business_search`](https://www.yelp.com/developers/documentation/v3/business_search) endpoint. 

#### **IRS Data**
IRS SOI Tax Stats - Individual Income Tax Statistics from 2019, available here: 
https://www.irs.gov/statistics/soi-tax-stats-individual-income-tax-statistics-2019-zip-code-data-soi
 
CSV of data directly accessed here: 
https://www.irs.gov/pub/irs-soi/19zpallagi.csv

#### **Zip Code Dataset**
Includes population data, used to create our top 1000 cities table.
https://www.unitedstateszipcodes.org/zip-code-database/

## Collaborators

- Brandon Clark
- Brandon Driver
- Tim Nilsen
- Warren Pavlat
