# Sales Analysis for Target 

## Project Overview
This project aims to perform an in-depth sales analysis for Target Company by utilizing SQL and Tableau for data management, processing, and visualization. The analysis provides insights into key business metrics such as sales trends, customer behavior, and product performance.

## Tools and Technologies
- **Python**: Automated the extraction and transformation of raw CSV data files into structured SQL tables.
- **SQL Server**: Served as the primary database for storing and querying sales data.
- **Tableau**: Used for data visualization and creating interactive dashboards to present insights.

## Dataset Overview
The dataset consisted of the following tables:
- **Geolocation**: Contains information about the geographic locations associated with orders.
- **Customers**: Includes details about customers, such as customer IDs and geolocation.
- **Order_Items**: Records of individual items within each order, including product IDs, prices, and quantities.
- **Orders**: Comprehensive data on each order, including order ID, status, purchase date, and customer ID.
- **Payments**: Information about payment methods and transaction amounts for each order.
- **Products**: Details of products sold, including product IDs, names, and categories.
- **Sellers**: Data on sellers, including seller IDs and geolocation.

## Process
1. **Data Ingestion and Storage**  
   - CSV files containing sales data were ingested using Python scripts.
   - The data was cleaned and formatted before being dumped into an SQL Server database.
   - This automated process ensured that the data was stored in a structured and efficient manner.

2. **Data Analysis with SQL**  
   - SQL queries were employed to extract insights from the database.
   - Key analyses included:
     - Sales trends over time.
     - Performance comparison between different products and categories.
     - Analysis of customer purchasing behavior and segmentation.
     - Identification of top-performing sellers and geographic regions.

3. **Data Visualization with Tableau**  
   - The results of the SQL queries were visualized using Tableau.
   - Dashboards provided a comprehensive view of sales metrics, including:
     - Interactive visualizations showing sales trends and patterns.
     - Geographic heat maps displaying sales distribution by region.
     - Product performance dashboards highlighting top-selling products and categories.
     - Customer segmentation analysis to identify key customer groups and their purchasing patterns.

## Results
The analysis delivered actionable insights into sales performance, enabling Target Company to make data-driven decisions in areas such as inventory management, marketing strategies, and customer engagement.
