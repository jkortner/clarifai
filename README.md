# clarifai

This repository provides some code to label faces according to their race / ethnicity. It uses the [demographics model](https://www.clarifai.com/models/demographics-image-recognition-model-c0c0ac362b03416da06ab3fa36fb58e3) from [Clarifai](https://www.clarifai.com).

Create a `faces` folder with all images to be labeled. Then execute the R file `face2race.R`. The API call is in `clarifai.py` and uses the `clarifai_grpc` package by Clarifai. The R file uses [reticulate](https://rstudio.github.io/reticulate/) to execute Python.

You also need to [sign-up](https://portal.clarifai.com/signup) for a Clarifai account and create an API key. Put your key in `clarifai-api-key.txt`. It will be used in `face2race.R`. See also the [Clarifai Guide](https://docs.clarifai.com) for more information.
