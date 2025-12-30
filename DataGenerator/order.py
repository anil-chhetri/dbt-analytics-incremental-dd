from faker import Faker
import random 

import polars as pl

from typing import Tuple, Dict, List
Faker.seed(0)

EMAIL_DOMAINS = ['example.com', 'test.com', 'sample.org']
STATUS = ['pending', 'shipped', 'delivered', 'canceled']
PRODUCT_CATEGORIES = {
    "Electronics": [
        "Noise-Canceling Wireless Headphones",
        "Smart LED Desk Lamp",
        "Portable Bluetooth Speaker",
        "4K Ultra HD Dash Cam"
    ],
    "Home & Kitchen": [
        "Stainless Steel French Press",
        "Ergonomic Memory Foam Pillow",
        "Airtight Food Storage Container Set",
        "Digital Kitchen Scale"
    ],
    "Apparel & Gear": [
        "Waterproof Running Shell Jacket",
        "Heavy-Duty Canvas Backpack",
        "Quick-Dry Microfiber Yoga Mat",
        "Polarized Sports Sunglasses"
    ],
    "Beauty & Personal Care": [
        "Organic Hydrating Face Serum",
        "Sonic Electric Toothbrush",
        "Lavender Infused Epsom Salts",
        "Natural Charcoal Whitening Toothpaste"
    ],
    "Pantry & Groceries": [
        "Fair-Trade Dark Roast Coffee Beans",
        "Himalayan Pink Sea Salt (Fine)",
        "Gluten-Free Rolled Oats",
        "Cold-Pressed Extra Virgin Olive Oil"
    ]
}


def generate_order_data(customer_id: int):
    fake = Faker('en_GB')
    data = {
        "order_id": random.randint(1, 10),
        "customer_id": customer_id,
        "order_date": fake.date_time_this_year().strftime("%Y-%m-%d %H:%M:%S"),
        "amount": round(random.uniform(10.0, 500.0), 2),
        "status": random.choice(STATUS)
    }
    return data

def generate_order_item_data(order_id: int):
    fake = Faker('en_GB')
    data = {
        "order_item_id": random.randint(1000, 9999),
        "order_id": order_id,
        "product_id": random.randint(1, 20),
        "quantity": random.randint(1, 10),
        "price": round(random.uniform(5.0, 200.0), 2)
    }
    return data


def generate_product_data():
    data = []
    counter = 1
    for index, (key, value) in enumerate(PRODUCT_CATEGORIES.items()):
        for product_name in value:
            product = {
                "product_id": counter,
                "product_name": product_name,
                "category": key,
                "price": round(random.uniform(5.0, 200.0), 2),
                "stock_quantity": random.randint(0, 100)
            }
            data.append(product)
            counter += 1
    return data

def generate_customer_data(customer_id: int):
    fake = Faker('en_GB')
    data  = {
        "customer_id": customer_id + 1,
        "first_name": fake.first_name(),
        "last_name": fake.last_name(),
        "phone_number": fake.phone_number(),
        "address": fake.address(),
        "created_at": fake.date_time_this_decade().strftime("%Y-%m-%d %H:%M:%S"),
        "email": None
    }

    data["email"] = f"{data['first_name'].lower()}.{data['last_name'].lower()}@{random.choice(EMAIL_DOMAINS)}"
    return data
    

def get_date(customer_id: int) -> Tuple[Dict, List, List]:
    customer_data = {}
    order = []
    order_item = []

    customer_data = generate_customer_data(customer_id=customer_id)
    for _ in range(1,random.randint(2,5)):
        order_data = generate_order_data(customer_data["customer_id"])
        order.append(order_data)

        for _ in range(1, random.randint(2,4)):
            order_item_data = generate_order_item_data(order_data["order_id"])
            order_item.append(order_item_data)

    return customer_data, order, order_item


def data_feed(feed_name: str, feed_length: int = 10) -> pl.DataFrame:
    feed_lookup = {
        "orders": generate_order_data,
        "customers": generate_customer_data,
        "order_items": generate_order_item_data
    }

    data  = []

    for _ in range(feed_length):
        data.append(feed_lookup.get(feed_name)())

    df_feed = pl.DataFrame(data)
    return df_feed
