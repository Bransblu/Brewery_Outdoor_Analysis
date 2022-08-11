from sqlalchemy import create_engine
from config import DB_USERNAME, DB_PASSWORD, HOST

CONNECTION_STRING = f'postgresql+psycopg2://{DB_USERNAME}:{DB_PASSWORD}@{HOST}/postgres'

ENGINE = create_engine(CONNECTION_STRING)
