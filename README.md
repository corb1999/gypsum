# gypsum
*user-friendly R script utility to aggregate zip codes in maps using simple features and a provided grouping*

## Instructions for New R Users
- Download RStudio (and R) and install these packages: tidyverse, lubridate, readxl, tidycensus, sf
- Copy the entire **gypsum** project folder into a spot on your local computer.  Then open the project within R Studio.
- Get a US Census API Key (very easy): [Census API Site](https://api.census.gov/data/key_signup.html)
- Create your mapping of zip-codes to whatever grouping to you have and save it as a table in an excel file.
  - Make sure the mapping uses only 5-digit version of zip-codes, and make sure this lookup is the first tab of the workbook. No blank rows at the top of the sheet, no blank rows, format it like a simple clean table.
  - Save a copy of this excel file to this folder in the directory and delete the excel file that is currently there. **(/gypsum/sand/put_only_one_excel_inside_this_folder_here)** 
  - This is where the program will look for your excel mapping. Look at the excel file that is currently there for a helpful example. Just make sure to delete that example file after you put yours in its place.
- Now open the cement_maker.R script in R Studio and run/alter the code as it instructs. The aggregation will be performed and output a map and the shapefiles into the **/cement** folder. If you run into trouble, make a note of where the program starts to go wrong, and ask your peers for help!
