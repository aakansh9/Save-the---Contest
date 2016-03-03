# booster = 'gbtree', 

xgb.gridsearch <- function(eta, gamma, max_depth, min_child_weight, subsample, colsample_bytree, # parameters
                           objective = 'reg:linear', # task parameters
                           data, # Dmatrix 
                           nrounds,
                           nfold,
                           prediction = F, # a logical value indicating whether to return the prediction vector
                           metrics = list(), # list of evaluation metrics to be used in corss validation
                           obj=NULL, # customized objective function
                           feval=NULL, # custimized evaluation function
                           verbose = 1, # boolean, print the statistics during the process
                           print.every.n = 1,
                           maximize=NULL,
                           early.stop.round=NULL,
                           nthread=4){
  
  xgb_grid = as.data.frame(expand.grid(
    eta = eta,
    gamma=gamma,
    max_depth = max_depth,
    min_child_weight=min_child_weight,
    subsample = subsample,
    colsample_bytree = colsample_bytree))
  
  print(paste0('There are ',nrow(xgb_grid),' rows in grid'))
  res <- list()
  
  for(r in 1:nrow(xgb_grid)){
    
    print(paste0('... iteration ', r))
    
    param <- c(booster='gbtree', 
              objective = objective,
              xgb_grid[r, ] %>% unlist %>% as.list,
              nthread=nthread) 
    
    hist = xgb.cv(params=param, data=data, nfold = nfold, nrounds=nrounds,prediction=prediction,
           metrics=metrics, obj=obj, feval=feval, verbose=verbose, print.every.n=print.every.n,
           maximize=maximize, early.stop.round=early.stop.round)
    
    res[[r]] <- hist[nrow(hist), ]
    
  }
  
  xgb_grid <- cbind(xgb_grid, data.frame(do.call(rbind, res)))
  
  return(xgb_grid)
  
}


