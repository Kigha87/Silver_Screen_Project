# Silver_Screen_Project

## TABLE OF CONTENT

- [Project Overview](#project-overview)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Key Models](#key-models)
- [Data Quality And Testing](#data-quality-and-testing)
- [Lineage Overview](#lineage-overview)
  

## 1. Project Overview

This dbt project serves as the central transformation pipeline for the "Silver Screen" analytics initiative. The primary goal is to analyze the efficiency of three newly acquired movie theaters in New Jersey by creating a unified, reliable dataset.

The project ingests raw data from multiple sources, each with a different structure and granularity, and transforms it into a single, clean, and aggregated final table. This table, `monthly_movie_performance`, provides a monthly summary of ticket sales, revenue, and movie rental costs for each movie at each location.

## 2. Tech Stack

*   **Data Warehouse:** Snowflake
*   **Transformation Tool:** dbt (Data Build Tool)
*   **Orchestration (Optional):** dbt Cloud

## 3. Project Structure

The project follows dbt best practices, organizing models into logical layers:

*   **/models/staging**: This layer contains models that perform basic cleaning, casting, and renaming of the source data. Each source table has a corresponding staging model. The goal is to create a clean, standardized version of each raw source.
*   **/models/intermediate**: This layer contains ephemeral models used for complex transformations or for joining/unioning staging models. The `int_unioned_sales.sql` model is a key example, as it combines the sales data from all three locations into a single stream.
*   **/models/marts**: This is the final layer, containing the business-facing tables that BI tools or analysts will consume. Our primary output, `monthly_movie_performance`, lives here.

### Data Flow (DAG)

The project follows this general data flow:


## 4. Key Models

*   `stg_nj001_sales`, `stg_nj002_sales`, `stg_nj003_sales`: These models clean and standardize the sales data from the three different location sources, bringing them to a common structure.
*   `stg_movie_catalogue`: Cleans the movie metadata, replacing null `genre` values with 'Unknown'.
*   `stg_invoices`: This model ingests raw invoice data, cleans column names, and aggregates records to a monthly grain to provide a single, accurate `rental_cost` per movie, per location, per month. It correctly handles duplicate invoice entries found in the source.
*   `int_unioned_sales`: An ephemeral model that unions the three separate sales streams into one cohesive dataset.
*   `monthly_movie_performance`: The final table. It joins sales data with the movie catalogue and invoice data to create a comprehensive monthly performance view. **Granularity: one row per movie, per location, per month.**

## 5. Data Quality and Testing

Data integrity is enforced via a suite of tests defined in the `sources.yml` and `marts.yml` files. These include:

*   **Generic Tests**: `not_null` and `unique` tests are applied to primary keys and critical columns in the source data.
*   **Custom Singular Test**:
    *   `assert_revenue_is_not_negative.sql`: This test ensures that no record in the final `monthly_movie_performance` table has a negative revenue value.

