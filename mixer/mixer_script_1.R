
library(tidyverse)
library(janitor)
library(readxl)
library(tidycensus)
library(sf)
options(digits = 4, max.print = 99, warnPartialMatchDollar = TRUE, 
        tibble.print_max = 30, scipen = 999, nwarnings = 5, 
        stringsAsFactors = FALSE)

# start the clock timer, used for monitoring runtimes
clockin <- function() {
  aa <- Sys.time()
  clock_timer_start <<- aa
  return(aa)}

# end the clock timer, used in conjunction with the clockin fun
clockout <- function(x) {
  aa <- clock_timer_start
  bb <- Sys.time()
  cc <- bb - aa
  return(cc)}

# POST SCRIPT; alt to using paste0() all the time (i saw this on twitter)
'%ps%' <- function(lhs, rhs) {
  return_me <- paste0(lhs, rhs)
  return(return_me)}

# function to pull a dataframe of files in a working directory
file_cabinet <- function(search_path = getwd()) {
  aa <- data.frame(search_path = search_path, 
                   dir_object = list.files(path = search_path, 
                                           all.files = TRUE))
  bb <- aa %>% 
    mutate(object_suffix = str_extract(dir_object, 
                                       "\\.[:alpha:]*$"), 
           dir_isend = ifelse(is.na(object_suffix), 
                              FALSE, TRUE), 
           dir_path = ifelse(dir_isend == FALSE, 
                             paste0(search_path, '/', dir_object), 
                             NA))
  return(bb)}

interim <- file_cabinet(search_path = getwd() 
                                  %ps% '/sand/' %ps% 
               'put_only_one_excel_inside_this_folder_here') %>% 
  filter(object_suffix == '.xlsx')

if (nrow(interim) > 1) {
  print('Too many Excel files, only 1 excel file please')
} else {
  print('Proper number of excel files')
}

geo_grouping_filepath <- (interim$search_path[1] %ps% '/' %ps% 
                            interim$dir_object[1])
geo_grouping_filepath

# load an excel file
clockin()
raw_df <- read_excel(path = geo_grouping_filepath, sheet = 1)
clockout()
dim(raw_df)

if (nrow(raw_df) > 0 & ncol(raw_df) > 1) {
  print('Column names found: ' %ps% colnames(raw_df))
} else {
  print('Problem with geo mapping lookup in Excel')
}

rm(interim, file_cabinet, geo_grouping_filepath)
