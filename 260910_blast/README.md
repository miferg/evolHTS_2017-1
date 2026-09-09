# Práctica de BLAST

Ambiente de anaconda

```bash
conda create -n genes \
-c conda-forge -c bioconda \
blast \
-y -q
```

Crear base de datos

```bash
conda run -n genes \
makeblastdb \
-in uniprotkb_taxonomy_id_1300_AND_existenc_2026_09_09.fasta -dbtype "prot" \
-out uniprot_1300
```

Correr blastp

```bash
conda run -n genes \
blastp \
-query strepto_adhesin.faa \
-db uniprot_1300 \
-evalue 1e-100 \
-outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs" \
-out strepto_adhesin__uniprot_1300.tsv
```

Correr psi-blast

```bash
conda run -n genes \
psiblast \
-query strepto_adhesin.faa \
-db uniprot_1300 \
-num_iterations 3 \
-evalue 1e-100 \
-inclusion_ethresh 1e-100 \
-outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs" \
-out_ascii_pssm strepto_adhesin__uniprot_1300.3.pssm \
-out strepto_adhesin__uniprot_1300.psi.tsv
```
