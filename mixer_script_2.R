
# clean the excel file and prep for join -------------------------

dfa <- raw_df %>% 
  rename(GEOID = !!colnm_geo_code, 
         geo_grouping = !!colnm_geo_grp) %>% 
  select(GEOID, geo_grouping) %>% 
  mutate(GEOID = as.character(GEOID), 
         geo_grouping = as.character(geo_grouping))

rm(raw_df, colnm_geo_code, colnm_geo_grp)


# query the census data ---------------------------------

clockin()
df_geo <- get_acs(state = state_for_census_lookup, 
                  geography = 'zcta', 
                  year = 2019, 
                  variables = 'B01003_001', 
                  geometry = TRUE, 
                  cache_table = TRUE)
clockout()

df_geo <- df_geo %>% select(GEOID, geometry)

# perform geospatial aggregation here ------------------------------

interim <- left_join(df_geo, dfa, by = "GEOID")

clockin()
interim <- interim %>% group_by(geo_grouping) %>% 
  summarise(n_geo = n())
clockout()

clockin()
df_outcome <- aggregate(interim[, c('geo_grouping', 'geometry')], 
                        by = list(interim$geo_grouping), 
                        FUN = mean, na.rm = TRUE)
clockout()

df_outcome <- df_outcome %>% 
  select(Group.1, geometry) %>% 
  rename(geo_grouping = Group.1)

rm(df_geo, dfa)

# output the results -------------------------------------------

clockin()
write_sf(df_outcome, 
         (getwd() %ps% '/cement/shapefiles_output/' %ps% 
          'geo_aggregation_shapefiles.shp'))
clockout()

qp <- function(pltname, pltpath_suffix = NA, plt_inch = 5) {
  plt_timestamp <- paste(year(Sys.time()), month(Sys.time()),  
                         day(Sys.time()), hour(Sys.time()), minute(Sys.time()), 
                         floor(second(Sys.time())), sep = "-")
  aa <- ifelse(is.na(pltpath_suffix), "", pltpath_suffix)
  plt_filepath <- paste0(getwd(), aa)
  plt_name <- paste0("plt_", pltname, "_", plt_timestamp, ".png")
  ggsave(filename = plt_name, plot = last_plot(), 
         path = plt_filepath, scale = 1, device = "png", 
         height = plt_inch, width = plt_inch * 1.61803399, units = "in")}

fun_map1 <- function(arg_df = df_outcome) {
  plt1 <- arg_df %>% 
    ggplot() + 
    geom_sf(aes(fill = geo_grouping), color = 'black') + 
    theme_minimal() + 
    theme(legend.position = 'none')
  return(plt1)
}

