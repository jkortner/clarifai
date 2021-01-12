# --------------------------------------------------------------------------- #
# face2gender
# --------------------------------------------------------------------------- #

library(httr)
library(readr)
library(progress)

library(reticulate)
use_python('/usr/local/opt/python@3.8/bin/python3', required = T)
py_config()

# --------------------------------------------------------------------------- #

source_python("clarifai/clarifai.py")
api_key <- read_file('clarifai/clarifai-api-key-new.txt')

# function
face2gender <- function(jpg_path, api_key) {
  
  output <- clarifai_demographics(jpg_path, api_key, 'gender-appearance')
  
  demographics <- dict()
  
  # race / multicultural appearance
  demographics[[output$data$regions[0]$data$concepts[0]$name]] <- output$data$regions[0]$data$concepts[0]$value
  demographics[[output$data$regions[0]$data$concepts[1]$name]] <- output$data$regions[0]$data$concepts[1]$value
  
  return(demographics)
}

# --------------------------------------------------------------------------- #