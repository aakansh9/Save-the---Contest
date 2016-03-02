
Train <- left_join(train[complete.cases(train), ], features)
test <- features[366:729,-1]; Dtest <- xgb.DMatrix(data=data.matrix(test), missing=NA)

# A
Dtrain <- xgb.DMatrix(data=data.matrix(Train[,7:378]), label=log(1+Train$A), missing=NA)
parameters <- list(booster='gbtree', objective = 'reg:linear',
                   eta = 0.01, subsample = 0.9,
                   colsample_bytree = 0.5,
                   max_depth = 2,
                   eval.metric='rmse',
                   nthread=4) # train-rmse:0.115693+0.003421  test-rmse:0.219381+0.020862
#xgb.cv(params=parameters, Dtrain, nrounds = 1000, nfold = 5)
model = xgb.train(params=parameters, Dtrain, nrounds = 955, nfold = 5, seed=23)
#xgb.importance(names(Train[,7:378]), model=model)
sample_submit[,2] = exp(predict(model, Dtest))-1

# B
Dtrain <- xgb.DMatrix(data=data.matrix(Train[,7:378]), label=log(1+Train$B), missing=NA)
parameters <- list(booster='gbtree', objective = 'reg:linear',
                   eta = 0.01, subsample = 0.9,
                   colsample_bytree = 0.5,
                   max_depth = 2,
                   eval.metric='rmse',
                   nthread=4) # train-rmse:0.087071+0.001089  test-rmse:0.169511+0.024354
#xgb.cv(params=parameters, Dtrain, nrounds = 1000, nfold = 5)
model = xgb.train(params=parameters, Dtrain, nrounds = 1000, nfold = 5, seed=23)
sample_submit[,3] = exp(predict(model, Dtest))-1

# C
Dtrain <- xgb.DMatrix(data=data.matrix(Train[,7:378]), label=log(1+Train$C), missing=NA)
parameters <- list(booster='gbtree', objective = 'reg:linear',
                   eta = 0.01, subsample = 0.9,
                   colsample_bytree = 0.5,
                   max_depth = 2,
                   eval.metric='rmse',
                   nthread=4) # train-rmse:0.151792+0.023071  test-rmse:0.385241+0.231984
#xgb.cv(params=parameters, Dtrain, nrounds = 1000, nfold = 5)
model = xgb.train(params=parameters, Dtrain, nrounds = 1000, nfold = 5, seed=23)
sample_submit[,4] = exp(predict(model, Dtest))-1

# D
Dtrain <- xgb.DMatrix(data=data.matrix(Train[,7:378]), label=log(1+Train$D), missing=NA)
parameters <- list(booster='gbtree', objective = 'reg:linear',
                   eta = 0.01, subsample = 0.9,
                   colsample_bytree = 0.5,
                   max_depth = 2,
                   eval.metric='rmse',
                   nthread=4) # train-rmse:0.095458+0.004299  test-rmse:0.191040+0.020006
#xgb.cv(params=parameters, Dtrain, nrounds = 1000, nfold = 5)
model = xgb.train(params=parameters, Dtrain, nrounds = 1000, nfold = 5, seed=23)
sample_submit[,5] = exp(predict(model, Dtest))-1

# E
Dtrain <- xgb.DMatrix(data=data.matrix(Train[,7:378]), label=log(1+Train$E), missing=NA)
parameters <- list(booster='gbtree', objective = 'reg:linear',
                   eta = 0.01, subsample = 0.9,
                   colsample_bytree = 0.5,
                   max_depth = 2,
                   eval.metric='rmse',
                   nthread=4) # train-rmse:0.117457+0.003942  test-rmse:0.227078+0.020919
#xgb.cv(params=parameters, Dtrain, nrounds = 1000, nfold = 5)
model = xgb.train(params=parameters, Dtrain, nrounds = 1000, nfold = 5, seed=23)
sample_submit[,6] = exp(predict(model, Dtest))-1

# save
write.table(sample_submit, 'submissions/sub-1.csv', 
            quote=F, sep = ',', row.names=F, col.names=F)


