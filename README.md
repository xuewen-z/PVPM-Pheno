# PVPM-Pheno
the model code
Our model is runned under Linux envirornment in MATLAB software. Windows may work after Proc12.



# A prognostic model to predict seasonal maximum and dynamics of global leaf area index using climate variables

·Function file：

Budyko2LAI : The core function of our PVPM, it discribes equations for simulating the annual sum LAI. 
SGPD2SLAI : The core function of our PVPM, it discribes equations for simulating the steady-state LAI.
SLAI2TLAI : The core function of our PVPM, it discribes equations for simulating the actual LAI time series.
Met2IGSI : The core function of our PVPM, it discribes equations for simulating GSI.
ParamAlpha : The global parameters of our PVPM for multi-biome.  You can re-calibrate the parameters according to different input data or researches using Code 19..
ParamAlphaFlx : The parameters of our PVPM for multi-biome at the site scale, and the parameterization process can be found in Code Proc19_CaliAlphaUniq. 
ParamSGPD : The parameters of our previous semi-prognostic model. 
Rest functions used to support other data processing code.

·Code File: 
Data pre-processes of meteological input data(GDAL00~Proc12), MODIS validate data (Proc21~Proc22)and two CIMP6 models (Proc26~Proc33).
Proc13~Proc16: Data processes of meterological data and MODIS data used to calibrate model parameters.
Proc17~Proc18 : Randomly choosing 36,000 pixels (4000 pixels randomly per PFT) used to calibrate our PVPM.
Proc19 : Model calibration process on both site and global scales. If you have input data with different spatial resolution, you can re-calibrate parameters by this code. 
Proc23_GlobMLAIx : The core code of our PVPM, it can directly simulate the seasonal maximum LAI on a global scale, including Function ParamAlpha and Budyko2LAI .
Proc51_SLAI15DE1 : The core code of our PVPM, it can directly simulate the global steady-state LAI.
Proc52_TLAI15DE1 : The core code of our PVPM, it can directly predict actual LAI time series by seasonal maximum LAI limiting steady-state LAI, including Function ParamSGPD and SLAI2TLAI.

There are similar deal processes to simulate maximum LAI and LAI time series at a site scale.
Proc40~Proc46 : Date process for Fluxtower site and in-situ LAI; The seasonal maximum LAI simulate process.
Proc50_FlBdko2LAI : Predicting actual LAI time series.

The rest codes are data analysis processes of this experiment.

·Demo File: Taking  Fluxtower DATA as model input data, it can directly predict the seasonal maximum LAI andLAI time series.
input file : Elvation data and Meterological data  as input data.  
code file :  Run in the following order: Proc 41, Proc 43 and Proc 50.
output file : output the seasonal maximum LAI andLAI time series results. 

We directly provide the modelling results of Proc51 owing daily Meterological dataset on a global scale is too much to upload, if you need that, please contact with authors.
