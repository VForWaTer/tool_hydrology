# Pull any base image that includes R
FROM r-base:4.2.0

# install the latest version of json2aRgs from CRAN to parse parameters from /in/parameters.json 
# (use wget to install a specific version of json2aRgs, in this case, you have to manually install dependencies (jsonlite, yaml))
RUN R -e "install.packages('json2aRgs')"

# Do anything you need to install tool dependencies here
RUN R -e "install.packages('grwat')"
RUN R -e "install.packages('ggplot2')"
RUN R -e "install.packages('dplyr')"
RUN R -e "install.packages('tidyr')"
RUN R -e "install.packages('lubridate')"

# create the tool input structure
RUN mkdir /in
COPY ./in /in
RUN mkdir /out
RUN mkdir /src
COPY ./src /src

WORKDIR /src
CMD ["Rscript", "run.R"]
