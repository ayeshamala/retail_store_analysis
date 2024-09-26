# Retail Sales Analysis

## Project Background
The ABC Company is a US-based retail store that sells popular products in Housekeeping, Office Supplies, Furnishings, Maintenance, and Public Areas. The company only sells products out of a physical location in major cities in 18 US States. 

The company has a significant amount of data on its sales pattern related to geographical locations, product categories, and the products sold within those categories, but the data was never fully utilized for marketing efforts and sales analysis. This project thoroughly analyzes and synthesizes the data from 2015 and 2016 to uncover critical insights to improve marketing strategies and sales practices. 

Insights and recommendations are provided in the following areas:

- **Sales Performance**: Trend analysis in sales over time by highlighting the best-selling products and showcasing seasonal variations.
- **Product Analysis**: Analysis of the product catalog to determine which products have the highest demand, profit margins, and return rates.
- **Regional Insights**: Exploration of property information to identify regions with the highest sales volumes and profitability.

Interactive PowerBI Dashboard: [Download Here](https://github.com/ayeshamala/retailsales/blob/main/Retail_Sales_Visualization.pbix)

SQL Queries to Clean, Organize and Prepare Data for Visualization: [Download Here](https://github.com/ayeshamala/retailsales/blob/main/retail_store_dashboard_prep.sql)

SQL QUeries for Exploratory Data Analysis: [Download Here](https://github.com/ayeshamala/retailsales/blob/main/retail_store_EDA.sql)

## Data Structure & Relationships

THE ABC Company's database structure consists of 3 tables: Order Details, Products, and Property Info with a total row count of 5,000 records.

![](https://github.com/ayeshamala/retailsales/blob/main/Entity%20Relationship%20Diagram.png)

## Executive Summary
In 2015, The ABC Company experienced stronger revenue performance, with a decline of 2.03% in total revenue recorded for 2016. However, there was no significant difference in the number of orders received or product sales between the two years. Key performance indicators reveal that although there is a slight decline in revenue, there was actually a 1.3% increase in product sales. This suggests a shift in demand towards lower-priced products, as they were sold in greater quantities compared to higher-priced items.

Below is the overview of the PowerBI dashboard and the complete interactive dashboard can be downloaded [here](https://github.com/ayeshamala/retailsales/blob/main/Retail_Sales_Visualization.pbix).

![](https://github.com/ayeshamala/retailsales/blob/main/Retail_Sales_Dashboard.PNG)

### Sales Performance
- Sales for the company reached their highest point in **May 2016**, generating $27,614 in revenue. However, there was no notable revenue growth for the remainder of the year.
- Contrary to typical seasonal patterns, holiday sales did not have a significant impact in 2016, with October recording the lowest revenue of $17,497 during the two-year period.
- **Q4 2015** followed the expected seasonal trend, with a marked increase in revenue driven by the holiday period. November 2015 stood out as the highest-performing month that year.

<p align="center">
  <img src="https://github.com/ayeshamala/retail_store_analysis/blob/main/2015-2016%20Revenue.PNG" />
</p>

### Product Analysis
- **67.47%** of revenue is generated from the high-demand categories including **Furnishings** and **Public Areas** products, resulting in higher total revenue due to larger order quantities or higher unit prices.
- With **16.4%** of the total revenue, **Bed (King), Bed (Double),** and **Portable Drill** are the top 3 performing products across all categories.
- The pricing strategy across categories like Office Supplies and Maintenance also influences overall revenue generation, with fewer units sold but higher price points for products like tools and supplies.

### Regional Insights
- Store locations in **California, Virginia**, and **Missouri** are the top performers, contributing 26.4% of the total revenue.
- Geographic variation in product orders shows differing priorities between properties, with some regions focusing more on maintaining public areas, while others emphasize housekeeping or office supplies.

## Recommendations
- Since 67.47% of revenue is generated from Furnishings and Public Areas, prioritize marketing efforts in these categories. Consider targeted campaigns to increase brand awareness and promote best-selling products like beds and drills.
- Despite the weak holiday performance in 2016, consider introducing early promotions or loyalty programs leading into peak seasons (e.g., November for holiday sales) to encourage more purchases.
- Given the shift towards lower-priced products, consider competitive pricing strategies for essential high-demand items, ensuring they are priced attractively to stimulate sales.
- Review the product catalog regularly to identify and phase out low-demand items that may be tying up inventory costs.
- Consider implementing a loyalty program that rewards customers for repeat purchases, which can help increase sales volume, especially in high-demand categories.
- Establish a routine for regular data analysis to monitor sales performance, customer preferences, and market trends. This can help quickly adapt to changing demands and optimize marketing campaigns.

