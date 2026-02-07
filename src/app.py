import os
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
import pandas as pd


# Load environment variables
load_dotenv()

# Read DB path from environment variable
DB_PATH = os.getenv('DB_PATH', './data/database.db')  # fallback to default
DB_URL = f'sqlite:///{DB_PATH}'

# Connect to the existing SQLite database
def connect():
    try:
        engine = create_engine(DB_URL)
        engine.connect()
        print("✅ Connected to existing SQLite database.")
        return engine
    except Exception as e:
        print(f"❌ Error connecting to database: {e}")
        return None

# Run student-defined queries from queries.sql
def run_queries_from_file(engine, filepath):
    try:
        with open(filepath, 'r') as file:
            content = file.read()
        queries = [q.strip() for q in content.split(';') if q.strip()]
        for i, query in enumerate(queries, start=0):
            # Skip if it's just a comment
            if query.startswith('--') or not any(c.isalnum() for c in query):
                continue
            try:
                print(f"\n🔎 Query {i}:\n{query}")
                  # Check if it's a SELECT query
                if query.strip().upper().startswith('SELECT'):
                    df = pd.read_sql(query, con=engine)
                    print(df)                           
                else:
                    # For INSERT, UPDATE, DELETE - execute without reading
                    with engine.connect() as conn:
                        result = conn.execute(text(query))
                        conn.commit()
                        print(f"✅ Query executed successfully. Rows affected: {result.rowcount}")

            except Exception as e:
                print(f"❌ Error in Query {i}: {e}")
    except Exception as e:
        print(f"❌ Error processing queries from {filepath}: {e}")

# Entry point
if __name__ == "__main__":
    engine = connect()
    if engine:
        run_queries_from_file(engine, './src/sql/queries.sql')