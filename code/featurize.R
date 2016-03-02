#### sale features

#### sensor features

# ... centrality measures from 08:00 to 23:00 every day ...
sensor1 <- sensor %>% filter(time >= as.numeric(as.POSIXct('2016-03-02 08:00:00')) & 
                             time <= as.numeric(as.POSIXct('2016-03-02 23:00:00'))  ) %>% 
  select(-time) %>% mutate(timestamp = substr(timestamp, 1, 10))
sensor1_mean <- sensor1 %>% group_by(timestamp) %>% summarise_each(funs(mean(., na.rm=T))) %>% setNames(c('date', paste0(names(.)[-1], '_mean_08.23')))


#### weather features

#### calendar features
calendar <- data.frame(cbind('mday' = as.POSIXlt(sale$date)$mday,
                  'mon' = as.POSIXlt(sale$date)$mon+1,
                  'wday' = as.POSIXlt(sale$date)$wday+1))

#### combine
features <- cbind('date'=sale$date, calendar, sale[, 2:6], sensor1_mean[,-1], weather[,-c(1,267:274)])
unname(sapply(features, class)) # check all are numeric


