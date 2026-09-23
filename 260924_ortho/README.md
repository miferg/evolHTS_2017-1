# Práctica de búsqueda de ortólogos y filogenómica

## Recursos

NSGTree (instalar)

https://github.com/NeLLi-team/nsgtree

iTOL

https://itol.embl.de/

## Preparar

```bash
conda create -q -y -n orthofinder -c bioconda -c conda-forge orthofinder
```

## buscar ortólogos y construir árbol filogenómico

### obtener y ordenar datos

extraer accessions

```bash
sed 1d smutans.genomes.tsv | awk -F"\t" '{print $2}' > accessions.txt
```
descargar

```bash
conda run -n ncbi_datasets datasets \
download genome accession --inputfile accessions.txt \
--include protein > download.log.txt 2>&1
```
descomprimir

``` bash
unzip -q ncbi_dataset.zip
```
crear direcotrio y crear links simbólicos

```bash
mkdir proteomes
```

```bash
cd proteomes; \
for ci in $(ls ../ncbi_dataset/data/*/*.faa); do \
acc=$(echo ${ci} | cut -f 4 -d"/"); \
cp -s ${ci} ./${acc}.faa; \
done
```

### buscar ortólogos

correr orthofinder

```bash
conda run -n orthofinder \
orthofinder \
-t 4 -o orthofinder_out \
-f proteomes/ > orthofinder.log.txt 2>&1 
```

### reconstrucción filogenómica con 56 marcadores universales

correr NSGTree

```bash
source ~/.bashrc; \
export PATH="${PATH}:/home/${USER}/.pixi/bin"; \
/home/${USER}/mbin/nsgtree/nsgt run \
/home/${USER}/clases/evolNGS_2027-1/260924_ortho/proteomes/ \
/home/${USER}/mbin/nsgtree/resources/models/UNI56.hmm -j 4 > nsgtree.log.txt 2>&1 
```

mover resultados

```bash
mkdir nsgtree_out
```

```bash
mv \
/home/${USER}/mbin/nsgtree/nsgt_out/proteomes--UNI56-veryfasttree-minmarkerPerc10_20260923_135313 \
nsgtree_out/
```

### Anotación para iTOL

cargar tabla de genomas

```python
smgenomes = pd.read_csv('smutans.genomes.tsv', sep='\t')
smgenomes.info()
```
cambiar nombres

```python
with open('smgenomes.names.itol.txt', 'w') as outfile:
    outfile.write('LABELS\nSEPARATOR SPACE\nDATA\n')
    for ci,crow in smgenomes.iterrows():
        outfile.write(crow['Assembly Accession'] +' '+
                      crow['Organism Name'].replace(' ','_') +'_'+ 
                      crow['Organism Infraspecific Names Strain']+'_'+
                      crow['Assembly Accession'] +'\n')
```
heatmap con tamaño de genoma en Mb

```python
with open('smgenomes.size-heatmap.itol.txt','w') as outfile:
    outfile.write('DATASET_HEATMAP\nSEPARATOR SPACE\nDATASET_LABEL Size\nCOLOR #E77577\n') # label
    outfile.write('FIELD_LABELS Size\n') # label
    outfile.write('COLOR_MIN #FFFFFF\nCOLOR_MAX #E77577\nSHOW_LABELS 1\nDATA\n')
    for ci,crow in smgenomes.iterrows():
        outfile.write(crow['Assembly Accession'] +' '+ 
                      str(crow['Assembly Stats Total Sequence Length']/1000000) +'\n')
```


