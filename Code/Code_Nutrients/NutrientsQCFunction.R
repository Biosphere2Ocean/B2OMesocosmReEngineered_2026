library(tidyverse)

# function to recreate remove_sd_outlier() but better: identifies data points outside 2 standard deviations from the mean for each nutrient at each location and replaces the outliers with NA values
remove_n_sigmas <- function(df, n_sigmas) {
  # make empty dataframe to store output from loop
  # creating with just 2 columns for now since "date" and "location" columns will not change
  dfQC <- data.frame(matrix(ncol = ncol(df), nrow = nrow(df)))
  colnames(dfQC) <- colnames(df)
  # # filling in date and location column with same values from df
  # dfQC <- dfQC %>%
  #   mutate(date = df$Date,
  #          location = df$Location)
  # getting list of column names from df, excluding "date" and "location" so we can use it to loop through
  nutrient_list <- colnames(df)
  nutrient_list <- nutrient_list[! nutrient_list %in% c("Date", "Location")]
  # list of locations
  location_list <- c(unique(df$Location))
  
  # dfQC <- data.frame(matrix(ncol = ncol(df), nrow = 0))
  # colnames(dfQC) <- colnames(AllData)
  
  for (l in length(location_list)) {
    for (n in nutrient_list) {
      nutrient <- df[[n]]
      LocationNutrientFrame <- df %>%
        filter(Location == location_list[l]) %>%
        select(Date, Location, n)
      
      mean_nutrient_value <- mean(LocationNutrientFrame$n, na.rm = TRUE)
      
      sd_nutrient_value <- sd(LocationNutrientFrame$n, na.rm = TRUE)
      
      QCLocationNutrientFrame <- LocationNutrientFrame %>%
        mutate(n = ifelse(n < mean_nutrient_value-n_sigmas*sd_nutrient_value | 
                            n > mean_nutrient_value+n_sigmas*sd_nutrient_value, 
                          NA, 
                          n))
      
      dfQC <- rbind(QCLocationNutrientFrame, dfQC)
    }
  }
  return(QCAllData)
}

# make empty dataframe to store output from loop
# creating with just 2 columns for now since "date" and "time" columns will not change
dfQC <- data.frame(matrix(ncol = 2, nrow = nrow(df)))
colnames(dfQC) <- c("date", "time")
# filling in date and time columns with same values from df
dfQC <- dfQC %>%
  mutate(date = df$date,
         time = df$time)
# getting list of column names from df, excluding "date" and "time" so we can use it to loop through
var_names <- colnames(df)
var_names <- var_names[! var_names %in% c("date", "time")]

# loopin time
for (v in var_names) {
  # select column from df to use in calculations (represented by v in the loop) and store as var
  var <- df[[v]]
  # frame with just date, time, and var columns - all from df
  dfVar <- df[, c("date", "time")]
  dfVar <- cbind(dfVar, var)
  
  dfVar <- dfVar %>%
    # mutate date column so it's just year and month - this will allow us to do summary statistics by month
    mutate(date = format(as.Date(date), "%Y-%m"),
           stat = NA) %>%
    group_by(date) %>%
    # make columns for monthly standard deviation, mean, and median absolute deviation (mad) 
    mutate(sd_monthly = sd(as.numeric(var), na.rm = TRUE),
           mean_monthly = mean(as.numeric(var), na.rm = TRUE),
           mad_monthly = mad(as.numeric(var), na.rm = TRUE))
  
  # create vector of unique dates from dfVar. Will give just the unique year/month combos
  unique_dates <- unique(dfVar$date)
  
  # test to see if the data for each month are normal
  # if normal: use mean
  # if not normal: use median
  for (d in unique_dates) {
    # filter dfVar by month and use only unique values
    dfVarNormal <- dfVar %>%
      filter(date == d) %>%
      unique()
    
    # run shapiro test on var values if there are more than 3 unique values. 
    # p-value will be saved in shapiro_value if above is true, otherwise, sample will be considered non-normal, and shapiro_value will be saved as 0 
    shapiro_value <- NA
    if (length(unique(dfVarNormal$var)) <= 3) {
      shapiro_value <- 0
    } else {
      shapiro_value <- shapiro.test(as.numeric(dfVarNormal$var))$p.value
    }
    
    # if shapiro_value is not significant (data is normal), then make stat values where date == d be equal to "mean", otherwise, set them equal to "median"
    dfVar <- dfVar %>%
      mutate(stat = ifelse(date == d & shapiro_value >= 0.05,
                           "mean",
                           "median"))
  }
  
  # calculate z-scores for each data point based on the monthly mean or median
  # if the value of stat is "mean", then a normal z-score will be calculated using the mean
  # if the value of stat is "median", then a modified z-score will be calculated using the median
  # if the denominator in the suggested calculation is going to be 0 (sd_monthly for normal and mad_monthly for modified), then either the normal z-score will be calculated, or 0 will be put in for the zscore. Some reasoning is included below: 
  dfVar <- dfVar %>%
    # create column called zscore and populate with NA values
    mutate(zscore = NA,
           # if stat is median and mad_monthly is > 0, then calculate the modified z-score for zscore column, otherwise, keep original zscore value (NA in this case). This is to avoid dividing by 0
           zscore = ifelse(stat == "median" & mad_monthly > 0,
                           0.6745 * (var - mean_monthly) / mad_monthly,
                           zscore),
           # if stat is mean and sd_monthly is > 0, then calculate normal z-score for zscore column, otherwise, keep original zscore value. This is to avoid dividing by 0.
           zscore = ifelse(stat == "mean" & sd_monthly > 0,
                           (var - mean_monthly)/sd_monthly,
                           zscore),
           # if stat is mean and sd_monthly is < or = to 0, make zscore value 0, otherwise, keep original zscore value. If the data are normal, and the standard deviation is <=0, then the z-score should be 0 anyways. This is again to avoid dividing by 0.
           zscore = ifelse(stat == "mean" & sd_monthly <= 0,
                           0,
                           zscore), 
           # if stat is median and mad_monthly is <= 0 and sd_monthly > 0, then calculate a normal z-score for zscore column, otherwise, keep original zscore value. This is to avoid dividing by 0: if median is suggested (non normal data) but the var value is not different from the median, this will give 0 as mad value (mad = constant * |var - median|; see ?mad for more details)
           zscore = ifelse(stat == "median" & mad_monthly <= 0 & sd_monthly > 0,
                           (var - mean_monthly)/sd_monthly,
                           zscore), 
           # if stat is median and mad_monthly is <= 0 and sd_monthly <= 0, zscore is 0, otherwise, keep original zscore value
           zscore = ifelse(stat == "median" & mad_monthly <= 0 & sd_monthly <= 0, 
                           0,
                           zscore))
  
  # if absolute value of z-score is greater than 2.00, then turn var value into NA; otherwise, leave as is
  dfVar <- dfVar %>%
    mutate(var = ifelse(abs(zscore) > 2.00,
                        NA,
                        var))
  # replace var variable with new QC'd var column from dfVar
  var <- dfVar$var
  
  # stick new QC'd var column into dfQC
  dfQC <- dfQC %>%
    cbind(var)
  
  # set the column name of dfQC that is currently called "var" to be what v currently represents in the loop. Before this, the column names for dfQC are date, time, var. After this, the column names for dfQC are date, time, temp_f, temp_c, etc. Otherwise, you'd just keep replacing the data in var with new QC'd data but not saving it to a column with the name of the variable that data represents (like pH or temp_f).
  colnames(dfQC)[colnames(dfQC) == "var"] = v
}