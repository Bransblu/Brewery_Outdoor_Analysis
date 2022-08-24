import pandas as pd

from database_connection import ENGINE

def update_city_summary():
    query = open('sql/city_state_level_summary.sql', 'r')

    df = pd.read_sql(
        query.read(),
        con=ENGINE,
        index_col=None
    )

    df['population'] = df['population'].astype('int')

    query.close()

    df.to_sql(
        'city_summary',
        con=ENGINE,
        if_exists='replace',
        index=False
    )

if __name__ == '__main__':
    update_city_summary()