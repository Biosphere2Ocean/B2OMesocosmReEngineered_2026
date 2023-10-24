
<!-- rnb-text-begin -->

---
title: "YSI Figures Pre-QC"
Collaborators: Renee Grambihler
Project: OceanWaterQuality
Institution: Biosphere 2 Ocean
output: html_notebook
---


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeSh0aWR5dmVyc2UpXG5gYGAifQ== -->

```r
library(tidyverse)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoi4pSA4pSAIEF0dGFjaGluZyBjb3JlIHRpZHl2ZXJzZSBwYWNrYWdlcyDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIAgdGlkeXZlcnNlIDIuMC4wIOKUgOKUgFxu4pyUIGRwbHlyICAgICAxLjEuMyAgICAg4pyUIHJlYWRyICAgICAyLjEuNFxu4pyUIGZvcmNhdHMgICAxLjAuMCAgICAg4pyUIHN0cmluZ3IgICAxLjUuMFxu4pyUIGdncGxvdDIgICAzLjQuMyAgICAg4pyUIHRpYmJsZSAgICAzLjIuMVxu4pyUIGx1YnJpZGF0ZSAxLjkuMiAgICAg4pyUIHRpZHlyICAgICAxLjMuMFxu4pyUIHB1cnJyICAgICAxLjAuMiAgICAg4pSA4pSAIENvbmZsaWN0cyDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIAgdGlkeXZlcnNlX2NvbmZsaWN0cygpIOKUgOKUgFxu4pyWIGRwbHlyOjpmaWx0ZXIoKSBtYXNrcyBzdGF0czo6ZmlsdGVyKClcbuKcliBkcGx5cjo6bGFnKCkgICAgbWFza3Mgc3RhdHM6OmxhZygpXG7ihLkgVXNlIHRoZSBcdTAwMWJdODs7aHR0cDovL2NvbmZsaWN0ZWQuci1saWIub3JnL1x1MDAwN2NvbmZsaWN0ZWQgcGFja2FnZVx1MDAxYl04OztcdTAwMDcgdG8gZm9yY2UgYWxsIGNvbmZsaWN0cyB0byBiZWNvbWUgZXJyb3JzXG4ifQ== -->

```
── Attaching core tidyverse packages ───────────────────────────────────────────────────────────── tidyverse 2.0.0 ──
✔ dplyr     1.1.3     ✔ readr     2.1.4
✔ forcats   1.0.0     ✔ stringr   1.5.0
✔ ggplot2   3.4.3     ✔ tibble    3.2.1
✔ lubridate 1.9.2     ✔ tidyr     1.3.0
✔ purrr     1.0.2     ── Conflicts ─────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
ℹ Use the ]8;;http://conflicted.r-lib.org/conflicted package]8;; to force all conflicts to become errors
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeShsdWJyaWRhdGUpXG5gYGAifQ== -->

```r
library(lubridate)
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


# Import Data

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBXcmFuZ2xlZCBkYXRhIGJlZm9yZSBRQyAtLSBvdXRsaWVycyBzdGlsbCBwcmVzZW50XG5kZiA8LSByZWFkX2NzdihcIkRhdGEvQ2xlYW5EYXRhL0NsZWFuRGF0YV9ZU0kvMDFfRGF0YVdyYW5nbGluZy8wMS1PY2VhbldhdGVyUXVhbGl0eURhdGEuY3N2XCIpXG5gYGAifQ== -->

```r
# Wrangled data before QC -- outliers still present
df <- read_csv("Data/CleanData/CleanData_YSI/01_DataWrangling/01-OceanWaterQualityData.csv")
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiUm93czogNDYxNzgyIENvbHVtbnM6IDE54pSA4pSAIENvbHVtbiBzcGVjaWZpY2F0aW9uIOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgFxuRGVsaW1pdGVyOiBcIixcIlxuZGJsICAoMTcpOiB0ZW1wX2YsIHRlbXBfYywgcEgsIHBIX21WLCBzYWxpbml0eV9wc3UsIGNvbmR1Y3Rpdml0eV91U2NtLCBubGZfY29uZHVjdGl2aXR5X3VTY20sIHNwX2NvbmR1Y3Rpdml0eV91U2MuLi5cbmRhdGUgICgxKTogZGF0ZVxudGltZSAgKDEpOiB0aW1lXG7ihLkgVXNlIGBzcGVjKClgIHRvIHJldHJpZXZlIHRoZSBmdWxsIGNvbHVtbiBzcGVjaWZpY2F0aW9uIGZvciB0aGlzIGRhdGEuXG7ihLkgU3BlY2lmeSB0aGUgY29sdW1uIHR5cGVzIG9yIHNldCBgc2hvd19jb2xfdHlwZXMgPSBGQUxTRWAgdG8gcXVpZXQgdGhpcyBtZXNzYWdlLlxuIn0= -->

```
Rows: 461782 Columns: 19── Column specification ─────────────────────────────────────────────────────────────────────────────────────────────
Delimiter: ","
dbl  (17): temp_f, temp_c, pH, pH_mV, salinity_psu, conductivity_uScm, nlf_conductivity_uScm, sp_conductivity_uSc...
date  (1): date
time  (1): time
ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->

# Data Formatting

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBwaXZvdCBkZiBsb25nZXIgZm9yIGVhc2llciBhbGwtdmFyaWFibGUgcGxvdHRpbmdcbmRmUGl2b3QgPC0gZGYgJT4lXG4gIHBpdm90X2xvbmdlcihjb2xzID0gdGVtcF9mOnRvdGFsX2Rpc3NvbHZlZF9zb2xpZHNfbWdMLFxuICAgICAgICAgICAgICAgbmFtZXNfdG8gPSBcInZhcmlhYmxlXCIsXG4gICAgICAgICAgICAgICB2YWx1ZXNfdG8gPSBcInZhcmlhYmxlX3ZhbHVlXCIpJT4lXG4gIG11dGF0ZShkYXRlID0gYXMuRGF0ZShkYXRlLCBmb3JtYXQgPSBcIiVZLyVtLyVkXCIpKVxuYGBgIn0= -->

```r
# pivot df longer for easier all-variable plotting
dfPivot <- df %>%
  pivot_longer(cols = temp_f:total_dissolved_solids_mgL,
               names_to = "variable",
               values_to = "variable_value")%>%
  mutate(date = as.Date(date, format = "%Y/%m/%d"))
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


# Plotting
## Pre-QC Plots

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->



<!-- rnb-chunk-end -->

