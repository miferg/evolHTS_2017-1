# Práctica de alineamiento genómico

Portal de genomas del NCBI

https://www.ncbi.nlm.nih.gov/datasets/genome/

Ambiente para descargar genomas y otros datos del NCBI

```
conda create -n ncbi_datasets \
-c conda-forge ncbi-datasets-cli
-y -q
```

Ambiente para alinear genomas

```
conda create -n genome-align \
-c conda-forge -c bioconda \
mummer4 progressivemauve seqkit gnuplot imagemagick \
-y -q
```

Crear parche para promer

```
conda_env=$(conda run -n genome-align which promer | sed 's/\/bin\/promer//'); \
cp ${conda_env}/bin/promer ${conda_env}/bin/promer.fixed; \
sed -i \
-e "s#@LIBEXEC_DIR@#${conda_env}/libexec/mummer#g" \
-e "s#@LIBEXEC_DIR#${conda_env}/libexec/mummer#g" \
-e "s#@AUX_BIN_DIR@#${conda_env}/libexec/mummer#g" \
-e "s#@AUX_BIN_DIR#${conda_env}/libexec/mummer#g" \
-e "s#@BIN_DIR@#${conda_env}/bin#g" \
-e "s#@BIN_DIR#${conda_env}/bin#g" \
${conda_env}/bin/promer.fixed 
```

Visualización de alineamiento de genomas

https://miferg.github.io/mauve-viewer/
