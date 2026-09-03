# Practica de Metodos de reconstruccion filogenetica

Funcion para calcular probabilidad posterior con base en vectores

``` python
def posterior_over_q(k, n, q_grid):
    # Usamos log-verosimilitud para evitar problemas numéricos
    log_likelihood = k * np.log(q_grid) + (n - k) * np.log(1 - q_grid)
    
    # Prior uniforme sobre la rejilla de q
    log_prior = np.zeros_like(q_grid)
    
    log_posterior = log_likelihood + log_prior
    
    # Normalización estable
    log_posterior = log_posterior - np.max(log_posterior)
    posterior = np.exp(log_posterior)
    posterior = posterior / posterior.sum()
    
    return posterior
```

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
