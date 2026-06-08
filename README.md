# Benchmark_dbNSFP_OCDCTD
The contents of this repo are the code and data files used to do a rare variant analysis on a cohort of OCDCTD cases. 
Please contact belinda.wang@ucsf.edu or evan.marshman@ucsf.edu for further questions. 

# Repo Layout
### Variant_Pred_tools.txt
Notes on the various annotation tools available for missense variant annotation

### Data.zip
Data files utilized or created in the process of doing the rare variant analysis. 

*Note: The original .rda file that contains the cohort variants data can be acquired through contacting above emails.*

### Scripts
#### OCD_paper_code.ipynb
Used for exploratory analysis on original paper (https://pubmed.ncbi.nlm.nih.gov/41282685/)
#### VEP_prep.R
Used for prepping the dataset for a VEP run
#### vep_result_processing.Rmd
Used to process the vep results and prepare data files
#### Data_Processing.ipynb
Used in conjunction with vep_results_processing.Rmd for data file preparation
#### EDA_Annotations.Rmd
Used to explore the various annotations and make individualized plots for each
#### Burden_Test_OCDCTD.qmd
Used to run burden tests with the various annotation tools
#### BenchmarkApp.R
Shiny app that builds on top of Burden_Test_OCDCTD.qmd for easier data visualization of all thresholds across all annotation tools
