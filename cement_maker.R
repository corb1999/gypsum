
# ****Start by putting your excel mapping in the right folder!!!!!

# run all the code in this block to get the tool initialized ----------------

# source another script
sourcerpath <- paste0(getwd(), '/mixer/mixer_script_1.R')
source(file = sourcerpath)

# ^ -----

# now, specify some details ----------------------------------

# let's clarify what columns contain the zips and which column
#   is the grouping of the geographies
colnm_geo_code <- 'FHCF ZIP Code'
colnm_geo_grp <- 'Rating Region'

# now specify which state you are looking at
state_for_census_lookup <- 'FL'

# input the census API key
census_api_key('')


# ***when you have specified these things, run them to 
#   tell the computer what to do next
# ^ -----

# once the specifics are made, run this block to do the work -------



# ^ -----