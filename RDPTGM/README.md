# RDPTGM
An Intelligent Non-equidistant Grey Model

# Programming Language
Matlab

# Quickstart Examples

1. Open '...\RDPTGM\main_document\main_RDPTGM.m' in MATLAB software.

2. Set parameters of mian_RDPTGM. m

nf: number of validation sets

data=xlsread('example data.xlsx','application') % read data

3. Run main_RDPTGM.m

4. Save the results in X0F

# Other files
'...\RDPTGM\main_document\main_compare.m' : Multiple model comparison calculation files (The output results are shown in Table 8 of the PDF) .

'...\RDPTGM\simulat\main_simulat.m' :  Simulation calculation file (The output results are shown in Table 4 of the PDF) .

'...\RDPTGM\main_document\WOA.m' :  Whale Optimization Algorithm (used to optimize hyperparameters of models).

'...\main_RDPTGM. m' ————————————main program

'...\PTGM. m' ————————————PTGM model

'...\DPTGM. m' —————————————DPTGM model

'...\RDPTGM.m' ————————RDPTGM model

'example data.xlsx' ————————————input data file



