# load json2aRgs for parameter parsing
library(json2aRgs)

# get the call parameters for the tool
params <- get_parameters()

# check which tool to run
toolname <- tolower(Sys.getenv("TOOL_RUN"))

# extract the discharge timeseries
df = params$discharge 

# Install the third party R packages
install.packages('grwat')

# make functions from main file available
source('functions.R')

# make entire workflows from  file available
source('workflows.R')

if (toolname == "") {
    toolname <- "foobar"
}

# Switch for the different tools available in this package
if (toolname == "foobar") {
    # RUN the tool here and create the output in /out

    # prints to STDOUT.log
    print("You have tried to run the tool 'foobar'.
This tool is the template tool without any functionality.
Please implement another tool or select the tool you 
have already implemented.")
    print(params)
} else {
    # in any other case, the tool was invalid or not configured
    print(paste("[", Sys.time(), "] Either no TOOL_RUN environment variable available, or '", toolname, "' is not valid.\n", sep = ""))
}
