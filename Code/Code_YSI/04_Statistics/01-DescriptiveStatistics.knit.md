
<!-- rnb-text-begin -->

---
title: "YSI Data Descriptive Statistics"
collaborators: Renee Grambihler
project: OceanWaterQuality
institution: Biosphere 2 Ocean
output: html_notebook
---
# Descriptive Statistics
## Import Libraries

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeSh0aWR5dmVyc2UpXG5saWJyYXJ5KHRpYmJsZXRpbWUpIFxuYGBgIn0= -->

```r
library(tidyverse)
library(tibbletime) 
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiXG5BdHRhY2hpbmcgcGFja2FnZTog4oCYdGliYmxldGltZeKAmVxuXG5UaGUgZm9sbG93aW5nIG9iamVjdCBpcyBtYXNrZWQgZnJvbSDigJhwYWNrYWdlOnN0YXRz4oCZOlxuXG4gICAgZmlsdGVyXG4ifQ== -->

```

Attaching package: ‘tibbletime’

The following object is masked from ‘package:stats’:

    filter
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeShsdWJyaWRhdGUpXG5vcHRpb25zKHNjaXBlbiA9IDk5OSlcbmBgYCJ9 -->

```r
library(lubridate)
options(scipen = 999)
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


## Import Data
Read in fully QC'd data

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZGYgPC0gcmVhZF9jc3YoXCJEYXRhL0NsZWFuRGF0YS9DbGVhbkRhdGFfWVNJLzAyX1F1YWxpdHlDb250cm9sLzAzLU9jZWFuV2F0ZXJRdWFsaXR5RGF0YS1RQ0N1dG9mZi5jc3ZcIilcbmBgYCJ9 -->

```r
df <- read_csv("Data/CleanData/CleanData_YSI/02_QualityControl/03-OceanWaterQualityData-QCCutoff.csv")
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiUm93czogNDYxNzgyIENvbHVtbnM6IDE54pSA4pSAIENvbHVtbiBzcGVjaWZpY2F0aW9uIOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgFxuRGVsaW1pdGVyOiBcIixcIlxuZGJsICAoMTcpOiB0ZW1wX2YsIHRlbXBfYywgcEgsIHBIX21WLCBzYWxpbml0eV9wc3UsIGNvbmR1Y3Rpdml0eV91U2NtLCBubGZfY29uZHVjdGl2aXR5X3VTY20uLi5cbmRhdGUgICgxKTogZGF0ZVxudGltZSAgKDEpOiB0aW1lXG7ihLkgVXNlIGBzcGVjKClgIHRvIHJldHJpZXZlIHRoZSBmdWxsIGNvbHVtbiBzcGVjaWZpY2F0aW9uIGZvciB0aGlzIGRhdGEuXG7ihLkgU3BlY2lmeSB0aGUgY29sdW1uIHR5cGVzIG9yIHNldCBgc2hvd19jb2xfdHlwZXMgPSBGQUxTRWAgdG8gcXVpZXQgdGhpcyBtZXNzYWdlLlxuIn0= -->

