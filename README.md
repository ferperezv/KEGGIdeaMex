# KEGGIdeaMex

## Description

This pipeline was created in the [CDSB-Mexico 2018](http://www.comunidadbioinfo.org/r-bioconductor-developers-workshop-2018/) by request of Leticia Vega and Veronica Jimenez.

The pipeline takes as input a list of genes (NCBI gene Ids) differentially expressed and creates descriptive plots.

## Input

### List of genes
The pipeline takes as input plaint text files with the next structure:

    6083	UP
    26804	UP
    2224	UP
    8431	UP
    30836	UP
    6924	DOWN
    6464	DOWN
    3399	DOWN
    148327	DOWN
    6278	DOWN

The first colum is the NCBI gene id and the second column if the gene is UP (up-expressed) or DOWN (down-expressed).

### Species KEGG id

Select from the KEGG database the three letter code for the species who belong the genes id. Check the complete KEGG species IDs in the next url: [link](https://www.kegg.jp/kegg/catalog/org_list.html).

### Number of pathways to plot

Declare the number of pathways to plot.

## Output example

The package generates the next class of plots:

![Ejemplo de archivo de salida numero 1](https://github.com/FRPV/KEGG_ideaMex/blob/master/output_example1.png)


![Ejemplo de archivo de salida numero 1](https://github.com/FRPV/KEGG_ideaMex/blob/master/output_example2.png)


## Developers
 - Irving García
 - Lorena J. Gómez
 - Bernardo M. Quiroga
 - Fernando Pérez

