from order import (
    get_date,
    generate_product_data
)

import duckdb as db
import polars as pl

DUCKDB_PATH = './../dev.duckdb'


def save_product_duckdb():
    print("\ngenerating product data: ")
    product_data = generate_product_data()
    df_products = pl.DataFrame(product_data)


    with db.connect(DUCKDB_PATH) as con:
        con.execute("CREATE SCHEMA IF NOT EXISTS raw;")
        con.execute("""
        CREATE OR REPLACE TABLE raw.products AS 
        SELECT * FROM df_products;
        """)

def main():

    all_customer_data = []
    all_order_data = []
    all_order_item_data = []
    
    try:
        with db.connect(DUCKDB_PATH) as con:
            CUSTOMER_ID = con.execute("select max(customer_id) from customers").fetchone()[0] or 0
    except db.CatalogException:
        CUSTOMER_ID = 0
    except Exception as e:
        print(f"Error connecting to DuckDB: {e}")
        return

    for _ in range(1, 100):
        customer_data, order_data, order_item_data = get_date(customer_id=CUSTOMER_ID)
        all_customer_data.append(customer_data)
        all_order_data.extend(order_data)
        all_order_item_data.extend(order_item_data)
        CUSTOMER_ID += 1
    
    df_customers = pl.DataFrame(all_customer_data)
    df_orders = pl.DataFrame(all_order_data)
    df_order_items = pl.DataFrame(all_order_item_data)

    with db.connect(DUCKDB_PATH) as con:
        create_table_sql_text = """
        CREATE TABLE if not exists raw.customers AS 
        SELECT * FROM df_customers limit 0;

        CREATE   TABLE if not exists raw.orders AS 
        SELECT * FROM df_orders limit 0;

        CREATE TABLE if not exists raw.order_items AS 
        SELECT * FROM df_order_items limit 0;
        """
        con.execute(create_table_sql_text)


        insert_data_sql_text = """
        INSERT INTO raw.customers SELECT * FROM df_customers;
        INSERT INTO raw.orders SELECT * FROM df_orders;
        INSERT INTO raw.order_items SELECT * FROM df_order_items;
        """
        con.execute(insert_data_sql_text)


if __name__ == "__main__":
    save_product_duckdb()
    main()
