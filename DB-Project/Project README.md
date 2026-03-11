CSCI 601  DB Project – Bigfoot Sightings 					Date:  03/11/2026 
Project Title: Bigfoot Sightings  
Project Team Members: 
Alex Bailey - abailey7@student.citadel.edu 
Bradley Eudy - beudy@student.citadel.edu 
Brooks O’Steen - bosteen@student.citadel.edu 
Merrick Moss - cmoss@student.citadel.edu 
Sophia Kozlowski - skozlows@student.citadel.edu 
Dan Johnson - jjohns79@student.citadel.edu 
 
The dataset selected for this database project is “Bigfoot Sightings Data,” which is publicly available on the Kaggle data science platform. The dataset was curated by Timothy Renner and is primarily based on reports collected by the Bigfoot Field Researchers Organization (BFRO), an organization founded in 1995 dedicated to documenting and investigating reported Bigfoot sightings. The dataset contains sighting records spanning more than 150 years, making it a large and historically rich collection of observational reports.
The data used for the project comes from the file bfro_reports_geocoded.csv, which contains cleaned and geocoded versions of the original sighting reports. Each record includes a variety of structured metadata attributes such as timestamp information, latitude and longitude coordinates, moon phase, wind speed, wind direction, humidity, and other environmental conditions present at the time of the reported sighting. Additional contextual fields include report numbers, titles, and descriptive narrative information associated with each event.
Designing a relational database around this dataset enables structured analysis of the reports and their associated environmental factors. A normalized database schema could allow researchers to examine geographic clusters of sightings, analyze correlations between environmental conditions and report frequency, and track changes in witness credibility classifications over time. The dataset also enables interesting analytical queries, such as identifying which regions report the most sightings relative to forest coverage or whether environmental factors such as moon phase influence reporting patterns. Because the dataset contains multiple related attributes, it provides an ideal candidate for a multi-table relational database design.

The project will involve creating a relational database schema that captures the various attributes of the Bigfoot sightings, including tables for sightings, locations, environmental conditions, and witness information. The database will be designed to allow for efficient querying and analysis of the data, enabling users to explore patterns and trends in Bigfoot sightings over time and across different geographic regions. The project will also include the development of SQL queries to extract insights from the database, such as identifying hotspots for sightings or analyzing the relationship between environmental factors and sighting frequency. Overall, this project aims to provide a structured and comprehensive way to analyze the Bigfoot sightings data and uncover meaningful insights from it.

Identifying Entities 
1. SIGHTING
2. LOCATION
3. WEATHER 
4. REPORT 
5. WITNESS 
6. ENVIRONMENT

Bigfoot Sightings Database – Phase 2 Design
Overview

This database design is based on the Bigfoot Sightings dataset available on Kaggle and derived from reports collected by the Bigfoot Field Researchers Organization (BFRO).

The purpose of the database is to organize sighting reports and related metadata so that researchers can analyze geographic trends, environmental conditions, and reporting patterns associated with Bigfoot sightings.

The dataset contains structured metadata including:

timestamps

latitude and longitude

environmental conditions

moon phase

wind speed and direction

humidity

narrative descriptions of sightings

The relational schema separates the data into normalized tables to eliminate redundancy and support efficient queries.

Entity Relationship Diagram (ERD)
erDiagram

REPORT {
int report_id PK
int external_id
int location_id FK
int weather_id FK
text title
text description
timestamp report_timestamp
}

LOCATION {
int location_id PK
string state
float latitude
float longitude
}

WEATHER {
int weather_id PK
float temperature
float humidity
float wind_speed
string wind_direction
string moon_phase
}

REPORT ||--|| LOCATION : occurs_at
REPORT ||--|| WEATHER : has_conditions
Database Tables
REPORT

Stores the primary information about each Bigfoot sighting.

Column	Type	Description
report_id	SERIAL (PK)	Internal unique identifier
external_id	INTEGER	Original dataset report ID
location_id	INTEGER (FK)	References LOCATION
weather_id	INTEGER (FK)	References WEATHER
title	TEXT	Report title
description	TEXT	Narrative report
report_timestamp	TIMESTAMP	Date and time of sighting
LOCATION

Stores geographic information about the sighting.

Column	Type	Description
location_id	SERIAL (PK)	Unique location ID
state	VARCHAR(50)	State where sighting occurred
latitude	FLOAT	Latitude coordinate
longitude	FLOAT	Longitude coordinate
WEATHER

Stores environmental conditions recorded during the sighting.

Column	Type	Description
weather_id	SERIAL (PK)	Weather record ID
temperature	FLOAT	Temperature during sighting
humidity	FLOAT	Humidity level
wind_speed	FLOAT	Wind speed
wind_direction	VARCHAR(20)	Direction of wind
moon_phase	VARCHAR(30)	Phase of the moon