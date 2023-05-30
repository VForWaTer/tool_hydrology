# This file defines all the hydrological tools available for the user
# Specific workflows which make use of one or more of these fuctions are defined in workflows.R

# Loading all the required external third party packages
library(grwat)
library(ggplot2)
library(dplyr)
library(tidyr)
library(lubridate)

#' Calculate baseflow using different separation techniques
#'
#' This function calculates baseflow using different separation techniques and 
#' returns a new dataframe with baseflow values in ggplot compliant format for plotting. 
#' The function takes a dataframe containing a discharge timeseries as its only argument.
#'
#' @param df A dataframe containing a discharge timeseries.
#' @return A new dataframe with baseflow values in ggplot compliant format for plotting.
#' @export
#'
#' @examples
#' df <- read.csv("discharge.csv")
#' baseflow_separation(df)
#'
#' @import ggplot2
#' @import dplyr
#' @import grwat
#' @importFrom tidyr pivot_longer
#' @importFrom ggplot2 geom_area facet_wrap
baseflow_seperation <- function(df){
  # Add columns according to different baseflow seperation techniques
  # Refer https://github.com/tsamsonov/grwat for more details

  df$lynehollick = gr_baseflow(params$discharge, method = 'lynehollick', a = 0.9)
  df$boughton = gr_baseflow(params$discharge, method = 'boughton', k = 0.9)
  df$jakeman = gr_baseflow(params$discharge, method = 'jakeman', k = 0.9)
  df$maxwell = gr_baseflow(params$discharge, method = 'maxwell', k = 0.9)

  # Return New dataframe with baseflow values in ggplot compliant format for plotting
  new_df  = params %>%
    mutate(lynehollick = gr_baseflow(params$discharge, method = 'lynehollick', a = 0.9),
          boughton = gr_baseflow(params$discharge, method = 'boughton', k = 0.9),
          jakeman = gr_baseflow(params$discharge, method = 'jakeman', k = 0.9),
          maxwell = gr_baseflow(params$discharge, method = 'maxwell', k = 0.9)) %>% 
  pivot_longer(lynehollick:maxwell, names_to = 'Method', values_to = 'Qbase')

  # Save as RDS Object
  saveRDS(new_df,file = "/out/baseflow.Rds")
  write.csv(new_de, file = "/out/baseflow.csv")

  # create a figure
  pdf("/out/baseflow_separation.pdf")

  ggplot(new_df) +
    geom_area(aes(time, discharge), fill = 'steelblue', color = 'black') +
    geom_area(aes(time, Qbase), fill = 'orangered', color = 'black') +
    facet_wrap(~Method)

  dev.off()
}

identify_gaps <- function(df){
  #' function to detect missing periods - The data
  #' is considered to be a gap if any value in the row is missing
  #' Hence cannot identify when both time and value is missing
  #' Refer https://github.com/tsamsonov/grwat (gr_get_gap) for more details
  missing_df = gr_get_gap(hdata)

  # Save as RDS Object
  saveRDS( missing_df,file = "/out/missing_df.Rds")
}
