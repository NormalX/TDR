#################################################################################
#                           DADES DE FBREF                                                                
#################################################################################
# Carreguem la llibreria

library(worldfootballR)

#-------------------------------------------------------------------------------
# Aquesta llibreria ha deixat de funcionar des de octubre de 2025 degut a canvis 
# en la web de FBREF.com, per tanta, aquest codi ja no serveix per obtenir dades.
#-------------------------------------------------------------------------------


#-------------- LA LIGA 2024/2025 - EQUIPS - TIPUS DE PASSADES -----------------

# Obtenim les urls dels partits de la lliga
match_urls <- fb_match_urls(country = "ESP", gender = "M", season_end_year = 2025, tier = "1st")
# Amb la funció fb_advanced_match_stats obtenim les dades de tipus de passades per equips
data_df <- fb_advanced_match_stats(match_url=urls,stat_type="passing_types",team_or_player="team")
# Guardar el data frame com a arxiu CSV 
write.csv(data_df, "ESP_2025_M_1st_team_fb_match_sts_passing_types.csv", row.names = FALSE)


#-------------- LIGA F 2024/2025 - EQUIPS - TIPUS DE PASSADES ------------------

# Obtenim les urls dels partits de la lliga
match_urls <- fb_match_urls(country = "ESP", gender = "F", season_end_year = 2025, tier = "1st")
# Amb la funció fb_advanced_match_stats obtenim les dades de tipus de passades per equips
data_df <- fb_advanced_match_stats(match_url=urls,stat_type="passing_types",team_or_player="team")
# Guardar el data frame com a arxiu CSV 
write.csv(data_df, "ESP_2025_F_1st_team_fb_match_sts_passing_types.csv", row.names = FALSE)


#-------------- LA LIGA 2023/2024 - EQUIPS - TIPUS DE PASSADES -----------------

# Obtenim les urls dels partits de la lliga
match_urls <- fb_match_urls(country = "ESP", gender = "M", season_end_year = 2024, tier = "1st")
# Amb la funció fb_advanced_match_stats obtenim les dades de tipus de passades per equips
data_df <- fb_advanced_match_stats(match_url=urls,stat_type="passing_types",team_or_player="team")
# Guardar el data frame com a arxiu CSV 
write.csv(data_df, "ESP_2024_M_1st_team_fb_match_sts_passing_types.csv", row.names = FALSE)