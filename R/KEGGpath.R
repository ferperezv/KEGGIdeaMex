#' @export
#' @import edgeR
#' @param x A txt file with two columns: one with the Entrez Gene ID and another with the tag UP or DOWN.
#' @param species A character string with the three letter code from KEGG specifying the organism. You can check the list here: \code{\link{https://www.kegg.jp/kegg/catalog/org_list.html}
#' @param n An integer number indicating how many pathways per condition (UP/DOWN) the user wants. 
#' @examples:
#' x <- "~/de.txt"
#' species <- "gsu"
#' n <- 10
#' 
#' results <- KEGGpath(x, species, n)

KEGGpath <- function(x, species, n){
  #Selecting file and editing column names
  input <- read.csv(x, header=F, sep="")
  colnames(input) <- c("Gene", "DE")

  #Convert
  sp <- as.character(species)

  #Subsetting by up and down regulated
  up <- subset(input, DE == "UP")
  down <- subset(input, DE =="DOWN")

  #Convert to vectors, function kegga only accepts vectors as input
  up_genes <- as.vector(up$Gene)
  down_genes <- as.vector(down$Gene)

  #Consulting KEGG, getting top represented pathways
  kegg_up <- kegga(up_genes, species.KEGG = sp)
  kegg_down <- kegga(down_genes, species.KEGG = sp)

  #Sorting by column DE, to get top pathways represented
  top_down <- kegg_down[order(-kegg_down$DE),]
  top_up <- kegg_up[order(-kegg_up$DE),]

  #Remove unwanted columns and rename pre-existing ones.
  top_down<- top_down[,c(1,3)]
  top_up<- top_up[,c(1,3)]
  colnames(top_down) <- c("Pathway", "N")
  colnames(top_up) <- c("Pathway", "N")

  #Get top10
  top10_down <- top_down[1:n,]
  top10_down <- top10_down[which(top10_down$N > 0),]
  top10_up <- top_up[1:n,]
  top10_up <- top10_up[which(top10_up$N > 0),]
  if (nrow(top10_up) > 0 && nrow(top10_down) > 0){
      id <- c(rep("DOWN", nrow(top10_up)), rep("UP", nrow(top10_down)))
      top_all <- rbind(top10_down, top10_up)
      results <- cbind(top_all, id)
      rownames(results) <- c()
      return(results)
  }
  if (nrow(top10_up) > 0 && nrow(top10_down) == 0){
    id <- rep("UP", nrow(top10_up))
    top_all <- top10_up
    results <- cbind(top_all, id)
    rownames(results) <- c()
    return(results)
  }
  if (nrow(top10_up) == 0 && nrow(top10_down) > 0){
    id <- rep("DOWN", nrow(top10_up))
    top_all <- top10_down
    results <- cbind(top_all, id)
    rownames(results) <- c()
    return(results)
  }
}
