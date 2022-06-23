
# ****Start by putting your excel mapping in the right folder!!!!!
# ****Make sure it is the only excel file there. Delete any other excel
#   files in that particular folder or the program will get confused

# ***To run a line of code, put your blinking cursor on that line and hit 
#   CTRL+ENTER on your keyboard to run it. You can highlight multiple lines
#   of code at then to CTRL+ENTER to run a whole bunch of code.
#   Lines that start with a hashtag symbol are comments, nothing
#   will happen if you run a comment.

# run all the code in this block to get the tool initialized ----------------

# source another script
source(file = paste0(getwd(), '/mixer/mixer_script_1.R'))

# ^ -----

# now, specify some details... ----------------------------------

# let's clarify what columns contain the zips and which column
#   is the grouping of the geographies. Replace the text in quotes below
#   first with the name exactly of the zip code column. Second, 
#   type the exact name of the grouping you want to see
colnm_geo_code <- 'FHCF ZIP Code'
colnm_geo_grp <- 'Rating Region'

# now specify which state you are looking at
state_for_census_lookup <- 'FL'

# input the census API key in the quotations. see the instructions
#   in the README for how to get a key. This allows you to get 
#   the geometric shapes of all zip codes. This key can be used to 
#   get lots of other interesting Census data for other projects too!
#   Put the census key (a very long string of numbers and letters)
#   in the quotation marks right below this.
census_api_key('')

# ***when you have specified these things, run them to 
#   tell the computer what to do next.
# ^ -----

# once the specifics are made above, run this block to do the work -------
# ***NOTE: this will take a bit of time, that is expected!

# source another script
clockin()
source(file = paste0(getwd(), '/mixer/mixer_script_2.R'))
clockout()

# this function makes a map, the second function prints a copy to the
#   /cement folder
fun_map1()
qp(pltname = 'geo_aggregated_map', pltpath_suffix = '/cement')

# ^ -----