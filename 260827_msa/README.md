# Práctica de alineamiento múltiple de secuencias

Instalar ambiente de jupyter

```
conda create -n jupyter jupyterlab
```

Iniciar jupyter

```
conda activate jupyter
jupyter lab --no-browser
```

Instalar ambiente de anaconda para el análisis

```
conda create -y -q -n msadiv -c conda-forge -c bioconda clustalw mafft infernal hmmer tn93
```

Ejecutar comandos de anaconda sin activar un ambiente

```
conda run -n [ambiente] [comando]
```

Otros:

[Modelo de covarianza de SSU bacteriano](https://rfam.org/family/RF00177)
