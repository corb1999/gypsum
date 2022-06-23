
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