```
Rows: 461782 Columns: 19── Column specification ────────────────────────────────────────────────────────────────────────
Delimiter: ","
dbl  (17): temp_f, temp_c, pH, pH_mV, salinity_psu, conductivity_uScm, nlf_conductivity_uScm...
date  (1): date
time  (1): time
ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


## Minor Data Manipulation
Add datetime column and create timetibble ordered by day

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBjb21iaW5lIGRhdGUgYW5kIHRpbWUgaW50byBkYXRldGltZSBjb2x1bW4gXG5kZkVkaXQgPC0gZGYgJT4lXG4gIG11dGF0ZShkYXRldGltZSA9IHBhc3RlKGRhdGUsIHRpbWUpLCAuYmVmb3JlID0gZGF0ZSxcbiAgICAgICAgIGRhdGV0aW1lID0gYXMuUE9TSVhjdChkYXRldGltZSkpICU+JSAjbWFrZSBzdXJlIGRhdGV0aW1lIGlzIFBPU0lYY3QgY2xhc3NcbiAgZGlzdGluY3QoKSAlPiUgI3JlbW92ZSBkdXBsaWNhdGUgcm93cyBmcm9tIGRmXG4gIHN1YnNldChpcy5uYShkYXRldGltZSk9PUZBTFNFKSAjcmVtb3ZlIE5BcyBmcm9tIGRhdGV0aW1lXG4gXG5kZkVkaXRQaXZvdCA8LSBkZkVkaXQgJT4lXG4gIHBpdm90X2xvbmdlcihjb2xzID0gdGVtcF9mOnRvdGFsX2Rpc3NvbHZlZF9zb2xpZHNfbWdMLFxuICAgICAgICAgICAgICAgbmFtZXNfdG8gPSBcInZhcmlhYmxlXCIsXG4gICAgICAgICAgICAgICB2YWx1ZXNfdG8gPSBcInZhcmlhYmxlX3ZhbHVlXCIpXG5cbiMgaW5zcGVjdCBkZiB0byBzZWUgd2hhdCB0aGUgY2xhc3NlcyBvZiBlYWNoIGNvbHVtbiBhcmVcbnN0cihkZkVkaXRQaXZvdClcbmBgYCJ9 -->

```r
# combine date and time into datetime column 
dfEdit <- df %>%
  mutate(datetime = paste(date, time), .before = date,
         datetime = as.POSIXct(datetime)) %>% #make sure datetime is POSIXct class
  distinct() %>% #remove duplicate rows from df
  subset(is.na(datetime)==FALSE) #remove NAs from datetime
 
dfEditPivot <- dfEdit %>%
  pivot_longer(cols = temp_f:total_dissolved_solids_mgL,
               names_to = "variable",
               values_to = "variable_value")

# inspect df to see what the classes of each column are
str(dfEditPivot)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoidGliYmxlIFs3LDg1MCwxNDEgw5cgNV0gKFMzOiB0YmxfZGYvdGJsL2RhdGEuZnJhbWUpXG4gJCBkYXRldGltZSAgICAgIDogUE9TSVhjdFsxOjc4NTAxNDFdLCBmb3JtYXQ6IFwiMjAxMS0wNy0yMiAxNDo0NTowMFwiIFwiMjAxMS0wNy0yMiAxNDo0NTowMFwiIC4uLlxuICQgZGF0ZSAgICAgICAgICA6IERhdGVbMTo3ODUwMTQxXSwgZm9ybWF0OiBcIjIwMTEtMDctMjJcIiBcIjIwMTEtMDctMjJcIiAuLi5cbiAkIHRpbWUgICAgICAgICAgOiAnaG1zJyBudW0gWzE6Nzg1MDE0MV0gMTQ6NDU6MDAgMTQ6NDU6MDAgMTQ6NDU6MDAgMTQ6NDU6MDAgLi4uXG4gIC4uLSBhdHRyKCosIFwidW5pdHNcIik9IGNociBcInNlY3NcIlxuICQgdmFyaWFibGUgICAgICA6IGNociBbMTo3ODUwMTQxXSBcInRlbXBfZlwiIFwidGVtcF9jXCIgXCJwSFwiIFwicEhfbVZcIiAuLi5cbiAkIHZhcmlhYmxlX3ZhbHVlOiBudW0gWzE6Nzg1MDE0MV0gNzYuMiAyNC41IDguNSBOQSAyOS43IC4uLlxuIn0= -->

