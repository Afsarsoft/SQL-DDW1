# SQL-DDW1
Demo, Data Warehouse V1 <br />
A Sample OLTP and OLAP/Data Warehouse DBs to demo how to build and load a Data Warehouse DB from OLTP DB. <br /> 

# Recommended Prerequisites
-https://github.com/Afsarsoft/SQL101 <br />
-https://github.com/Afsarsoft/SQL-AnimalShelter <br />

# Manual Installation 
For OLTP DB <br />
1- In a new or existing SQL DB or Azure SQL DB, from "Script1" folder, install script CreateSchema.sql <br />
2- From "SP" folder install all SPs (ignore any warnings) <br />
3- From "Script2" folder, run all scripts starting with 01_% to 03_% <br /> <br />

For OLAP/Data Warehouse <br />
1- In a new or existing SQL DB or Azure SQL DB, from "Script1DW" folder, install script CreateSchemaDW.sql <br />
2- From "SPDW" folder install all SPs (ignore any warnings) <br />
3- From "Script2DW" folder, run all scripts starting with 01_% and 02_% <br /> <br />

# Automated Installation 
1- Create a folder "C:\DDW1" <br />
2- Copy folders "Script1", "Script2", "Script1DW", "Script2DW", "SP", AND "SPDW" to folder "C:\DDW1" <br /> <br />

For OLTP DB <br />
3- Change connection "OLTP_Connection" according to your environment and Run SSIS package BuildOLTP to install all SQL objects <br />

For OLAP/Data Warehouse <br />
4- Change connection "DW_Connection" according to your environment and Run SSIS package BuildDW to install all SQL objects <br />

# Loading OLAP/Data Warehouse 
Change connections "OLTP_Connection" and "DW_Connection" according to your environment and Run SSIS package LoadDW to Load OLAP/Data Warehouse <br />


