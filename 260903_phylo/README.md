# Practica de Metodos de reconstruccion filogenetica

Instalar ambiente con BEAST

``` bash
conda create -n phylo-bayes -q -y -c conda-forge -c bioconda \
beast2=2.6.3 r-base=4.3 r-coda r-ape r-seqinr
```

Instalar libreria de R

``` bash
conda run -n phylo-bayes \
Rscript -e 'install.packages("beautier", \
repos=c("https://ropensci.r-universe.dev", \
"https://cloud.r-project.org"))' > rscript.log.txt 2>&1
```

Servidor para visualizar arboles

https://itol.embl.de
