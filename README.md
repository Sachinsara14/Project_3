# 📉 Project 3: V-Plot Matrix Generator

**Goal:** Visualize the relationship between DNA fragment size and genomic position. This tool generates a "Long Form" matrix from raw sequencing data (BED format) and visualizes the fragment length distribution as a heatmap. It is designed to handle massive genomic datasets by streaming data and using memory-efficient plotting techniques.

### 🚀 Key Features
* **Stream Processing:** Reads raw BED data via standard input (pipes), avoiding the need to load massive files into RAM.
* **Matrix Generation:** Converts raw genomic intervals into a frequency matrix (Offset, Length, Count).
* **Scalable Visualization:** The R script includes logic to handle large genomic coordinates automatically, generating a readable heatmap even without relative centering.

### 📂 File Structure

| File | Language | Description |
| :--- | :--- | :--- |
| `vplot_matrix.py` | Python | Reads piped BED data, calculates fragment centers/lengths, and outputs a long-form matrix. |
| `vplot_graph.R` | R | Reads the matrix and generates a heatmap using `ggplot2`. Includes auto-scaling for genomic coordinates. |

### 🛠 Prerequisites
* Python 3
* R (Libraries: `ggplot2`)
* Standard tools: `zcat`

### ⚙️ Usage

#### 1. Generate the Matrix & Plot
Run the entire pipeline in a single command using pipes. This example uses `shuf.a.bed.gz` as the input.

```bash
zcat shuf.a.bed.gz | python3 vplot_matrix.py > matrix_long_form.tsv && Rscript vplot_graph.R
```
#### Output files
`matrix_long_form.tsv`
`vplot_result.png`
