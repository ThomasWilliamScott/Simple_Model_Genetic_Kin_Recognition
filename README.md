# Simple_Model_Genetic_Kin_Recognition
This repository contains all supplementary code for Scott &amp; Grafen (unpublished).

This repository contains: (i) code for generating data; (ii) saved data; (iii) code for generating figures (by loading and plotting the saved data).

Two of the scripts are for generating data: 'Script_for_generating_heatmap_data.m' generates equilibrium data for a range of parameter values; 'Script_for_deriving_pSoT_and_wSoT.m' derives the p_SoT and w_SoT expressions that feature in the 'separation of timescales' analysis. 

Seven of the scripts store saved data. Six of these scripts save data that was generated using the 'Script_for_generating_heatmap_data.m' script. An example script of this type is: 'Tag = 10. T = 100000. csearch = 0.0001. alpha = 1. mu = 0.0005. tagSkewIni = 0.9. b = 0.3. c = 0.1. helpini = 0.1 .mat'. The other scripts are named using this format (i.e., stating the parameter values used to generate the data). 

One of the saved data scripts is named 'Symbolic_Expressions.mat', and this script saves the output of the 'Script_for_deriving_pSoT_and_wSoT.m' script - i.e. it saves the symbolic expressions for p_SoT and w_SoT.

Seven of the scripts are for generating figures. Code is provided for all figures in the text, except for figures that were made without data, on powerpoint. These scripts are named using the format 'Generate_Fig_X.m'
