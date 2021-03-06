# --------------------------------------------------------------------------- #
# face2race
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
face2race <- function(jpg_path, api_key) {
  
  output <- clarifai_demographics(jpg_path, api_key, 'multicultural-appearance')
  
  demographics <- dict()

  # race / multicultural appearance
  demographics[[output$data$regions[0]$data$concepts[0]$name]] <- output$data$regions[0]$data$concepts[0]$value
  demographics[[output$data$regions[0]$data$concepts[1]$name]] <- output$data$regions[0]$data$concepts[1]$value
  demographics[[output$data$regions[0]$data$concepts[2]$name]] <- output$data$regions[0]$data$concepts[2]$value
  demographics[[output$data$regions[0]$data$concepts[3]$name]] <- output$data$regions[0]$data$concepts[3]$value
  demographics[[output$data$regions[0]$data$concepts[4]$name]] <- output$data$regions[0]$data$concepts[4]$value
  demographics[[output$data$regions[0]$data$concepts[5]$name]] <- output$data$regions[0]$data$concepts[5]$value
  demographics[[output$data$regions[0]$data$concepts[6]$name]] <- output$data$regions[0]$data$concepts[6]$value

  return(demographics)
}

# --------------------------------------------------------------------------- #