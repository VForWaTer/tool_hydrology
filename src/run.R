# load json2aRgs for parameter parsing
library(json2aRgs)

# load all needed third party libraries
library(grwat)

# make the tool functions available
source('functions.R')

# get the call parameters for the tool
params <- get_parameters()

# check which tool to run
toolname <- tolower(Sys.getenv("TOOL_RUN"))

# extract the discharge timeseries
df = params$discharge 


if (toolname == "") {
    toolname <- "baseflow_seperation"
}

# Switch for the different tools available in this package
if (toolname == "baseflow_seperation") {
    baseflow <- baseflow_separation(df)

} else {
    # in any other case, the tool was invalid or not configured
    print(paste("[", Sys.time(), "] Either no TOOL_RUN environment variable available, or '", toolname, "' is not valid.\n", sep = ""))
}
