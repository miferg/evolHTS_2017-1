# Práctica de criterios de informacón

Instalar scipy

``` python
pip install scipy
```

Cargar librerías

``` python
import math
from scipy.stats import chi2, binom
```

Función de masa de probabilidad de la distribución binomial:

``` python
k = 'éxitos'
n = 'eventos'
q = 'probabilidad de éxito'

binom.pmf(k, n, q)
```

Función de densidad de probabilidad de la distribución χ<sup>2</sup>:

``` python
chisq = 'estadístico'
df = 'grados de libertad'

chi2.pdf(chisq, df)
```

Instalar ambiente con IQ-TREE

```
conda create -y -q -n phylo -c bioconda iqtree=3.1.3
```

Agregar modeltest

```
conda run -n phylo conda install -y -q bioconda::modeltest-ng
```
