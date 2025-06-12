# Silver_Screen_Project

## TABLE OF CONTENT

- [Project Overview](#project-overview)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Key Models](#key-models)
- [Data Quality And Testing](#data-quality-and-testing)
- [How To Run The Project](#how-to-run-the-project)
- [Lineage Overview](#lineage-overview)
  

## 1. Project Overview

This dbt project serves as the central transformation pipeline for the "Silver Screen Project" analytics initiative. The primary goal is to analyze the efficiency of three newly acquired movie theaters in New Jersey by creating a unified, reliable dataset.

The project ingests raw data from multiple sources, each with a different structure and granularity, and transforms it into a single, clean, and aggregated final table. This table, `marts_monthly_movie_performance`, provides a monthly summary of ticket sales, revenue, and movie rental costs for each movie at each location.

## 2. Tech Stack

*   **Data Warehouse:** Snowflake
*   **Transformation Tool:** dbt (Data Build Tool)


## 3. Project Structure

The project follows dbt best practices, organizing models into logical layers:

*   **/models/staging**: This layer contains models that perform basic cleaning, casting, and renaming of the source data. Each source table has a corresponding staging model. The goal is to create a clean, standardized version of each raw source.
*   **/models/intermediate**: This layer contains ephemeral models used for complex transformations or for joining/unioning staging models. The `int_movies_revenue.sql` model is a key example, as it combines the sales data from all three locations into a single stream.
*   **/models/marts**: This is the final layer, containing the business-facing tables that BI tools or analysts will consume. Our primary output, `marts_monthly_movie_performance`, lives here.

### Data Flow (DAG)

The project follows this general data flow:


## 4. Key Models

*   `stg_nj001_sales`, `stg_nj002_sales`, `stg_nj003_sales`: These models clean and standardize the sales data from the three different location sources, bringing them to a common structure.
*   `stg_movies_catalogue`: Cleans the movie metadata, replacing null `genre` values with 'Unknown'.
*   `stg_invoices`: This model ingests raw invoice data, cleans column names, and aggregates records to a monthly grain to provide a single, accurate `rental_cost` per movie, per location, per month. It correctly handles duplicate invoice entries found in the source.
*   `int_movies_revenue`: An ephemeral model that unions the three separate sales streams into one cohesive dataset.
*   `marts_monthly_movie_performance`: The final table. It joins sales data with the movie catalogue and invoice data to create a comprehensive monthly performance view. **Granularity: one row per movie, per location, per month.**

## 5. Data Quality and Testing

Data integrity is enforced via a suite of tests defined in the `sources.yml` and `marts.yml` files. These include:

*   **Generic Tests**: `not_null` and `unique` tests are applied to primary keys and critical columns in the source data.
*   **Custom Singular Test**:
    *   `assert_revenue_is_not_negative.sql`: This test ensures that no record in the final `marts_monthly_movie_performance` table has a negative revenue value.

## 5. How to run the project

### Prerequisites

1.  dbt is installed and configured.
2.  Your `profiles.yml` file is set up with valid credentials to connect to your Snowflake data warehouse.
3.  The raw data CSVs have been loaded into the database and schema defined in your `models/sources.yml` file.

### Running the Project

To run all models and execute all tests, use the `build` command.

```bash
dbt build
```



## 6. lineage overview


<img width="1651" alt="Screenshot 2025-06-12 at 14 31 12" src="https://github.com/user-attachments/assets/999d266e-f20a-4aeb-86f7-2f0d655f3dad" />









