# --------------------------------------------------------------------------- #
# face2race
# --------------------------------------------------------------------------- #

library(httr)
library(readr)
library(progress)
library(dict)

library(reticulate)
use_python('/usr/local/opt/python/bin/python3.7', required = T)
py_config()

# --------------------------------------------------------------------------- #

source_python("clarifai.py")
api_key <- read_file('clarifai-api-key.txt')

# function
face2race <- function(jpg_path, api_key) {
  
  output <- clarifai_demographics(jpg_path, api_key)
  
  demographics <- dict()
  
  demographics[['model_id']] <- output$model$id
  demographics[['model_name']] <- output$model$name
  demographics[['model_version']] <- output$model$model_version$id
  
  # gender
  demographics[[output$data$regions[0]$data$concepts[20]$name]] <- output$data$regions[0]$data$concepts[20]$value
  demographics[[output$data$regions[0]$data$concepts[21]$name]] <- output$data$regions[0]$data$concepts[21]$value
  
  # race / multicultural appearance
  demographics[[output$data$regions[0]$data$concepts[22]$name]] <- output$data$regions[0]$data$concepts[22]$value
  demographics[[output$data$regions[0]$data$concepts[23]$name]] <- output$data$regions[0]$data$concepts[23]$value
  demographics[[output$data$regions[0]$data$concepts[24]$name]] <- output$data$regions[0]$data$concepts[24]$value
  demographics[[output$data$regions[0]$data$concepts[25]$name]] <- output$data$regions[0]$data$concepts[25]$value
  demographics[[output$data$regions[0]$data$concepts[26]$name]] <- output$data$regions[0]$data$concepts[26]$value
  demographics[[output$data$regions[0]$data$concepts[27]$name]] <- output$data$regions[0]$data$concepts[27]$value
  demographics[[output$data$regions[0]$data$concepts[28]$name]] <- output$data$regions[0]$data$concepts[28]$value

  return(demographics)
}

jpgs <- list.files(path = "faces")
d_list <- list()
pb <- progress_bar$new(total = length(jpgs), show_after = 0)
for (i in 1:length(jpgs)){
  pb$tick()
  jpg_path = paste0('faces/', jpgs[i])
  
  d <- face2race(jpg_path, api_key)
  d[['name']] <- substr(jpgs[i], 1, nchar(jpgs[i])-4)
  d_list <- c(d_list, d)
  
}

df <- d_list_to_df(d_list)
print(df)

# --------------------------------------------------------------------------- #