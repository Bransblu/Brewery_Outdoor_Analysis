# Brewery_Outdoor_Analysis
### Topic

Local craft breweries and their correlation to prominent outdoor clothing brands.
### Purpose 

Our team believes there is potential for retail growth based on locations in the nearby vicinity of breweries. The increasing popularity of both breweries and outdoor clothing establishments can lead to data that could assist future development.

### Possible questions to answer

- Is there a strong current correlation between breweries and outdoor clothing stores?
- What is the growth potential for clothing store expansion based on brewery locations?
- What is the growth potential for brewery expansion based on outdoor clothing locations?

### Machine Learning Model

*  Data is preprocessed and cleaned by removing unneeded columns, merging zip code/cities datasets, and limiting dataset to the top 1,000 most populated cities.
*  To obtain the best possible predictive results, preliminary features should be explored, engineered, and carefully selected. Possible preliminary features for this model could be average income per zipcode, income per capita, and clothing stores per brewery count.
*  The importance of correlation between breweries and outdoor clothing stores will drive which features will be engineered and selected, ultimately answering the hypthesis.
*  Data was split into training and testing sets using train_test_split and a random state of 24. This will assist in evaluating the performance of the model in relation to the dataset.
*  A linear regression model was chosen to best illustrate correlation between brewery location and outdoor clothing store location. Is there a strong relationship between the two? The benefits of using a linear regression is readability and abiility to answer basic questions. Limitations of a linear regression model will be sensitivity to outliers. With more time we would like to also set up a cluster model.

### Collaborators

- Brandon Clark
- Brandon Driver
- Tim Nilsen
- Warren Pavlat
