# dbt-analytics-incremental-dd

A comprehensive data analytics pipeline that generates synthetic e-commerce data and transforms it into clean, tested, analytics-ready models using dbt with a focus on incremental models.

## Project Structure

This workspace contains two main components:

### DataGenerator
A Python package that generates realistic synthetic e-commerce data including:
- **Customers**: Personal information, contact details, and registration dates
- **Orders**: Order transactions with dates, amounts, and status tracking
- **Order Items**: Detailed line items for each order with quantities and prices
- **Products**: Product catalog with categories, pricing, and inventory

The data is generated using the Faker library and stored in a DuckDB database for efficient analytics.

### dbt-transform
A dbt project that transforms the raw data from DataGenerator into:
- Clean, normalized data models
- Business metrics and KPIs
- Analytics-ready datasets
- Incremental data processing pipelines

## Technology Stack

- **Python 3.12+**: Core programming language
- **uv**: Fast Python package manager
- **DuckDB**: Embedded analytical database
- **Polars**: High-performance DataFrame library
- **Faker**: Synthetic data generation
- **dbt**: Data transformation tool
- **dbt-duckdb**: DuckDB adapter for dbt

## Getting Started

1. **Install dependencies**:
   ```bash
   uv sync
   ```

2. **Generate sample data**:
   ```bash
   cd DataGenerator
   python main.py
   ```

3. **Run dbt transformations** (once models are created):
   ```bash
   cd dbt-transform
   dbt run
   ```

## Development

- DataGenerator: Contains the synthetic data generation logic
- dbt-transform: Contains dbt models, tests, and documentation
- Both packages are managed as a uv workspace for consistent dependency management
