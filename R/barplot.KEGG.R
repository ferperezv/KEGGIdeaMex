#'  @export 
#'  @import ggplot2 
#'  @param results A data frame with three columns: the first column contains the names of the enriqued pathways, the second column the number of genes and the third column 
#  specifies DOWN or UP.
#'  @examples 
#'  barplot.KEGG(results)


barplot.KEGG <- function (results){
  results[results$id== "DOWN",2] <- results[results$id== "DOWN",2]*(-1)
  ggplot(results,aes(y=N,x=Pathway,fill=id))+
    geom_bar(stat='identity')+
    scale_y_continuous(breaks = pretty(results[,2]), labels = abs(pretty(results[,2])))+
    coord_flip()+theme_update()+
    scale_fill_manual(values = c('#ff2a2a','#0072B2'))+
    xlab('KEGG Pathway')+
    ylab('Number of Genes')+
    theme(axis.text = element_text(color='black'))
}
