
Train <- left_join(train[complete.cases(train), ], features)
test <- features[366:729,-1]; Dtest <- xgb.DMatrix(data=data.matrix(test), missing=NA)

# A
Dtrain <- xgb.DMatrix(data=data.matrix(Train[,7:378]), label=log(1+Train$A), missing=NA)
parameters <- list(booster='gbtree', objective = 'reg:linear',
                   eta = 0.01, subsample = 0.9,
                   colsample_bytree = 0.5,
                   max_depth = 2,
                   eval.metric='rmse',
                   #min_child_weight = 6,
                   #scale_pos_weight=0.8,
                   nthread=4) 
xgb.cv(params=parameters, Dtrain, nrounds = 955, nfold = 5, seed=23)
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
                   nthread=4) 
xgb.cv(params=parameters, Dtrain, nrounds = 1000, nfold = 5, seed=23)
model = xgb.train(params=parameters, Dtrain, nrounds = 1000, nfold = 5, seed=23)
sample_submit[,3] = exp(predict(model, Dtest))-1

# C
Dtrain <- xgb.DMatrix(data=data.matrix(Train[,7:378]), label=log(1+Train$C), missing=NA)
parameters <- list(booster='gbtree', objective = 'reg:linear',
                   eta = 0.01, subsample = 0.9,
                   colsample_bytree = 0.5,
                   max_depth = 2,
                   eval.metric='rmse',
                   nthread=4) 
xgb.cv(params=parameters, Dtrain, nrounds = 1000, nfold = 5, seed=23)
model = xgb.train(params=parameters, Dtrain, nrounds = 1000, nfold = 5, seed=23)
sample_submit[,4] = exp(predict(model, Dtest))-1

# D
Dtrain <- xgb.DMatrix(data=data.matrix(Train[,7:378]), label=log(1+Train$D), missing=NA)
parameters <- list(booster='gbtree', objective = 'reg:linear',
                   eta = 0.01, subsample = 0.9,
                   colsample_bytree = 0.5,
                   max_depth = 2,
                   eval.metric='rmse',
                   nthread=4) 
xgb.cv(params=parameters, Dtrain, nrounds = 1000, nfold = 5, seed=23)
model = xgb.train(params=parameters, Dtrain, nrounds = 1000, nfold = 5, seed=23)
sample_submit[,5] = exp(predict(model, Dtest))-1

# E
Dtrain <- xgb.DMatrix(data=data.matrix(Train[,7:378]), label=log(1+Train$E), missing=NA)
parameters <- list(booster='gbtree', objective = 'reg:linear',
                   eta = 0.01, subsample = 0.9,
                   colsample_bytree = 0.5,
                   max_depth = 2,
                   eval.metric='rmse',
                   nthread=4) 
xgb.cv(params=parameters, Dtrain, nrounds = 1000, nfold = 5, seed=23)
model = xgb.train(params=parameters, Dtrain, nrounds = 1000, nfold = 5, seed=23)
sample_submit[,6] = exp(predict(model, Dtest))-1

# save
write.table(sample_submit, 'submissions/sub-1.csv', 
            quote=F, sep = ',', row.names=F, col.names=F)