```
tibble [7,850,141 × 5] (S3: tbl_df/tbl/data.frame)
 $ datetime      : POSIXct[1:7850141], format: "2011-07-22 14:45:00" "2011-07-22 14:45:00" ...
 $ date          : Date[1:7850141], format: "2011-07-22" "2011-07-22" ...
 $ time          : 'hms' num [1:7850141] 14:45:00 14:45:00 14:45:00 14:45:00 ...
  ..- attr(*, "units")= chr "secs"
 $ variable      : chr [1:7850141] "temp_f" "temp_c" "pH" "pH_mV" ...
 $ variable_value: num [1:7850141] 76.2 24.5 8.5 NA 29.7 ...
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


## Whole Time Series Statistics
Summary statistics over entire time period of data

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZGZXaG9sZSA8LSBkZkVkaXRQaXZvdCAlPiVcbiAgcmVmcmFtZShtZWFuID0gbWVhbih2YXJpYWJsZV92YWx1ZSwgbmEucm0gPSBUUlVFKSwgXG4gICAgICAgICAgbWVkaWFuID0gbWVkaWFuKHZhcmlhYmxlX3ZhbHVlLCBuYS5ybSA9IFRSVUUpLFxuICAgICAgICAgIHN0ZCA9IHNkKHZhcmlhYmxlX3ZhbHVlLCBuYS5ybSA9IFRSVUUpLFxuICAgICAgICAgIElRUiA9IElRUih2YXJpYWJsZV92YWx1ZSwgbmEucm0gPSBUUlVFKSxcbiAgICAgICAgICBtaW4gPSBtaW4odmFyaWFibGVfdmFsdWUsIG5hLnJtID0gVFJVRSksXG4gICAgICAgICAgbWF4ID0gbWF4KHZhcmlhYmxlX3ZhbHVlLCBuYS5ybSA9IFRSVUUpLFxuICAgICAgICAgIC5ieSA9IHZhcmlhYmxlKSU+JVxuICAgbXV0YXRlKGFjcm9zcyh3aGVyZShpcy5udW1lcmljKSwgcm91bmQsIDIpKVxuXG5kZldob2xlW3NhcHBseShkZldob2xlLCBpcy5pbmZpbml0ZSldIDwtIE5BICN0dXJuIGluZmluaXRlIHZhbHVlcyBpbnRvIE5BcyB0aGF0IHdlcmUgaW50cm9kdWNlZCB3aGVuIHJ1bm5pbmcgbWluIGFuZCBtYXggb24gdmFyaWFibGVzIHRoYXQgZGlkIG5vdCBoYXZlIGFueSBkYXRhXG5cbmBgYCJ9 -->

```r
dfWhole <- dfEditPivot %>%
  reframe(mean = mean(variable_value, na.rm = TRUE), 
          median = median(variable_value, na.rm = TRUE),
          std = sd(variable_value, na.rm = TRUE),
          IQR = IQR(variable_value, na.rm = TRUE),
          min = min(variable_value, na.rm = TRUE),
          max = max(variable_value, na.rm = TRUE),
          .by = variable)%>%
   mutate(across(where(is.numeric), round, 2))

dfWhole[sapply(dfWhole, is.infinite)] <- NA #turn infinite values into NAs that were introduced when running min and max on variables that did not have any data

