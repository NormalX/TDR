#################################################################################
# ESTADÍSTIQUES DE CORNERS PER TEMPORADA                                        #
#################################################################################
# Carreguem les llibreries

library(dplyr)
library(ggplot2)
library(scales)


################################################################################
# Funció per dibuixar la distribució de córners amb les dades 
################################################################################

plot_distribution_of_corners <- function(data_df, titulo = "Freqüència de Córners per Partit") {
  
  # Calcular total de córners por partit
  df_corners <- data_df %>%
    group_by(Game_URL) %>%
    summarise(Total_Corners = sum(CK_Pass_Types, na.rm = TRUE), .groups = "drop")
  
  # Distribució de freqüències
  freq_distribution <- table(df_corners$Total_Corners)
  
  # Convertir a data frame
  df_freq <- as.data.frame(freq_distribution)
  colnames(df_freq) <- c("Total_Corners", "Freq")  
  df_freq$Total_Corners <- as.integer(as.character(df_freq$Total_Corners))
  
  # Calcular total de partit, probabilitat i probabilitat acumulada
  total_partidos <- sum(df_freq$Freq)
  df_freq <- df_freq %>%
    mutate(
      Prob = Freq / total_partidos,
      Cum_Prob = cumsum(Prob)
    )
  
  # Calcular la mitjana, la variança i la desviació típica
  mean_corners <- sum(df_freq$Total_Corners * df_freq$Freq) / total_partidos
  var_corners <- sum(df_freq$Freq * (df_freq$Total_Corners - mean_corners)^2) / total_partidos
  sd_corners <- sqrt(var_corners)
  
  # Crear el gràfic
  p <- ggplot(df_freq, aes(x = Total_Corners, y = Freq)) +
    geom_col(fill = "salmon") +
    # Línia de probabilitat acumulada (escala secundaria)
    geom_line(aes(y = Cum_Prob * max(Freq)), 
              color = "slategray", 
              size = 1.0, 
              group = 1) +
    geom_point(aes(y = Cum_Prob * max(Freq)), color = "turquoise3", size = 2) +
    # Probabilitat individual sobre la barra
    geom_text(aes(label = percent(Prob)),
              vjust = -0.5,
              color = "black",
              size = 3) +
    # Probabilitat acumulada
    geom_text(aes(y = Cum_Prob * max(Freq), 
                  label = percent(Cum_Prob)),
              vjust = -0.5, 
              color = "darkorchid4", 
              size = 3) +
    # Número de partits en el centre de la barra
    geom_text(aes(label = Freq, y = Freq/2),
              color = "white",
              size = 3) +
    # Escales
    scale_x_continuous(breaks = df_freq$Total_Corners) +
    scale_y_continuous(
      name = "Freqüència (nombre de partits)",
      sec.axis = sec_axis(~./max(df_freq$Freq), 
                          name = "% de freqüència acumulada",
                          labels = scales::percent)
    ) +
    labs(
      title = titulo,
      x = "Nombre de córners per partit",
      y = "Freqüència (Nombre de Partits)"
    ) +
    theme_minimal() +
    # Línia vertical de la mitjana
    geom_vline(xintercept = mean_corners, linetype = "dashed", color = "darkorchid4", size = 1) +
    # Afegir la mitjana a la cantonada superior dreta
    annotate("text", x = max(df_freq$Total_Corners) * 0.98, 
             y = max(df_freq$Freq) * 1.15,
             label = paste("μ =", round(mean_corners, 2)), 
             color = "turquoise3", size = 3, hjust = 1, fontface = "bold") +
    # Afegir desviació típica a la cantonada superior dreta
    annotate("text", x = max(df_freq$Total_Corners) * 0.98, 
             y = max(df_freq$Freq) * 1.10,
             label = paste("σ =", round(sd_corners, 2)),
             color = "turquoise3", size = 3, hjust = 1, fontface = "bold")
  
  return(p)
}

#-------------------------------------------------------------------------------
#                         LA LIIGA 2024/2025
#-------------------------------------------------------------------------------

# Carreguem l'arxiu amb totes les dades dels partits de LA LIGA de la temporada 2024/2025 un data frame
data_df <- read.csv("ESP_2025_M_1st_team_fb_match_sts_passing_types.csv")

#Dibuixem el gràfic de distribució de córners
p <- plot_distribution_of_corners (data_df, 
                           titulo = "Freqüència de Córners per Partit - LA LIGA 2024-2025")
#Mostrem el gràfic
print (p)

# Guardem el plot com a imatge PNG
#ggsave("distribucio_corners_LA_LIGA_2024_2025.jpg", plot = p, width = 10, height = 6)



#-------------------------------------------------------------------------------
#                         LIIGA F 2024/2025
#-------------------------------------------------------------------------------

# Carreguem l'arxiu amb totes les dades dels partits de LA LIGA de la temporada 2024/2025 un data frame
data_df <- read.csv("ESP_2025_F_1st_team_fb_match_sts_passing_types.csv")

#Dibuixem el gràfic de distribució de córners
p <- plot_distribution_of_corners (data_df, 
                                   titulo = "Freqüència de Córners per Partit - LIGA F 2024-2025")
#Mostrem el gràfic
print (p)

# Guardem el plot com a imatge PNG
#ggsave("distribucio_corners_LIGA_F_2024_2025.jpg", plot = p, width = 10, height = 6)


#-------------------------------------------------------------------------------
#                         LA LIIGA 2023/2024
#-------------------------------------------------------------------------------

# Carreguem l'arxiu amb totes les dades dels partits de LA LIGA de la temporada 2024/2025 un data frame
data_df <- read.csv("ESP_2024_M_1st_team_fb_match_sts_passing_types.csv")

#Dibuixem el gràfic de distribució de córners
p <- plot_distribution_of_corners (data_df, 
                                   titulo = "Freqüència de Córners per Partit - LA LIGA 2023-2024")
#Mostrem el gràfic
print (p)

# Guardem el plot com a imatge PNG
#ggsave("distribucio_corners_LA_LIGA_2023_2024.jpg", plot = p, width = 10, height = 6)







