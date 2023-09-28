# ---
# title: "QC Function"
# Collaborators: Renee Grambihler
# Project: OceanWaterQuality
# Institution: Biosphere 2 Ocean
# ---

# The following code defines a function to identify data points outside input standard deviations from the mean or median for each nutrient at each location and replaces the identified outliers with NA values

# libraries
library(tidyverse)
library(lubridate)

qc_zscore <- function(df, var_col, date_col, cutoff=2.00, trim=0.10, zscore_type=NULL) {
  # input: 
    #df: dataframe
    #var_col: character vector; list of variable column names from df to use in function
    #date_col: character value; name of column in df with date values
    #mean_period: character value containing digit and "month" or "year" separated by space; period of time to use for mean
    #cutoff: integer; absolute value of z-score threshold to keep in data; default = 2.00
    #trim: integer between 0.00 and 1.00; percent of highest and lowest data points to disregard when calculating the mean; default = 0.10
    #zscore_type: character value; "normal" or "modified"; default = NULL
  # output: 
    #dfQC: dataframe; 
  
  # empty dataframe with same columns as passed-through dataframe
  dfQC <- data.frame(matrix(ncol = ncol(df), nrow = 0))
  colnames(dfQC) <- colnames(df)
  dfQC <- dfQC %>%
    mutate(zscore = NA)
  
  for (v in var_col) {
    # dataframe from passed-through frame filtered by the current variable in the loop
    dfVar <- df %>%
      select(date_col, v)%>%
      mutate(date = format(as.Date(df[[date_col]]), "%Y-%m"))%>%
      group_by(date)%>%
      mutate(mean_monthly_value = mean(df[[v]], na.rm = TRUE))
    
    print(dfVar)
  }
}
    
#     # standard deviation for current variable in loop
#     sd <- sd(dfVar[[v]], na.rm = TRUE)
# 
#     # check if zscore_type is NULL
#     if(is.null(zscore_type)){
#       # check for normal distribution of data in v if data is less than 5000 observations; otherwise, skip checking for normal distribution and just use median because mean and median probably are the same with such a large dataset anyways
#       if(length(dfVar[[v]]) < 5000){
#         # shapiro-wilks test for normal distribution
#         isnormal <- shapiro.test(dfVar[[v]])
# 
#         # if normal, use mean
#         if(isnormal$p.value >= 0.05){
#           # mean for current variable in the loop
#           mean <- mean(dfVar[[v]], trim = trim, na.rm = TRUE)
#           dfQCVar <- dfVar %>%
#             mutate(zscore = (dfVar[[v]] - mean)/sd,
#                    v = ifelse(abs(zscore) > cutoff,
#                                     NA,
#                                     dfVar[[v]]))
#         }
#         # if not normal, use mean absolute deviation (median)
#         if(isnormal$p.value < 0.05){
#           # mean absolute deviation for current variable in the loop
#           mad <- mad(dfVar[[v]], na.rm = TRUE)
#           mean <- mean(dfVar[[v]], trim = trim, na.rm = TRUE)
#           dfQCVar <- dfVar %>%
#             mutate(zscore = 0.6745 * ((dfVar[[v]] - mean) / mad),
#                    v = ifelse(abs(zscore) > cutoff,
#                                     NA,
#                                     dfVar[[v]]))
#         }
#       }
#       if(length(dfVar[[v]]) >= 5000){
#         # mean absolute deviation for current variable in the loop
#         mad <- mad(dfVar[[v]], na.rm = TRUE)
#         mean <- mean(dfVar[[v]], trim = trim, na.rm = TRUE)
#         dfQCVar <- dfVar %>%
#           mutate(zscore = 0.6745 * ((dfVar[[v]] - mean) / mad),
#                  v = ifelse(abs(zscore) > cutoff,
#                                   NA,
#                                   dfVar[[v]]))
#       }
#     } else{
#       # if zscore_type is normal: use mean for zscores
#       if (zscore_type == "normal"){
#         # mean for current variable in the loop
#         mean <- mean(dfVar[[v]], trim = trim, na.rm = TRUE)
#         dfQCVar <- dfVar %>%
#           mutate(zscore = (dfVar[[v]] - mean)/sd,
#                  v = ifelse(abs(zscore) > cutoff,
#                                   NA,
#                                   dfVar[[v]]))
#       }
#       # if zscore_type is modified: use median for zscores
#       if(zscore_type == "modified"){
#         mad <- mad(dfVar[[v]], na.rm = TRUE)
#         mean <- mean(dfVar[[v]], trim = trim, na.rm = TRUE)
#         dfQCVar <- dfVar %>%
#           mutate(zscore = 0.6745 * ((dfVar[[v]] - mean) / mad),
#                  v = ifelse(abs(zscore) > cutoff,
#                                   NA,
#                                   dfVar[[val_col]]))
#       }
#     }
#     dfQC <- rbind(dfQCVar, dfQC)
#   }
#   return(dfQC)
# }