```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


## Yearly Statistics
Summary statistics by year

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZGZZZWFyIDwtIGRmRWRpdFBpdm90ICU+JVxuICBtdXRhdGUoeWVhciA9IHllYXIoZGF0ZXRpbWUpKSU+JVxuICBncm91cF9ieSh5ZWFyLCB2YXJpYWJsZSkgJT4lXG4gIHJlZnJhbWUobWVhbiA9IG1lYW4odmFyaWFibGVfdmFsdWUsIG5hLnJtID0gVFJVRSksIFxuICAgICAgICAgIG1lZGlhbiA9IG1lZGlhbih2YXJpYWJsZV92YWx1ZSwgbmEucm0gPSBUUlVFKSxcbiAgICAgICAgICBzdGQgPSBzZCh2YXJpYWJsZV92YWx1ZSwgbmEucm0gPSBUUlVFKSxcbiAgICAgICAgICBJUVIgPSBJUVIodmFyaWFibGVfdmFsdWUsIG5hLnJtID0gVFJVRSksXG4gICAgICAgICAgUTEgPSBxdWFudGlsZSh2YXJpYWJsZV92YWx1ZSwgMC4yNSwgbmEucm0gPSBUUlVFKSwgXG4gICAgICAgICAgUTMgPSBxdWFudGlsZSh2YXJpYWJsZV92YWx1ZSwgMC43NSwgbmEucm0gPSBUUlVFKSxcbiAgICAgICAgICBtaW4gPSBtaW4odmFyaWFibGVfdmFsdWUsIG5hLnJtID0gVFJVRSksXG4gICAgICAgICAgbWF4ID0gbWF4KHZhcmlhYmxlX3ZhbHVlLCBuYS5ybSA9IFRSVUUpKSU+JVxuICBtdXRhdGUoYWNyb3NzKHdoZXJlKGlzLm51bWVyaWMpLCByb3VuZCwgMikpXG5gYGAifQ== -->

```r
dfYear <- dfEditPivot %>%
  mutate(year = year(datetime))%>%
  group_by(year, variable) %>%
  reframe(mean = mean(variable_value, na.rm = TRUE), 
          median = median(variable_value, na.rm = TRUE),
          std = sd(variable_value, na.rm = TRUE),
          IQR = IQR(variable_value, na.rm = TRUE),
          Q1 = quantile(variable_value, 0.25, na.rm = TRUE), 
          Q3 = quantile(variable_value, 0.75, na.rm = TRUE),
          min = min(variable_value, na.rm = TRUE),
          max = max(variable_value, na.rm = TRUE))%>%
  mutate(across(where(is.numeric), round, 2))
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiV2FybmluZzogVGhlcmUgd2VyZSAyMDYgd2FybmluZ3MgaW4gYHJlZnJhbWUoKWAuXG5UaGUgZmlyc3Qgd2FybmluZyB3YXM6XG7ihLkgSW4gYXJndW1lbnQ6IGBtaW4gPSBtaW4odmFyaWFibGVfdmFsdWUsIG5hLnJtID0gVFJVRSlgLlxu4oS5IEluIGdyb3VwIDE6IGB5ZWFyID0gMjAxMWAsIGB2YXJpYWJsZSA9IFwiY2hsb3JvcGh5bGxfcmZ1XCJgLlxuQ2F1c2VkIGJ5IHdhcm5pbmcgaW4gYG1pbigpYDpcbiEgbm8gbm9uLW1pc3NpbmcgYXJndW1lbnRzIHRvIG1pbjsgcmV0dXJuaW5nIEluZlxu4oS5IFJ1biBcdTAwMWJdODs7aWRlOnJ1bjpkcGx5cjo6bGFzdF9kcGx5cl93YXJuaW5ncygpXHUwMDA3ZHBseXI6Omxhc3RfZHBseXJfd2FybmluZ3MoKVx1MDAxYl04OztcdTAwMDcgdG8gc2VlIHRoZSAyMDUgcmVtYWluaW5nIHdhcm5pbmdzLldhcm5pbmc6IFRoZXJlIHdhcyAxIHdhcm5pbmcgaW4gYG11dGF0ZSgpYC5cbuKEuSBJbiBhcmd1bWVudDogYGFjcm9zcyh3aGVyZShpcy5udW1lcmljKSwgcm91bmQsIDIpYC5cbkNhdXNlZCBieSB3YXJuaW5nOlxuISBUaGUgYC4uLmAgYXJndW1lbnQgb2YgYGFjcm9zcygpYCBpcyBkZXByZWNhdGVkIGFzIG9mIGRwbHlyIDEuMS4wLlxuU3VwcGx5IGFyZ3VtZW50cyBkaXJlY3RseSB0byBgLmZuc2AgdGhyb3VnaCBhbiBhbm9ueW1vdXMgZnVuY3Rpb24gaW5zdGVhZC5cblxuICAjIFByZXZpb3VzbHlcbiAgYWNyb3NzKGE6YiwgbWVhbiwgbmEucm0gPSBUUlVFKVxuXG4gICMgTm93XG4gIGFjcm9zcyhhOmIsIFxcKHgpIG1lYW4oeCwgbmEucm0gPSBUUlVFKSlcblRoaXMgd2FybmluZyBpcyBkaXNwbGF5ZWQgb25jZSBldmVyeSA4IGhvdXJzLlxuQ2FsbCBgbGlmZWN5Y2xlOjpsYXN0X2xpZmVjeWNsZV93YXJuaW5ncygpYCB0byBzZWUgd2hlcmUgdGhpcyB3YXJuaW5nIHdhcyBnZW5lcmF0ZWQuXG4ifQ== -->

