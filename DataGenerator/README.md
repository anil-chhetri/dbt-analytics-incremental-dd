# DataGenerator

A Python package for generating realistic synthetic e-commerce data for analytics and testing purposes. It creates comprehensive datasets including customers, orders, order items, and products, stored in a DuckDB database.

## Features

### Data Generation
- **Customers**: Generates customer profiles with realistic names, addresses, phone numbers, and email addresses
- **Orders**: Creates order transactions with timestamps, amounts, and status tracking (pending, shipped, delivered, canceled)
- **Order Items**: Generates detailed order line items with product references, quantities, and pricing
- **Products**: Builds a product catalog across multiple categories (Electronics, Home & Kitchen, Apparel, Beauty, Pantry)

### Data Storage
- Uses DuckDB for efficient analytical data storage
- Creates normalized tables in a `raw` schema
- Supports incremental data generation (resumes from last customer ID)

## Dependencies

- `faker>=40.1.0`: Library for generating fake data such as names, addresses, and phone numbers.
- `duckdb`: Embedded analytical database
- `polars`: High-performance DataFrame library

## Installation

Install the package using uv:

```bash
uv add faker duckdb polars --package DataGenerator
```

## Database Exploration

After generating data, you can explore the DuckDB database using Harlequin:

```bash
# Installs Harlequin (a CLI/TUI for DuckDB)
uv tool install harlequin

# Open the database in Harlequin
harlequin ./dev.duckdb
```

### Generate Data
Run the main script to generate sample data:

```bash
python main.py
```

This will:
1. Generate product catalog data
2. Create 99 new customers with associated orders and order items
3. Save all data to `../dev.duckdb`

### Data Structure

The generated data includes:

**Products Table:**
- `product_id`: Unique product identifier
- `product_name`: Product name
- `category`: Product category
- `price`: Product price
- `stock_quantity`: Available stock

**Customers Table:**
- `customer_id`: Unique customer identifier
- `first_name`, `last_name`: Customer name
- `phone_number`: Contact number
- `address`: Full address
- `email`: Email address
- `created_at`: Registration timestamp

**Orders Table:**
- `order_id`: Unique order identifier
- `customer_id`: Reference to customer
- `order_date`: Order timestamp
- `amount`: Total order amount
- `status`: Order status

**Order Items Table:**
- `order_item_id`: Unique item identifier
- `order_id`: Reference to order
- `product_id`: Reference to product
- `quantity`: Item quantity
- `price`: Item price

## Configuration

- **Database Path**: Configured to save to `../dev.duckdb`
- **Data Volume**: Generates ~99 customers with 2-5 orders each, 2-4 items per order
- **Localization**: Uses UK English (`en_GB`) for data generation