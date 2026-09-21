# Práctica de anotación genómica

## preparar ambiente

agregar seqtk a ambiente msadiv

``` bash
conda run -n msadiv \
conda install -c bioconda -c conda-forge \
seqtk \
-y -q
```

## recursos

Skylign

https://skylign.org/

Prodigal

https://github.com/hyattpd/Prodigal/releases/

## filtrar resultados de blast, construir modelo y anotar

### filtrar

cargar librerías de python

``` python3
import matplotlib.pyplot as plt
```

cargar tabla de blast

``` python3
blout = pd.read_csv('strepto_adhesin__uniprot_1300.tsv', 
            header=None, sep='\t')
blout.columns = ['qseqid','sseqid','pident','length',
                 'mismatch','gapopen','qstart','qend',
                 'sstart','send','evalue','bitscore','qcovs']
blout.info()
```

graficar

``` python3
blout.plot.scatter('qcovs','pident', alpha=0.5)
plt.axhline(y=80, color='grey', linestyle=':')
plt.axvline(x=90, color='grey', linestyle=':')
```

extraer nombres

``` python3
blout.loc[(blout['qcovs']>=90)&
    (blout['pident']>=80),'sseqid'].to_csv('strepto_adhesin__uniprot_1300.qc90_pi80.txt',
                                           index=False, header=False)
```

extraer secuencias

``` bash
conda run -n msadiv \
seqtk subseq uniprotkb_taxonomy_id_1300_AND_existenc_2026_09_09.fasta \
strepto_adhesin__uniprot_1300.qc90_pi80.txt > strepto_adhesin__uniprot_1300.qc90_pi80.faa
```

### construir modelo

alinear

``` bash
conda run -n msadiv \
mafft --thread 2 strepto_adhesin__uniprot_1300.qc90_pi80.faa > \
s_adhesin__uni1300.qc90_pi80.mafft.faa
```

construir modelo de markov

``` bash
conda run -n msadiv \
hmmbuild -o hmmbuild.log.txt -n s_mutans_adhesin --cpu 2 \
s_adhesin__uni1300.hmm s_adhesin__uni1300.qc90_pi80.mafft.faa
```

### predecir genes

``` bash
./prodigal.linux -a GCA_002995555.1_ASM299555v1_genomic.faa \
-d GCA_002995555.1_ASM299555v1_genomic.cds.fna \
-f gff -o GCA_002995555.1_ASM299555v1_genomic.gff \
-i GCA_002995555.1_ASM299555v1_genomic.fna
```

### anotar

buscar modelo en genes predichos

``` bash
conda run -n msadiv \
hmmsearch --tblout GCA_002995555.1__s_adhesin__uni1300.txt \
-o hmmsearch.log.txt \
s_adhesin__uni1300.hmm GCA_002995555.1_ASM299555v1_genomic.faa
```

leer resultados en python

``` python3
cols = ['target_name', 'accession_target', 'query_name', 
        'accession_query', 'E_value_full', 'score_full', 
        'bias_full', 'E_value_bestd', 'score_bestd', 'bias_bestd',
        'exp', 'reg', 'clu', 'ov', 'env', 'dom', 'rep', 'inc']
        #'description_of_target']
tmp = pd.read_csv('GCA_002995555.1__s_adhesin__uni1300.txt', header=None,
    sep='~', names=['line'], comment='#')
hmmout  = tmp['line'].str.split(expand=True, n=len(cols)-1)
hmmout.columns = cols
hmmout.info()
```