```
Warning: There were 206 warnings in `reframe()`.
The first warning was:
ℹ In argument: `min = min(variable_value, na.rm = TRUE)`.
ℹ In group 1: `year = 2011`, `variable = "chlorophyll_rfu"`.
Caused by warning in `min()`:
! no non-missing arguments to min; returning Inf
ℹ Run ]8;;ide:run:dplyr::last_dplyr_warnings()dplyr::last_dplyr_warnings()]8;; to see the 205 remaining warnings.Warning: There was 1 warning in `mutate()`.
ℹ In argument: `across(where(is.numeric), round, 2)`.
Caused by warning:
! The `...` argument of `across()` is deprecated as of dplyr 1.1.0.
Supply arguments directly to `.fns` through an anonymous function instead.

  # Previously
  across(a:b, mean, na.rm = TRUE)

  # Now
  across(a:b, \(x) mean(x, na.rm = TRUE))
This warning is displayed once every 8 hours.
Call `lifecycle::last_lifecycle_warnings()` to see where this warning was generated.
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZGZZZWFyW3NhcHBseShkZlllYXIsIGlzLmluZmluaXRlKV0gPC0gTkEgI3R1cm4gaW5maW5pdGUgdmFsdWVzIGludG8gTkFzIHRoYXQgd2VyZSBpbnRyb2R1Y2VkIHdoZW4gcnVubmluZyBtaW4gYW5kIG1heCBvbiB2YXJpYWJsZXMgdGhhdCBkaWQgbm90IGhhdmUgYW55IGRhdGFcblxud3JpdGVfY3N2KGRmWWVhciwgXCJEYXRhL0NsZWFuRGF0YS9DbGVhbkRhdGFfWVNJLzAzX0Rlc2NyaXB0aXZlU3RhdGlzdGljcy9ZZWFybHlEZXNjcmlwdGl2ZVN0YXRzLmNzdlwiKVxuXG5gYGAifQ== -->

```r
dfYear[sapply(dfYear, is.infinite)] <- NA #turn infinite values into NAs that were introduced when running min and max on variables that did not have any data

write_csv(dfYear, "Data/CleanData/CleanData_YSI/03_DescriptiveStatistics/YearlyDescriptiveStats.csv")

