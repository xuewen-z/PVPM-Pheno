# A prognostic vegetation phenology model to predict seasonal maximum and dynamics of global leaf area index using climate variables
Our model is runned under Linux envirornment in MATLAB software. Windows may work after Proc12.

 ## Function file：

- __Budyko2LAI:__ The core function of our PVPM, it discribes equations for simulating the annual sum LAI. 

- __SGPD2SLAI:__ The core function of our PVPM, it discribes equations for simulating the steady-state LAI.

- __SLAI2TLAI:__ The core function of our PVPM, it discribes equations for simulating the actual LAI time series.

- __Met2IGSI:__ The core function of our PVPM, it discribes equations for simulating GSI.

- __ParamAlpha:__ The global parameters of our PVPM for multi-biome.  You can re-calibrate the parameters according to different input data or researches using Code Proc19_CaliAlpha.

- __ParamAlphaFlx:__ The parameters of our PVPM for multi-biome at the site scale, and the parameterization process can be found in Code Proc19_CaliAlphaUniq. 

- __ParamSGPD:__ The parameters of our previous semi-prognostic model. 

Rest functions used to support other data processing code.


 ## Code file:

- __GDAL00 to Proc12,Proc21 to Proc22 and Proc26 to Proc33:__ Data pre-processes of meteological input data, MODIS validate data and two CIMP6 models.

- __Proc13~Proc16:__ Data processes of meterological data and MODIS data used to calibrate model parameters.

- __Proc17~Proc18:__ Randomly choosing 36,000 pixels (4000 pixels randomly per PFT) used to calibrate our PVPM.

- __Proc19:__ Model calibration process on both site and global scales. If you have input data with different spatial resolution, you can re-calibrate parameters by this code. 

- __Proc23_GlobMLAIx:__ The core code of our PVPM, it can directly simulate the seasonal maximum LAI on a global scale, including Function ParamAlpha and Budyko2LAI.

- __Proc51_SLAI15DE1:__ The core code of our PVPM, it can directly simulate the global steady-state LAI, including Function SGPD2SLAI.

- __Proc52_TLAI15DE1:__ The core code of our PVPM, it can directly predict actual LAI time series by seasonal maximum LAI limiting steady-state LAI, including Function ParamSGPD and SLAI2TLAI.

There are similar deal processes to simulate maximum LAI and LAI time series at a site scale.

- __Proc40~Proc46:__ Date process for Fluxtower site and in-situ LAI; The seasonal maximum LAI simulate process.

- __Proc50_FlBdko2LAI:__ Predicting actual LAI time series.

The rest codes are data analysis processes of this experiment.


 ## Demo File: Taking  Fluxtower DATA as model input data, it can directly predict the seasonal maximum LAI andLAI time series.

- __input file:__ Elvation data and Meterological data as input data.  

- __code file:__  Run in the following order: Proc 41, Proc 43 and Proc 44.

- __output file:__ output the seasonal maximum LAI andLAI time series results. 

Owing daily Meterological dataset on a global scale is too much to upload, if you need that, please contact with authors.
