require(tidyr) # gather, mutate, select, arrange, spread, unite
require(dplyr) # pipe function, rename, 
require(xgboost)

# load sample_submit
sample_submit <- read.csv('raw_data/sample_submit.csv', header=F)

# clean train
train <- read.csv('raw_data/target_train.csv') %>% mutate(date=as.Date(date))

# clean sale
sale <- read.csv('raw_data/sale.csv') %>% mutate(date=as.Date(date))

# clean sensor
sensor <- read.csv('raw_data/sensor.csv') %>% rename(temperature=tempature) %>% 
  gather(key, value, temperature:precipitation) %>% unite(key, id, key) %>% spread(key, value) %>%
  mutate(timestamp = as.character(timestamp))
sensor <- cbind('time' = unlist(lapply(strsplit(sensor$timestamp, ' '), '[', 2)) %>% 
                  paste0('2016-03-02 ', .) %>% as.POSIXct %>% as.numeric, sensor)

# clean weather
weather <- read.csv('raw_data/weather.csv', na.strings=c('NA', ""))
weather1 <- weather %>% select(-weather_06.18, -weather_18.06) %>% 
  gather(key, value, -date, -id, na.rm=T) %>% unite(key, id, key) %>% spread(key, value) %>%
  mutate(date = as.Date(date))

weather2 <- weather %>% select(c(1,2, 15,16)) %>% mutate_each_(funs(as.character), names(.)) %>% 
  gather(key, value, -date, -id, na.rm=T) %>% unite(key, id, key) %>% spread(key, value) %>%
  mutate(date = as.Date(date))

weather <- left_join(weather1, weather2); rm(weather1, weather2)

# clean sensor location
sensor_location <- read.table('raw_data/sensor_location.tsv', sep='\t') %>% rename(id=V1, loc=V2)


