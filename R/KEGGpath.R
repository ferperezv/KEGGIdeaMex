KEGGpath <- function(x){
  #Selecting file and editing column names
  input <- read.csv(x, header=F, sep="")
  colnames(input) <- c("Gene", "DE")
  
  #Subsetting by up and down regulated
  up <- subset(input, DE == "UP")
  down <- subset(input, DE =="DOWN")
  
  #Convert to vectors, function kegga only accepts vectors as input
  up_genes <- as.vector(up$Gene)
  down_genes <- as.vector(down$Gene)
  
  #Consulting KEGG, getting top represented pathways
  kegg_up <- kegga(up_genes, species.KEGG ="gsu")
  kegg_down <- kegga(down_genes, species.KEGG = "gsu")
  
  #Sorting by column DE, to get top pathways represented
  top_down <- kegg_down[order(-kegg_down$DE),]
  top_up <- kegg_up[order(-kegg_up$DE),]
  
  #Remove unwanted columns and rename pre-existing ones.
  top_down<- top_down[,c(1,3)]
  top_up<- top_up[,c(1,3)]
  colnames(top_down) <- c("Pathway", "N")
  colnames(top_up) <- c("Pathway", "N")
  
  #Get top10
  top10_down<- top_down[1:10,]
  top10_up<- top_up[1:10,]
  
  return(top10_down, top10_up)
  
}