```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


## Monthly Statistics
Summary statistics by month

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZGZNb250aCA8LSBkZkVkaXRQaXZvdCAlPiVcbiAgbXV0YXRlKHllYXIgPSB5ZWFyKGRhdGV0aW1lKSkgJT4lXG4gIG11dGF0ZShtb250aCA9IG1vbnRoKGRhdGV0aW1lLCBsYWJlbCA9IFRSVUUsIGFiYnIgPSBGQUxTRSkpICU+JVxuICBncm91cF9ieSh5ZWFyLCBtb250aCwgdmFyaWFibGUpICU+JVxuICByZWZyYW1lKG1lYW4gPSBtZWFuKHZhcmlhYmxlX3ZhbHVlLCBuYS5ybSA9IFRSVUUpLCBcbiAgICAgICAgICBtZWRpYW4gPSBtZWRpYW4odmFyaWFibGVfdmFsdWUsIG5hLnJtID0gVFJVRSksXG4gICAgICAgICAgc3RkID0gc2QodmFyaWFibGVfdmFsdWUsIG5hLnJtID0gVFJVRSksXG4gICAgICAgICAgSVFSID0gSVFSKHZhcmlhYmxlX3ZhbHVlLCBuYS5ybSA9IFRSVUUpLFxuICAgICAgICAgIG1pbiA9IG1pbih2YXJpYWJsZV92YWx1ZSwgbmEucm0gPSBUUlVFKSxcbiAgICAgICAgICBtYXggPSBtYXgodmFyaWFibGVfdmFsdWUsIG5hLnJtID0gVFJVRSkpJT4lXG4gIG11dGF0ZShhY3Jvc3Mod2hlcmUoaXMubnVtZXJpYyksIHJvdW5kLCAyKSlcbmBgYCJ9 -->

```r
dfMonth <- dfEditPivot %>%
  mutate(year = year(datetime)) %>%
  mutate(month = month(datetime, label = TRUE, abbr = FALSE)) %>%
  group_by(year, month, variable) %>%
  reframe(mean = mean(variable_value, na.rm = TRUE), 
          median = median(variable_value, na.rm = TRUE),
          std = sd(variable_value, na.rm = TRUE),
          IQR = IQR(variable_value, na.rm = TRUE),
          min = min(variable_value, na.rm = TRUE),
          max = max(variable_value, na.rm = TRUE))%>%
  mutate(across(where(is.numeric), round, 2))
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiV2FybmluZzogVGhlcmUgd2VyZSAyMzY2IHdhcm5pbmdzIGluIGByZWZyYW1lKClgLlxuVGhlIGZpcnN0IHdhcm5pbmcgd2FzOlxu4oS5IEluIGFyZ3VtZW50OiBgbWluID0gbWluKHZhcmlhYmxlX3ZhbHVlLCBuYS5ybSA9IFRSVUUpYC5cbuKEuSBJbiBncm91cCAxOiBgeWVhciA9IDIwMTFgLCBgbW9udGggPSBKdWx5YCwgYHZhcmlhYmxlID0gXCJjaGxvcm9waHlsbF9yZnVcImAuXG5DYXVzZWQgYnkgd2FybmluZyBpbiBgbWluKClgOlxuISBubyBub24tbWlzc2luZyBhcmd1bWVudHMgdG8gbWluOyByZXR1cm5pbmcgSW5mXG7ihLkgUnVuIFx1MDAxYl04OztpZGU6cnVuOmRwbHlyOjpsYXN0X2RwbHlyX3dhcm5pbmdzKClcdTAwMDdkcGx5cjo6bGFzdF9kcGx5cl93YXJuaW5ncygpXHUwMDFiXTg7O1x1MDAwNyB0byBzZWUgdGhlIDIzNjUgcmVtYWluaW5nIHdhcm5pbmdzLlxuIn0= -->

```
Warning: There were 2366 warnings in `reframe()`.
The first warning was:
ℹ In argument: `min = min(variable_value, na.rm = TRUE)`.
ℹ In group 1: `year = 2011`, `month = July`, `variable = "chlorophyll_rfu"`.
Caused by warning in `min()`:
! no non-missing arguments to min; returning Inf
ℹ Run ]8;;ide:run:dplyr::last_dplyr_warnings()dplyr::last_dplyr_warnings()]8;; to see the 2365 remaining warnings.
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZGZNb250aFtzYXBwbHkoZGZNb250aCwgaXMuaW5maW5pdGUpXSA8LSBOQSAjdHVybiBpbmZpbml0ZSB2YWx1ZXMgaW50byBOQXMgdGhhdCB3ZXJlIGludHJvZHVjZWQgd2hlbiBydW5uaW5nIG1pbiBhbmQgbWF4IG9uIHZhcmlhYmxlcyB0aGF0IGRpZCBub3QgaGF2ZSBhbnkgZGF0YVxuXG5gYGAifQ== -->

```r
dfMonth[sapply(dfMonth, is.infinite)] <- NA #turn infinite values into NAs that were introduced when running min and max on variables that did not have any data

