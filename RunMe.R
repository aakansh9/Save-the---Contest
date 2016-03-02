# R version 3.1.2 (2014-10-31)
# Platform: x86_64-apple-darwin13.4.0 (64-bit)

require(dplyr) # 0.4.3
require(tidyr) # 0.4.1
require(xgboost) # 0.4-2

main_path = '~/Projects/Tofu-pred/'
setwd(main_path)

source('code/clean.R')
source('code/featurize.R')
dir.create('submissions', recursive = T)
source('code/model.R')