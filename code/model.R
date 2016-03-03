
train <- left_join(train[complete.cases(train), ], features)
test <- features[366:729,-1]; Dtest <- xgb.DMatrix(data=data.matrix(test), missing=NA)

# A
Dtrain <- xgb.DMatrix(data=data.matrix(train[,7:ncol(train)]), label=log(1+train$A), missing=NA)

res <- xgb.gridsearch(eta = 0.01, gamma = 1, max_depth = 2, min_child_weight = 1, colsample_bytree = c(0.2, 0.4, 0.6, 0.8, 1),subsample = c(0.5,0.75,0.9), 
               objective = 'reg:linear',data=Dtrain, nfold=5, verbose = 0, nthread=4, nrounds=1000)

res <- rbind(res,xgb.gridsearch(eta = 0.01, gamma = 1, max_depth = 1, min_child_weight = 1, colsample_bytree = c(0.2, 0.4, 0.6, 0.8, 1),subsample = c(0.5,0.75,0.9), 
                      objective = 'reg:linear',data=Dtrain, nfold=5, verbose = 0, nthread=4, nrounds=1000))

res <- rbind(res,xgb.gridsearch(eta = 0.01, gamma = 1, max_depth = 3, min_child_weight = 1, colsample_bytree = c(0.2, 0.4, 0.6, 0.8, 1),subsample = c(0.5,0.75,0.9), 
                                objective = 'reg:linear',data=Dtrain, nfold=5, verbose = 0, nthread=4, nrounds=1000))

res <- rbind(res,xgb.gridsearch(eta = 0.01, gamma = 1, max_depth = 5, min_child_weight = 1, colsample_bytree = c(0.2, 0.4, 0.6, 0.8, 1),subsample = c(0.5,0.75,0.9), 
                                objective = 'reg:linear',data=Dtrain, nfold=5, verbose = 0, nthread=4, nrounds=1000))

res <- rbind(res,xgb.gridsearch(eta = 0.01, gamma = 1, max_depth = 6, min_child_weight = 1, colsample_bytree = c(0.2, 0.4, 0.6, 0.8, 1),subsample = c(0.5,0.75,0.9), 
                                objective = 'reg:linear',data=Dtrain, nfold=5, verbose = 0, nthread=4, nrounds=1000))

res <- rbind(res,xgb.gridsearch(eta = 0.01, gamma = 1, max_depth = 6, min_child_weight = c(1:11), colsample_bytree = 0.8,subsample = 0.75, 
                                objective = 'reg:linear',data=Dtrain, nfold=5, verbose = 0, nthread=4, nrounds=1000))


parameters <- list(booster='gbtree', objective = 'reg:linear',
                   eta = 0.01, subsample = 0.75,
                   colsample_bytree = 0.8,
                   max_depth = 6,
                   min_child_weight = 2,
                   nthread=4)
set.seed(23)
model = xgb.train(params=parameters, Dtrain, nrounds = 1000)
sample_submit[,2] = exp(predict(model, Dtest))-1

# B
Dtrain <- xgb.DMatrix(data=data.matrix(train[,7:378]), label=log(1+train$B), missing=NA)
parameters <- list(booster='gbtree', objective = 'reg:linear',
                   eta = 0.01, subsample = 0.9,
                   colsample_bytree = 0.5,
                   max_depth = 2,
                   eval.metric='rmse',
                   nthread=4) 
set.seed(23)
model = xgb.train(params=parameters, Dtrain, nrounds = 1000)
sample_submit[,3] = exp(predict(model, Dtest))-1

# C
Dtrain <- xgb.DMatrix(data=data.matrix(train[,7:378]), label=log(1+train$C), missing=NA)
parameters <- list(booster='gbtree', objective = 'reg:linear',
                   eta = 0.01, subsample = 0.9,
                   colsample_bytree = 0.5,
                   max_depth = 2,
                   eval.metric='rmse',
                   nthread=4) 
set.seed(23)
model = xgb.train(params=parameters, Dtrain, nrounds = 1000)
sample_submit[,4] = exp(predict(model, Dtest))-1

# D
Dtrain <- xgb.DMatrix(data=data.matrix(train[,7:378]), label=log(1+train$D), missing=NA)
parameters <- list(booster='gbtree', objective = 'reg:linear',
                   eta = 0.01, subsample = 0.9,
                   colsample_bytree = 0.5,
                   max_depth = 2,
                   eval.metric='rmse',
                   nthread=4) 
set.seed(23)
model = xgb.train(params=parameters, Dtrain, nrounds = 1000)
sample_submit[,5] = exp(predict(model, Dtest))-1

# E
Dtrain <- xgb.DMatrix(data=data.matrix(train[,7:378]), label=log(1+train$E), missing=NA)
parameters <- list(booster='gbtree', objective = 'reg:linear',
                   eta = 0.01, subsample = 0.9,
                   colsample_bytree = 0.5,
                   max_depth = 2,
                   eval.metric='rmse',
                   nthread=4) 
set.seed(23)
model = xgb.train(params=parameters, Dtrain, nrounds = 1000)
sample_submit[,6] = exp(predict(model, Dtest))-1

# save
write.table(sample_submit, 'submissions/sub-2.csv', 
            quote=F, sep = ',', row.names=F, col.names=F)