```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


## Daily Statistics
Summary statistics by day

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZGZEYXkgPC0gZGZFZGl0UGl2b3QgJT4lXG4gIG11dGF0ZSh5ZWFyID0geWVhcihkYXRldGltZSkpICU+JVxuICBtdXRhdGUobW9udGggPSBtb250aChkYXRldGltZSwgbGFiZWwgPSBUUlVFLCBhYmJyID0gRkFMU0UpKSAlPiVcbiAgbXV0YXRlKGRheSA9IGRheShkYXRldGltZSkpICU+JSAjaWYgd2FudCBkYXlzIG9mIHdlZWsgaW5zdGVhZCBvZiBudW1iZXJzIG9mIG1vbnRoLCB1c2Ugd2RheSgpXG4gIGdyb3VwX2J5KHllYXIsIG1vbnRoLCBkYXksIHZhcmlhYmxlKSAlPiVcbiAgcmVmcmFtZShtZWFuID0gbWVhbih2YXJpYWJsZV92YWx1ZSwgbmEucm0gPSBUUlVFKSwgXG4gICAgICAgICAgbWVkaWFuID0gbWVkaWFuKHZhcmlhYmxlX3ZhbHVlLCBuYS5ybSA9IFRSVUUpLFxuICAgICAgICAgIHN0ZCA9IHNkKHZhcmlhYmxlX3ZhbHVlLCBuYS5ybSA9IFRSVUUpLFxuICAgICAgICAgIElRUiA9IElRUih2YXJpYWJsZV92YWx1ZSwgbmEucm0gPSBUUlVFKSxcbiAgICAgICAgICBtaW4gPSBtaW4odmFyaWFibGVfdmFsdWUsIG5hLnJtID0gVFJVRSksXG4gICAgICAgICAgbWF4ID0gbWF4KHZhcmlhYmxlX3ZhbHVlLCBuYS5ybSA9IFRSVUUpKSU+JVxuICBtdXRhdGUoYWNyb3NzKHdoZXJlKGlzLm51bWVyaWMpLCByb3VuZCwgMikpXG5gYGAifQ== -->

```r
dfDay <- dfEditPivot %>%
  mutate(year = year(datetime)) %>%
  mutate(month = month(datetime, label = TRUE, abbr = FALSE)) %>%
  mutate(day = day(datetime)) %>% #if want days of week instead of numbers of month, use wday()
  group_by(year, month, day, variable) %>%
  reframe(mean = mean(variable_value, na.rm = TRUE), 
          median = median(variable_value, na.rm = TRUE),
          std = sd(variable_value, na.rm = TRUE),
          IQR = IQR(variable_value, na.rm = TRUE),
          min = min(variable_value, na.rm = TRUE),
          max = max(variable_value, na.rm = TRUE))%>%
  mutate(across(where(is.numeric), round, 2))
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiV2FybmluZzogVGhlcmUgd2VyZSA2ODgzMCB3YXJuaW5ncyBpbiBgcmVmcmFtZSgpYC5cblRoZSBmaXJzdCB3YXJuaW5nIHdhczpcbuKEuSBJbiBhcmd1bWVudDogYG1pbiA9IG1pbih2YXJpYWJsZV92YWx1ZSwgbmEucm0gPSBUUlVFKWAuXG7ihLkgSW4gZ3JvdXAgMTogYHllYXIgPSAyMDExYCwgYG1vbnRoID0gSnVseWAsIGBkYXkgPSAyMmAsIGB2YXJpYWJsZSA9XG4gIFwiY2hsb3JvcGh5bGxfcmZ1XCJgLlxuQ2F1c2VkIGJ5IHdhcm5pbmcgaW4gYG1pbigpYDpcbiEgbm8gbm9uLW1pc3NpbmcgYXJndW1lbnRzIHRvIG1pbjsgcmV0dXJuaW5nIEluZlxu4oS5IFJ1biBcdTAwMWJdODs7aWRlOnJ1bjpkcGx5cjo6bGFzdF9kcGx5cl93YXJuaW5ncygpXHUwMDA3ZHBseXI6Omxhc3RfZHBseXJfd2FybmluZ3MoKVx1MDAxYl04OztcdTAwMDcgdG8gc2VlIHRoZSA2ODgyOSByZW1haW5pbmcgd2FybmluZ3MuXG4ifQ== -->

