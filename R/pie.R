pie_KEGG <- function (res){
  res_down <- subset(results, results$id == "DOWN")
  res_up <- subset(results, results$id == "UP")
  
  
  ## Percentage
  tl_up <- up %>%
    mutate(Pathway = factor(Pathway,
                            levels = Pathway [ length (Pathway):1]),
           cumulative = cumsum(N),
           midpoint = cumulative - N/2,
           labels = paste0 (round((N/sum(N)) * 100, 1), "%", "(", N, ")"))
  ## Percentage 
  tl_down <- down %>%
    mutate(Pathway = factor(Pathway,
                            levels = Pathway [ length (Pathway):1]),
           cumulative = cumsum(N),
           midpoint = cumulative - N/2,
           labels = paste0 (round((N/sum(N)) * 100, 1), "%", "(", N, ")"))
  
  
  ## Load blank theme for ggplot 
  blank_theme <- theme_minimal()+
    theme(
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      panel.border = element_blank(),
      panel.grid=element_blank(),
      axis.ticks = element_blank(),
      plot.title=element_text(size=20, face="bold")
    )
  
  
  # ggplot Pie Chart with percentage labels
  
  pc_up <- ggplot(tl_up, aes(x = "", y = N, fill = Pathway)) +
    geom_bar(width = 1, stat = "identity") +
    coord_polar(theta = "y", start = 0) +
    #scale_fill_manual(values = c("Blue", "Red", "Green", "Orange")) +
    labs(x = "", y = "", title = "Kegg Paths UP", fill = "Kegg Path", size = 30 ) + 
    geom_text(aes(x = 1.2, y = midpoint , label = labels), size = 6, color="black",
              fontface = "bold") +
    theme (plot.title = element_text(hjust = 0.5, size = 30 ),
           legend.title = element_text(hjust = 0.5, face="bold", size = 20),
           legend.text = element_text(size = 18, face = "bold"))
  
  p_up <- pc_up + blank_theme + theme(axis.text.x=element_blank())
  
  p_up + theme (plot.title = element_text(hjust = 0.5, size = 30 ),
                legend.title = element_text(hjust = 0.5, face="bold", size = 20),
                legend.text = element_text(size = 18, face = "bold"))# + blank_theme +
  
  
  pc_down <- ggplot(tl_down, aes(x = "", y = N, fill = Pathway)) +
    geom_bar(width = 1, stat = "identity") +
    coord_polar(theta = "y", start = 0) +
    #scale_fill_manual(values = c("Blue", "Red", "Green", "Orange")) +
    labs(x = "", y = "", title = "Kegg Paths DOWN", fill = "Kegg Path", size = 30 ) + 
    geom_text(aes(x = 1.2, y = midpoint , label = labels), size = 6, color="black",
              fontface = "bold") +
    theme (plot.title = element_text(hjust = 0.5, size = 30 ),
           legend.title = element_text(hjust = 0.5, face="bold", size = 20),
           legend.text = element_text(size = 18, face = "bold"))
  
  p_down <- pc_down + blank_theme + theme(axis.text.x=element_blank())
  
  p_down + theme (plot.title = element_text(hjust = 0.5, size = 30 ),
                  legend.title = element_text(hjust = 0.5, face="bold", size = 20),
                  legend.text = element_text(size = 18, face = "bold"))# + blank_theme +
  
  l <- list(p_up,p_down)
  l
}