```
Warning: There were 68830 warnings in `reframe()`.
The first warning was:
ℹ In argument: `min = min(variable_value, na.rm = TRUE)`.
ℹ In group 1: `year = 2011`, `month = July`, `day = 22`, `variable =
  "chlorophyll_rfu"`.
Caused by warning in `min()`:
! no non-missing arguments to min; returning Inf
ℹ Run ]8;;ide:run:dplyr::last_dplyr_warnings()dplyr::last_dplyr_warnings()]8;; to see the 68829 remaining warnings.
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZGZEYXlbc2FwcGx5KGRmRGF5LCBpcy5pbmZpbml0ZSldIDwtIE5BICN0dXJuIGluZmluaXRlIHZhbHVlcyBpbnRvIE5BcyB0aGF0IHdlcmUgaW50cm9kdWNlZCB3aGVuIHJ1bm5pbmcgbWluIGFuZCBtYXggb24gdmFyaWFibGVzIHRoYXQgZGlkIG5vdCBoYXZlIGFueSBkYXRhXG5cbmBgYCJ9 -->

```r
dfDay[sapply(dfDay, is.infinite)] <- NA #turn infinite values into NAs that were introduced when running min and max on variables that did not have any data

```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


### Example code from Dan

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuaG9ib3BoPC0gZGlzdGluY3QoaG9ib3BoKSNyZW1vdmUgYW55IGR1cGxpY2F0ZSByb3dzXG5ob2JvcGg8LXN1YnNldChob2JvcGgsaXMubmEoaG9ib3BoJERhdGV0aW1lKT09RkFMU0UpICNyZW1vdmUgYW55IE5Bc1xuXG5ob2JvcGggPC0gaG9ib3BoICU+JSBcbiAgbXV0YXRlX2F0KGMoMjo0KSwgYXMubnVtZXJpYykgI21ha2UgYW55IGNvbHVtbnMgdGhhdCBtaWdodCBiZSBzdHVjayBhcyBmYWN0b3JzIG51bWVyaWNcbmhvYm9waDwtYXNfdGJsX3RpbWUoaG9ib3BoLGluZGV4PURhdGV0aW1lKSAjY3JlYXRlIGEgdGltZSB0aWJibGVcbmhvYm90Ymw8LSBob2JvcGggJT4lIGFycmFuZ2UoeW1kX2htcyhob2JvcGgkRGF0ZXRpbWUpKSAjb3JkZXIgYnkgZGF5XG5cbiN0aGlzIHN5bnRheCBjYW4gYmUgdXNlZCB0byBhZ2dyZWdhdGUgdGhlIGRhdGEgYnkgYWxsIHNvcnRzIG9mIHBlcmlvZHMgaW5jbHVkaW5nIHdlZWssIGhvdXIsIGV0Y1xuaG9ib3BoZGF5PC1ob2JvdGJsICU+JVxuICBjb2xsYXBzZV9ieShcImRheVwiKSAlPiVcbiAgZ3JvdXBfYnkoRGF0ZXRpbWUsRGF0ZSklPiVcbiAgc3VtbWFyaXNlKGFjcm9zcyh3aGVyZShpcy5udW1lcmljKSwgfiBtZWFuKC54LCBuYS5ybSA9IFRSVUUpKSlcbmBgYCJ9 -->

```r
hoboph<- distinct(hoboph)#remove any duplicate rows
hoboph<-subset(hoboph,is.na(hoboph$Datetime)==FALSE) #remove any NAs

hoboph <- hoboph %>% 
  mutate_at(c(2:4), as.numeric) #make any columns that might be stuck as factors numeric
hoboph<-as_tbl_time(hoboph,index=Datetime) #create a time tibble
hobotbl<- hoboph %>% arrange(ymd_hms(hoboph$Datetime)) #order by day

#this syntax can be used to aggregate the data by all sorts of periods including week, hour, etc
hobophday<-hobotbl %>%
  collapse_by("day") %>%
  group_by(Datetime,Date)%>%
  summarise(across(where(is.numeric), ~ mean(.x, na.rm = TRUE)))
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->

