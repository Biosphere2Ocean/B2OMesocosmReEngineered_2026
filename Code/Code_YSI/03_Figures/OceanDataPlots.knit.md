
<!-- rnb-text-begin -->

---
title: "Ocean Data Plots"
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

<!-- rnb-output-begin eyJkYXRhIjoi4pSA4pSAIEF0dGFjaGluZyBjb3JlIHRpZHl2ZXJzZSBwYWNrYWdlcyDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIAgdGlkeXZlcnNlIDIuMC4wIOKUgOKUgFxu4pyUIGRwbHlyICAgICAxLjEuMyAgICAg4pyUIHJlYWRyICAgICAyLjEuNFxu4pyUIGZvcmNhdHMgICAxLjAuMCAgICAg4pyUIHN0cmluZ3IgICAxLjUuMFxu4pyUIGdncGxvdDIgICAzLjQuMyAgICAg4pyUIHRpYmJsZSAgICAzLjIuMVxu4pyUIGx1YnJpZGF0ZSAxLjkuMiAgICAg4pyUIHRpZHlyICAgICAxLjMuMFxu4pyUIHB1cnJyICAgICAxLjAuMiAgICAg4pSA4pSAIENvbmZsaWN0cyDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIAgdGlkeXZlcnNlX2NvbmZsaWN0cygpIOKUgOKUgFxu4pyWIGRwbHlyOjpmaWx0ZXIoKSBtYXNrcyBzdGF0czo6ZmlsdGVyKClcbuKcliBkcGx5cjo6bGFnKCkgICAgbWFza3Mgc3RhdHM6OmxhZygpXG7ihLkgVXNlIHRoZSBcdTAwMWJdODs7aHR0cDovL2NvbmZsaWN0ZWQuci1saWIub3JnL1x1MDAwN2NvbmZsaWN0ZWQgcGFja2FnZVx1MDAxYl04OztcdTAwMDcgdG8gZm9yY2UgYWxsIGNvbmZsaWN0cyB0byBiZWNvbWUgZXJyb3JzXG4ifQ== -->

```
── Attaching core tidyverse packages ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── tidyverse 2.0.0 ──
✔ dplyr     1.1.3     ✔ readr     2.1.4
✔ forcats   1.0.0     ✔ stringr   1.5.0
✔ ggplot2   3.4.3     ✔ tibble    3.2.1
✔ lubridate 1.9.2     ✔ tidyr     1.3.0
✔ purrr     1.0.2     ── Conflicts ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
ℹ Use the ]8;;http://conflicted.r-lib.org/conflicted package]8;; to force all conflicts to become errors
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeShsdWJyaWRhdGUpXG5saWJyYXJ5KGhlcmUpXG5gYGAifQ== -->

```r
library(lubridate)
library(here)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiaGVyZSgpIHN0YXJ0cyBhdCAvVXNlcnMvZ3JhbWJpaGxlci9MaWJyYXJ5L0Nsb3VkU3RvcmFnZS9PbmVEcml2ZS1Vbml2ZXJzaXR5b2ZBcml6b25hL0RhdGEvR2l0SHViL09jZWFuV2F0ZXJRdWFsaXR5XG4ifQ== -->

```
here() starts at /Users/grambihler/Library/CloudStorage/OneDrive-UniversityofArizona/Data/GitHub/OceanWaterQuality
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


# Import Data

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBEYXRhIGFmdGVyIFFDIC0tIHZhbHVlcyBvdXRzaWRlIG9mIDIgc2lnbWEgYXdheSBmcm9tIG1lYW4gb2YgZXZlcnkgbW9udGggZm9yIGV2ZXJ5IHZhcmlhYmxlIHdlcmUgdHVybmVkIGludG8gTkEgdmFsdWVzXG5kZlFDIDwtIHJlYWRfY3N2KGhlcmUoXCJEYXRhL0NsZWFuRGF0YS9DbGVhbkRhdGFZU0kvMDJfUXVhbGl0eUNvbnRyb2wvUUNPY2VhbldhdGVyUXVhbGl0eUZyYW1lLmNzdlwiKSlcblxuYGBgIn0= -->

```r
# Data after QC -- values outside of 2 sigma away from mean of every month for every variable were turned into NA values
dfQC <- read_csv(here("Data/CleanData/CleanDataYSI/02_QualityControl/QCOceanWaterQualityFrame.csv"))

```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiUm93czogNDYxNzgyIENvbHVtbnM6IDE54pSA4pSAIENvbHVtbiBzcGVjaWZpY2F0aW9uIOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgFxuRGVsaW1pdGVyOiBcIixcIlxuZGJsICAoMTcpOiB0ZW1wX2YsIHRlbXBfYywgcEgsIHBIX21WLCBzYWxpbml0eV9wc3UsIGNvbmR1Y3Rpdml0eV91U2NtLCBubGZfY29uZHVjdGl2aXR5X3VTY20sIHNwX2NvbmR1Y3Rpdml0eV91U2NtLCBkb19tZ0wsIGRvX3NhdHVyLi4uXG5kYXRlICAoMSk6IGRhdGVcbnRpbWUgICgxKTogdGltZVxu4oS5IFVzZSBgc3BlYygpYCB0byByZXRyaWV2ZSB0aGUgZnVsbCBjb2x1bW4gc3BlY2lmaWNhdGlvbiBmb3IgdGhpcyBkYXRhLlxu4oS5IFNwZWNpZnkgdGhlIGNvbHVtbiB0eXBlcyBvciBzZXQgYHNob3dfY29sX3R5cGVzID0gRkFMU0VgIHRvIHF1aWV0IHRoaXMgbWVzc2FnZS5cbiJ9 -->

```
Rows: 461782 Columns: 19── Column specification ────────────────────────────────────────────────────────────────────────────────────────────────────────────────
Delimiter: ","
dbl  (17): temp_f, temp_c, pH, pH_mV, salinity_psu, conductivity_uScm, nlf_conductivity_uScm, sp_conductivity_uScm, do_mgL, do_satur...
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


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuYGBgclxuUUNNZWFuRGFpbHlWYWx1ZUZyYW1lIDwtIFFDT2NlYW5XYXRlclF1YWxpdHlGcmFtZSAlPiVcbiAgbXV0YXRlKGRhdGUgPSBkYXRlKGRhdGV0aW1lKSkgJT4lXG4gIGdyb3VwX2J5KHZhcmlhYmxlLCBkYXRlKSAlPiVcbiAgc3VtbWFyaXNlKG1lYW5fZGFpbHlfdmFsdWUgPSBtZWFuKHZhcmlhYmxlX3ZhbHVlLCBuYS5ybSA9IFRSVUUpKVxuXG5gYGBcbmBgYFxuYGBgIn0= -->

```r
```r
```r
QCMeanDailyValueFrame <- QCOceanWaterQualityFrame %>%
  mutate(date = date(datetime)) %>%
  group_by(variable, date) %>%
  summarise(mean_daily_value = mean(variable_value, na.rm = TRUE))

```
```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


# Plotting
## Pre-QC Plots

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuIyBsaW5lIGdyYXBoIG9mIGV2ZXJ5IHZhcmlhYmxlIC0gZmFjZXQgd3JhcHBlZCBcbkFsbFZhcmlhYmxlUGxvdF9Qb3N0UUMgPC0gZGZRQ1Bpdm90ICU+JVxuICBnZ3Bsb3QoYWVzKHggPSBkYXRlLCBcbiAgICAgICAgICAgICB5ID0gdmFyaWFibGVfdmFsdWUpKSArXG4gIGdlb21fbGluZSgpICtcbiAgZmFjZXRfd3JhcCh+dmFyaWFibGUsIG5jb2wgPSAzLCBzY2FsZXMgPSBcXGZyZWVcXCkrXG4gIHNjYWxlX3hfZGF0ZShicmVha3MgPSB3YWl2ZXIoKSwgZGF0ZV9icmVha3MgPSBcXDEgeWVhclxcLFxuICAgICAgICAgICAgICAgZGF0ZV9sYWJlbHMgPSBcXCViICVZXFwpICtcbiAgdGhlbWVfYncoKSArIFxuICB0aGVtZShwYW5lbC5ncmlkLm1ham9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuZ3JpZC5taW5vciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmJhY2tncm91bmQgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBheGlzLmxpbmUgPSBlbGVtZW50X2xpbmUoY29sb3VyID0gXFxibGFja1xcKSkrXG4gIHRoZW1lKGF4aXMudGV4dC54ID0gZWxlbWVudF90ZXh0KGFuZ2xlID0gNDUsIGhqdXN0ID0gMSksXG4gICAgICAgIHBsb3QubWFyZ2luID0gbWFyZ2luKDAuMjUsIDAuNDUsIDAuMjUsIDAuMjUsIFxcaW5jaFxcKSkrXG4gIHRoZW1lKHN0cmlwLmJhY2tncm91bmQgPSBlbGVtZW50X3JlY3QoZmlsbCA9IFxcd2hpdGVcXCkpK1xuICBsYWJzKHRpdGxlID0gXFxCMk8gV2F0ZXIgUXVhbGl0eSBieSBWYXJpYWJsZSBmcm9tIDIwMTEtMjAyM1xcLFxuICAgICAgIHN1YnRpdGxlID0gXFxQb3N0LVFDOiBEYXRhIE91dHNpZGUgMi1TaWdtYSBmcm9tIE1lYW4gaGFzIGJlZW4gUmVtb3ZlZFxcKStcbiAgeGxhYihcXERhdGVcXCkrXG4gIHlsYWIoXFxOdXRyaWVudCBWYWx1ZVxcKVxuIyBTYXZlIHBsb3Rcbmdnc2F2ZShmaWxlbmFtZSA9IFxcQWxsVmFyaWFibGVQbG90LVBvc3RRQy5wZGZcXCwgcGxvdCA9IEFsbFZhcmlhYmxlUGxvdF9Qb3N0UUMsIFxuICAgICAgIHBhdGggPSBcXC9Vc2Vycy9ncmFtYmlobGVyL0RvY3VtZW50cy9EYXRhL0dpdEh1Yi9PY2VhbldhdGVyUXVhbGl0eS9GaWd1cmVzL1lTSS1maWd1cmVzL1Bvc3RRQ1Bsb3RzXFwsIGhlaWdodCA9IDEyLCB3aWR0aCA9IDEwKVxuXG4jIGxpbmUgZ3JhcGggb2YgdGVtcGVyYXR1cmUgaW4gZmFocmVuaGVpdFxuVGVtcEZQbG90X1Bvc3RRQyA8LSBkZlFDUGl2b3QgJT4lXG4gIGZpbHRlcih2YXJpYWJsZSA9PSBcXHRlbXBfZlxcKSAlPiVcbiAgZ2dwbG90KGFlcyh4ID0gZGF0ZSwgXG4gICAgICAgICAgICAgeSA9IHZhcmlhYmxlX3ZhbHVlKSkgK1xuICBnZW9tX2xpbmUoKSArXG4gIHNjYWxlX3hfZGF0ZShicmVha3MgPSB3YWl2ZXIoKSwgZGF0ZV9icmVha3MgPSBcXDEgeWVhclxcLFxuICAgICAgICAgICAgICAgZGF0ZV9sYWJlbHMgPSBcXCViICVZXFwpICtcbiAgdGhlbWVfYncoKSArIFxuICB0aGVtZShwYW5lbC5ncmlkLm1ham9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuZ3JpZC5taW5vciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmJhY2tncm91bmQgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBheGlzLmxpbmUgPSBlbGVtZW50X2xpbmUoY29sb3VyID0gXFxibGFja1xcKSkrXG4gIHRoZW1lKGF4aXMudGV4dC54ID0gZWxlbWVudF90ZXh0KGFuZ2xlID0gNDUsIGhqdXN0ID0gMSksXG4gICAgICAgIHBsb3QubWFyZ2luID0gbWFyZ2luKDAuMjUsIDAuNDUsIDAuMjUsIDAuMjUsIFxcaW5jaFxcKSkrXG4gIHRoZW1lKHN0cmlwLmJhY2tncm91bmQgPSBlbGVtZW50X3JlY3QoZmlsbCA9IFxcd2hpdGVcXCkpK1xuICBsYWJzKHRpdGxlID0gXFxCMk8gVGVtcGVyYXR1cmUgKMK6RikgZnJvbSAyMDExLTIwMjNcXCxcbiAgICAgICBzdWJ0aXRsZSA9IFxcUG9zdC1RQzogRGF0YSBPdXRzaWRlIDItU2lnbWEgZnJvbSBNZWFuIGhhcyBiZWVuIFJlbW92ZWRcXCkrXG4gIHhsYWIoXFxEYXRlXFwpK1xuICB5bGFiKFxcVGVtcGVyYXR1cmUgKMK6RilcXClcbiMgU2F2ZSBwbG90XG5nZ3NhdmUoZmlsZW5hbWUgPSBcXFRlbXBGUGxvdC1Qb3N0UUMucGRmXFwsIHBsb3QgPSBUZW1wRlBsb3RfUG9zdFFDLCBcbiAgICAgICBwYXRoID0gXFwvVXNlcnMvZ3JhbWJpaGxlci9Eb2N1bWVudHMvRGF0YS9HaXRIdWIvT2NlYW5XYXRlclF1YWxpdHkvRmlndXJlcy9ZU0ktZmlndXJlcy9Qb3N0UUNQbG90c1xcKVxuXG4jIGxpbmUgZ3JhcGggb2YgdGVtcCBpbiBjZWxjaXVzXG5UZW1wQ1Bsb3RfUG9zdFFDIDwtIGRmUUNQaXZvdCAlPiVcbiAgZmlsdGVyKHZhcmlhYmxlID09IFxcdGVtcF9jXFwpJT4lXG4gIGdncGxvdChhZXMoeCA9IGRhdGUsIFxuICAgICAgICAgICAgIHkgPSB2YXJpYWJsZV92YWx1ZSkpICtcbiAgZ2VvbV9saW5lKCkgK1xuICBzY2FsZV94X2RhdGUoYnJlYWtzID0gd2FpdmVyKCksIGRhdGVfYnJlYWtzID0gXFwxIHllYXJcXCxcbiAgICAgICAgICAgICAgIGRhdGVfbGFiZWxzID0gXFwlYiAlWVxcKSArXG4gIHRoZW1lX2J3KCkgKyBcbiAgdGhlbWUocGFuZWwuZ3JpZC5tYWpvciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmdyaWQubWlub3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5iYWNrZ3JvdW5kID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgYXhpcy5saW5lID0gZWxlbWVudF9saW5lKGNvbG91ciA9IFxcYmxhY2tcXCkpK1xuICB0aGVtZShheGlzLnRleHQueCA9IGVsZW1lbnRfdGV4dChhbmdsZSA9IDQ1LCBoanVzdCA9IDEpLFxuICAgICAgICBwbG90Lm1hcmdpbiA9IG1hcmdpbigwLjI1LCAwLjQ1LCAwLjI1LCAwLjI1LCBcXGluY2hcXCkpK1xuICB0aGVtZShzdHJpcC5iYWNrZ3JvdW5kID0gZWxlbWVudF9yZWN0KGZpbGwgPSBcXHdoaXRlXFwpKStcbiAgbGFicyh0aXRsZSA9IFxcQjJPIFRlbXBlcmF0dXJlICjCukMpIGZyb20gMjAxMS0yMDIzXFwsXG4gICAgICAgc3VidGl0bGUgPSBcXFBvc3QtUUM6IERhdGEgT3V0c2lkZSAyLVNpZ21hIGZyb20gTWVhbiBoYXMgYmVlbiBSZW1vdmVkXFwpK1xuICB4bGFiKFxcRGF0ZVxcKStcbiAgeWxhYihcXFRlbXBlcmF0dXJlICjCukMpXFwpXG4jIFNhdmUgcGxvdFxuZ2dzYXZlKGZpbGVuYW1lID0gXFxUZW1wQ1Bsb3QtUG9zdFFDLnBkZlxcLCBwbG90ID0gVGVtcENQbG90X1Bvc3RRQywgXG4gICAgICAgcGF0aCA9IFxcL1VzZXJzL2dyYW1iaWhsZXIvRG9jdW1lbnRzL0RhdGEvR2l0SHViL09jZWFuV2F0ZXJRdWFsaXR5L0ZpZ3VyZXMvWVNJLWZpZ3VyZXMvUG9zdFFDUGxvdHNcXClcblxuIyBsaW5lIGdyYXBoIG9mIHBIIGluIHBIIHVuaXRzXG5wSFBsb3RfUG9zdFFDIDwtIGRmUUNQaXZvdCAlPiVcbiAgZmlsdGVyKHZhcmlhYmxlID09IFxccEhcXCkgJT4lXG4gIGdncGxvdChhZXMoeCA9IGRhdGUsIFxuICAgICAgICAgICAgIHkgPSB2YXJpYWJsZV92YWx1ZSkpICtcbiAgZ2VvbV9saW5lKCkgK1xuICBzY2FsZV94X2RhdGUoYnJlYWtzID0gd2FpdmVyKCksIGRhdGVfYnJlYWtzID0gXFwxIHllYXJcXCxcbiAgICAgICAgICAgICAgIGRhdGVfbGFiZWxzID0gXFwlYiAlWVxcKSArXG4gIHRoZW1lX2J3KCkgKyBcbiAgdGhlbWUocGFuZWwuZ3JpZC5tYWpvciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmdyaWQubWlub3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5iYWNrZ3JvdW5kID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgYXhpcy5saW5lID0gZWxlbWVudF9saW5lKGNvbG91ciA9IFxcYmxhY2tcXCkpK1xuICB0aGVtZShheGlzLnRleHQueCA9IGVsZW1lbnRfdGV4dChhbmdsZSA9IDQ1LCBoanVzdCA9IDEpLFxuICAgICAgICBwbG90Lm1hcmdpbiA9IG1hcmdpbigwLjI1LCAwLjQ1LCAwLjI1LCAwLjI1LCBcXGluY2hcXCkpK1xuICB0aGVtZShzdHJpcC5iYWNrZ3JvdW5kID0gZWxlbWVudF9yZWN0KGZpbGwgPSBcXHdoaXRlXFwpKStcbiAgbGFicyh0aXRsZSA9IFxcQjJPIHBIIGZyb20gMjAxMS0yMDIzXFwsXG4gICAgICAgc3VidGl0bGUgPSBcXFBvc3QtUUM6IERhdGEgT3V0c2lkZSAyLVNpZ21hIGZyb20gTWVhbiBoYXMgYmVlbiBSZW1vdmVkXFwpK1xuICB4bGFiKFxcRGF0ZVxcKStcbiAgeWxhYihcXHBIXFwpXG4jIFNhdmUgcGxvdFxuZ2dzYXZlKGZpbGVuYW1lID0gXFxwSFBsb3QtUG9zdFFDLnBkZlxcLCBwbG90ID0gcEhQbG90X1Bvc3RRQywgXG4gICAgICAgcGF0aCA9IFxcL1VzZXJzL2dyYW1iaWhsZXIvRG9jdW1lbnRzL0RhdGEvR2l0SHViL09jZWFuV2F0ZXJRdWFsaXR5L0ZpZ3VyZXMvWVNJLWZpZ3VyZXMvUG9zdFFDUGxvdHNcXClcblxuIyBsaW5lIGdyYXBoIG9mIHBIIGluIG1WXG5wSG1WUGxvdF9Qb3N0UUMgPC0gZGZRQ1Bpdm90ICU+JVxuICBmaWx0ZXIodmFyaWFibGUgPT0gXFxwSF9tVlxcKSAlPiVcbiAgZ2dwbG90KGFlcyh4ID0gZGF0ZSwgXG4gICAgICAgICAgICAgeSA9IHZhcmlhYmxlX3ZhbHVlKSkgK1xuICBnZW9tX2xpbmUoKSArXG4gIHNjYWxlX3hfZGF0ZShicmVha3MgPSB3YWl2ZXIoKSwgZGF0ZV9icmVha3MgPSBcXDEgeWVhclxcLFxuICAgICAgICAgICAgICAgZGF0ZV9sYWJlbHMgPSBcXCViICVZXFwpICtcbiAgdGhlbWVfYncoKSArIFxuICB0aGVtZShwYW5lbC5ncmlkLm1ham9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuZ3JpZC5taW5vciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmJhY2tncm91bmQgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBheGlzLmxpbmUgPSBlbGVtZW50X2xpbmUoY29sb3VyID0gXFxibGFja1xcKSkrXG4gIHRoZW1lKGF4aXMudGV4dC54ID0gZWxlbWVudF90ZXh0KGFuZ2xlID0gNDUsIGhqdXN0ID0gMSksXG4gICAgICAgIHBsb3QubWFyZ2luID0gbWFyZ2luKDAuMjUsIDAuNDUsIDAuMjUsIDAuMjUsIFxcaW5jaFxcKSkrXG4gIHRoZW1lKHN0cmlwLmJhY2tncm91bmQgPSBlbGVtZW50X3JlY3QoZmlsbCA9IFxcd2hpdGVcXCkpK1xuICBsYWJzKHRpdGxlID0gXFxCMk8gcEggKG1WKSBmcm9tIDIwMTEtMjAyM1xcLFxuICAgICAgIHN1YnRpdGxlID0gXFxQb3N0LVFDOiBEYXRhIE91dHNpZGUgMi1TaWdtYSBmcm9tIE1lYW4gaGFzIGJlZW4gUmVtb3ZlZFxcKStcbiAgeGxhYihcXERhdGVcXCkrXG4gIHlsYWIoXFxwSCAobVYpXFwpXG4jIFNhdmUgcGxvdFxuZ2dzYXZlKGZpbGVuYW1lID0gXFxwSG1WUGxvdC1Qb3N0UUMucGRmXFwsIHBsb3QgPSBwSG1WUGxvdF9Qb3N0UUMsIFxuICAgICAgIHBhdGggPSBcXC9Vc2Vycy9ncmFtYmlobGVyL0RvY3VtZW50cy9EYXRhL0dpdEh1Yi9PY2VhbldhdGVyUXVhbGl0eS9GaWd1cmVzL1lTSS1maWd1cmVzL1Bvc3RRQ1Bsb3RzXFwpXG5cbiMgbGluZSBncmFwaCBvZiBzYWxpbml0eSBpbiBwc3VcblNhbGluaXR5UGxvdF9Qb3N0UUMgPC0gZGZRQ1Bpdm90ICU+JVxuICBmaWx0ZXIodmFyaWFibGUgPT0gXFxzYWxpbml0eV9wc3VcXCklPiVcbiAgZ2dwbG90KGFlcyh4ID0gZGF0ZSwgXG4gICAgICAgICAgICAgeSA9IHZhcmlhYmxlX3ZhbHVlKSkgK1xuICBnZW9tX2xpbmUoKSArXG4gIHNjYWxlX3hfZGF0ZShicmVha3MgPSB3YWl2ZXIoKSwgZGF0ZV9icmVha3MgPSBcXDEgeWVhclxcLFxuICAgICAgICAgICAgICAgZGF0ZV9sYWJlbHMgPSBcXCViICVZXFwpICtcbiAgdGhlbWVfYncoKSArIFxuICB0aGVtZShwYW5lbC5ncmlkLm1ham9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuZ3JpZC5taW5vciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmJhY2tncm91bmQgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBheGlzLmxpbmUgPSBlbGVtZW50X2xpbmUoY29sb3VyID0gXFxibGFja1xcKSkrXG4gIHRoZW1lKGF4aXMudGV4dC54ID0gZWxlbWVudF90ZXh0KGFuZ2xlID0gNDUsIGhqdXN0ID0gMSksXG4gICAgICAgIHBsb3QubWFyZ2luID0gbWFyZ2luKDAuMjUsIDAuNDUsIDAuMjUsIDAuMjUsIFxcaW5jaFxcKSkrXG4gIHRoZW1lKHN0cmlwLmJhY2tncm91bmQgPSBlbGVtZW50X3JlY3QoZmlsbCA9IFxcd2hpdGVcXCkpK1xuICBsYWJzKHRpdGxlID0gXFxCMk8gU2FsaW5pdHkgKFBTVSkgZnJvbSAyMDExLTIwMjNcXCxcbiAgICAgICBzdWJ0aXRsZSA9IFxcUG9zdC1RQzogRGF0YSBPdXRzaWRlIDItU2lnbWEgZnJvbSBNZWFuIGhhcyBiZWVuIFJlbW92ZWRcXCkrXG4gIHhsYWIoXFxEYXRlXFwpK1xuICB5bGFiKFxcU2FsaW5pdHkgKFBTVSlcXClcbiMgU2F2ZSBwbG90XG5nZ3NhdmUoZmlsZW5hbWUgPSBcXFNhbGluaXR5UGxvdC1Qb3N0UUMucGRmXFwsIHBsb3QgPSBTYWxpbml0eVBsb3RfUG9zdFFDLCBcbiAgICAgICBwYXRoID0gXFwvVXNlcnMvZ3JhbWJpaGxlci9Eb2N1bWVudHMvRGF0YS9HaXRIdWIvT2NlYW5XYXRlclF1YWxpdHkvRmlndXJlcy9ZU0ktZmlndXJlcy9Qb3N0UUNQbG90c1xcKVxuXG4jIGxpbmUgZ3JhcGggb2YgY29uZHVjdGl2aXR5IGluIHVTL2NtXG5Db25kdWN0aXZpdHlQbG90X1Bvc3RRQyA8LSBkZlFDUGl2b3QgJT4lXG4gIGZpbHRlcih2YXJpYWJsZSA9PSBcXGNvbmR1Y3Rpdml0eV91U2NtXFwpJT4lXG4gIGdncGxvdChhZXMoeCA9IGRhdGUsIFxuICAgICAgICAgICAgIHkgPSB2YXJpYWJsZV92YWx1ZSkpICtcbiAgZ2VvbV9saW5lKCkgK1xuICBzY2FsZV94X2RhdGUoYnJlYWtzID0gd2FpdmVyKCksIGRhdGVfYnJlYWtzID0gXFwxIHllYXJcXCxcbiAgICAgICAgICAgICAgIGRhdGVfbGFiZWxzID0gXFwlYiAlWVxcKSArXG4gIHRoZW1lX2J3KCkgKyBcbiAgdGhlbWUocGFuZWwuZ3JpZC5tYWpvciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmdyaWQubWlub3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5iYWNrZ3JvdW5kID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgYXhpcy5saW5lID0gZWxlbWVudF9saW5lKGNvbG91ciA9IFxcYmxhY2tcXCkpK1xuICB0aGVtZShheGlzLnRleHQueCA9IGVsZW1lbnRfdGV4dChhbmdsZSA9IDQ1LCBoanVzdCA9IDEpLFxuICAgICAgICBwbG90Lm1hcmdpbiA9IG1hcmdpbigwLjI1LCAwLjQ1LCAwLjI1LCAwLjI1LCBcXGluY2hcXCkpK1xuICB0aGVtZShzdHJpcC5iYWNrZ3JvdW5kID0gZWxlbWVudF9yZWN0KGZpbGwgPSBcXHdoaXRlXFwpKStcbiAgbGFicyh0aXRsZSA9IFxcQjJPIENvbmR1Y3Rpdml0eSAowrVTL2NtKSBmcm9tIDIwMTEtMjAyM1xcLFxuICAgICAgIHN1YnRpdGxlID0gXFxQb3N0LVFDOiBEYXRhIE91dHNpZGUgMi1TaWdtYSBmcm9tIE1lYW4gaGFzIGJlZW4gUmVtb3ZlZFxcKStcbiAgeGxhYihcXERhdGVcXCkrXG4gIHlsYWIoXFxDb25kdWN0aXZpdHkgKMK1Uy9jbSlcXClcbiMgU2F2ZSBwbG90XG5nZ3NhdmUoZmlsZW5hbWUgPSBcXENvbmR1Y3Rpdml0eVBsb3QtUG9zdFFDLnBkZlxcLCBwbG90ID0gQ29uZHVjdGl2aXR5UGxvdF9Qb3N0UUMsIFxuICAgICAgIHBhdGggPSBcXC9Vc2Vycy9ncmFtYmlobGVyL0RvY3VtZW50cy9EYXRhL0dpdEh1Yi9PY2VhbldhdGVyUXVhbGl0eS9GaWd1cmVzL1lTSS1maWd1cmVzL1Bvc3RRQ1Bsb3RzXFwpXG5cbiMgbGluZSBncmFwaCBvZiBubGYgY29uZHVjdGl2aXR5IGluIHVTL2NtXG5OTEZDb25kdWN0aXZpdHlQbG90X1Bvc3RRQyA8LSBkZlFDUGl2b3QgJT4lXG4gIGZpbHRlcih2YXJpYWJsZSA9PSBcXG5sZl9jb25kdWN0aXZpdHlfdVNjbVxcKSAlPiVcbiAgZ2dwbG90KGFlcyh4ID0gZGF0ZSwgXG4gICAgICAgICAgICAgeSA9IHZhcmlhYmxlX3ZhbHVlKSkgK1xuICBnZW9tX2xpbmUoKSArXG4gIHNjYWxlX3hfZGF0ZShicmVha3MgPSB3YWl2ZXIoKSwgZGF0ZV9icmVha3MgPSBcXDEgeWVhclxcLFxuICAgICAgICAgICAgICAgZGF0ZV9sYWJlbHMgPSBcXCViICVZXFwpICtcbiAgdGhlbWVfYncoKSArIFxuICB0aGVtZShwYW5lbC5ncmlkLm1ham9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuZ3JpZC5taW5vciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmJhY2tncm91bmQgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBheGlzLmxpbmUgPSBlbGVtZW50X2xpbmUoY29sb3VyID0gXFxibGFja1xcKSkrXG4gIHRoZW1lKGF4aXMudGV4dC54ID0gZWxlbWVudF90ZXh0KGFuZ2xlID0gNDUsIGhqdXN0ID0gMSksXG4gICAgICAgIHBsb3QubWFyZ2luID0gbWFyZ2luKDAuMjUsIDAuNDUsIDAuMjUsIDAuMjUsIFxcaW5jaFxcKSkrXG4gIHRoZW1lKHN0cmlwLmJhY2tncm91bmQgPSBlbGVtZW50X3JlY3QoZmlsbCA9IFxcd2hpdGVcXCkpK1xuICBsYWJzKHRpdGxlID0gXFxCMk8gTkxGIENvbmR1Y3Rpdml0eSAowrVTL2NtKSBmcm9tIDIwMTEtMjAyM1xcLFxuICAgICAgIHN1YnRpdGxlID0gXFxQb3N0LVFDOiBEYXRhIE91dHNpZGUgMi1TaWdtYSBmcm9tIE1lYW4gaGFzIGJlZW4gUmVtb3ZlZFxcKStcbiAgeGxhYihcXERhdGVcXCkrXG4gIHlsYWIoXFxOTEYgQ29uZHVjdGl2aXR5ICjCtVMvY20pXFwpXG4jIFNhdmUgcGxvdFxuZ2dzYXZlKGZpbGVuYW1lID0gXFxOTEZDb25kdWN0aXZpdHlQbG90LVBvc3RRQy5wZGZcXCwgcGxvdCA9IE5MRkNvbmR1Y3Rpdml0eVBsb3RfUG9zdFFDLCBcbiAgICAgICBwYXRoID0gXFwvVXNlcnMvZ3JhbWJpaGxlci9Eb2N1bWVudHMvRGF0YS9HaXRIdWIvT2NlYW5XYXRlclF1YWxpdHkvRmlndXJlcy9ZU0ktZmlndXJlcy9Qb3N0UUNQbG90c1xcKVxuXG4jIGxpbmUgZ3JhcGggb2Ygc3BlY2lmaWMgY29uZHVjdGl2aXR5IGluIHVTL2NtXG5TcENvbmR1Y3Rpdml0eVBsb3RfUG9zdFFDIDwtIGRmUUNQaXZvdCAlPiVcbiAgZmlsdGVyKHZhcmlhYmxlID09IFxcc3BfY29uZHVjdGl2aXR5X3VTY21cXCkgJT4lXG4gIGdncGxvdChhZXMoeCA9IGRhdGUsIFxuICAgICAgICAgICAgIHkgPSB2YXJpYWJsZV92YWx1ZSkpICtcbiAgZ2VvbV9saW5lKCkgK1xuICBzY2FsZV94X2RhdGUoYnJlYWtzID0gd2FpdmVyKCksIGRhdGVfYnJlYWtzID0gXFwxIHllYXJcXCxcbiAgICAgICAgICAgICAgIGRhdGVfbGFiZWxzID0gXFwlYiAlWVxcKSArXG4gIHRoZW1lX2J3KCkgKyBcbiAgdGhlbWUocGFuZWwuZ3JpZC5tYWpvciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmdyaWQubWlub3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5iYWNrZ3JvdW5kID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgYXhpcy5saW5lID0gZWxlbWVudF9saW5lKGNvbG91ciA9IFxcYmxhY2tcXCkpK1xuICB0aGVtZShheGlzLnRleHQueCA9IGVsZW1lbnRfdGV4dChhbmdsZSA9IDQ1LCBoanVzdCA9IDEpLFxuICAgICAgICBwbG90Lm1hcmdpbiA9IG1hcmdpbigwLjI1LCAwLjQ1LCAwLjI1LCAwLjI1LCBcXGluY2hcXCkpK1xuICB0aGVtZShzdHJpcC5iYWNrZ3JvdW5kID0gZWxlbWVudF9yZWN0KGZpbGwgPSBcXHdoaXRlXFwpKStcbiAgbGFicyh0aXRsZSA9IFxcQjJPIFNwZWNpZmljIENvbmR1Y3Rpdml0eSAowrVTL2NtKSBmcm9tIDIwMTEtMjAyM1xcLFxuICAgICAgIHN1YnRpdGxlID0gXFxQb3N0LVFDOiBEYXRhIE91dHNpZGUgMi1TaWdtYSBmcm9tIE1lYW4gaGFzIGJlZW4gUmVtb3ZlZFxcKStcbiAgeGxhYihcXERhdGVcXCkrXG4gIHlsYWIoXFxTcGVjaWZpYyBDb25kdWN0aXZpdHkgKMK1Uy9jbSlcXClcbiMgU2F2ZSBwbG90XG5nZ3NhdmUoZmlsZW5hbWUgPSBcXFNwQ29uZHVjdGl2aXR5UGxvdC1Qb3N0UUMucGRmXFwsIHBsb3QgPSBTcENvbmR1Y3Rpdml0eVBsb3RfUG9zdFFDLFxuICAgICAgIHBhdGggPSBcXC9Vc2Vycy9ncmFtYmlobGVyL0RvY3VtZW50cy9EYXRhL0dpdEh1Yi9PY2VhbldhdGVyUXVhbGl0eS9GaWd1cmVzL1lTSS1maWd1cmVzL1Bvc3RRQ1Bsb3RzXFwpXG5cbiMgbGluZSBncmFwaCBvZiBETyBpbiBtZy9MXG5ET21nTFBsb3RfUG9zdFFDIDwtIGRmUUNQaXZvdCAlPiVcbiAgZmlsdGVyKHZhcmlhYmxlID09IFxcZG9fbWdMXFwpICU+JVxuICBnZ3Bsb3QoYWVzKHggPSBkYXRlLCBcbiAgICAgICAgICAgICB5ID0gdmFyaWFibGVfdmFsdWUpKSArXG4gIGdlb21fbGluZSgpICtcbiAgc2NhbGVfeF9kYXRlKGJyZWFrcyA9IHdhaXZlcigpLCBkYXRlX2JyZWFrcyA9IFxcMSB5ZWFyXFwsXG4gICAgICAgICAgICAgICBkYXRlX2xhYmVscyA9IFxcJWIgJVlcXCkgK1xuICB0aGVtZV9idygpICsgXG4gIHRoZW1lKHBhbmVsLmdyaWQubWFqb3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5ncmlkLm1pbm9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuYmFja2dyb3VuZCA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIGF4aXMubGluZSA9IGVsZW1lbnRfbGluZShjb2xvdXIgPSBcXGJsYWNrXFwpKStcbiAgdGhlbWUoYXhpcy50ZXh0LnggPSBlbGVtZW50X3RleHQoYW5nbGUgPSA0NSwgaGp1c3QgPSAxKSxcbiAgICAgICAgcGxvdC5tYXJnaW4gPSBtYXJnaW4oMC4yNSwgMC40NSwgMC4yNSwgMC4yNSwgXFxpbmNoXFwpKStcbiAgdGhlbWUoc3RyaXAuYmFja2dyb3VuZCA9IGVsZW1lbnRfcmVjdChmaWxsID0gXFx3aGl0ZVxcKSkrXG4gIGxhYnModGl0bGUgPSBcXEIyTyBEaXNzb2x2ZWQgT3h5Z2VuIChtZy9MKSBmcm9tIDIwMTEtMjAyM1xcLFxuICAgICAgIHN1YnRpdGxlID0gXFxQb3N0LVFDOiBEYXRhIE91dHNpZGUgMi1TaWdtYSBmcm9tIE1lYW4gaGFzIGJlZW4gUmVtb3ZlZFxcKStcbiAgeGxhYihcXERhdGVcXCkrXG4gIHlsYWIoXFxEaXNzb2x2ZWQgT3h5Z2VuIChtZy9MKVxcKVxuIyBTYXZlIHBsb3Rcbmdnc2F2ZShmaWxlbmFtZSA9IFxcRE9tZ0xQbG90LVBvc3RRQy5wZGZcXCwgcGxvdCA9IERPbWdMUGxvdF9Qb3N0UUMsIFxuICAgICAgIHBhdGggPSBcXC9Vc2Vycy9ncmFtYmlobGVyL0RvY3VtZW50cy9EYXRhL0dpdEh1Yi9PY2VhbldhdGVyUXVhbGl0eS9GaWd1cmVzL1lTSS1maWd1cmVzL1Bvc3RRQ1Bsb3RzXFwpXG5cbiMgbGluZSBncmFwaCBvZiBETyBpbiBwZXJjZW50IHNhdHVyYXRlZFxuRE9QZXJjZW50U2F0dXJhdGVkUGxvdF9Qb3N0UUMgPC0gZGZRQ1Bpdm90ICU+JVxuICBmaWx0ZXIodmFyaWFibGUgPT0gXFxkb19zYXR1cmF0ZWRfcGVyY2VudFxcKSAlPiVcbiAgZ2dwbG90KGFlcyh4ID0gZGF0ZSwgXG4gICAgICAgICAgICAgeSA9IHZhcmlhYmxlX3ZhbHVlKSkgK1xuICBnZW9tX2xpbmUoKSArXG4gIHNjYWxlX3hfZGF0ZShicmVha3MgPSB3YWl2ZXIoKSwgZGF0ZV9icmVha3MgPSBcXDEgeWVhclxcLFxuICAgICAgICAgICAgICAgZGF0ZV9sYWJlbHMgPSBcXCViICVZXFwpICtcbiAgdGhlbWVfYncoKSArIFxuICB0aGVtZShwYW5lbC5ncmlkLm1ham9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuZ3JpZC5taW5vciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmJhY2tncm91bmQgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBheGlzLmxpbmUgPSBlbGVtZW50X2xpbmUoY29sb3VyID0gXFxibGFja1xcKSkrXG4gIHRoZW1lKGF4aXMudGV4dC54ID0gZWxlbWVudF90ZXh0KGFuZ2xlID0gNDUsIGhqdXN0ID0gMSksXG4gICAgICAgIHBsb3QubWFyZ2luID0gbWFyZ2luKDAuMjUsIDAuNDUsIDAuMjUsIDAuMjUsIFxcaW5jaFxcKSkrXG4gIHRoZW1lKHN0cmlwLmJhY2tncm91bmQgPSBlbGVtZW50X3JlY3QoZmlsbCA9IFxcd2hpdGVcXCkpK1xuICBsYWJzKHRpdGxlID0gXFxCMk8gU2F0dXJhdGVkIERpc3NvbHZlZCBPeHlnZW4gKCUpIGZyb20gMjAxMS0yMDIzXFwsXG4gICAgICAgc3VidGl0bGUgPSBcXFBvc3QtUUM6IERhdGEgT3V0c2lkZSAyLVNpZ21hIGZyb20gTWVhbiBoYXMgYmVlbiBSZW1vdmVkXFwpK1xuICB4bGFiKFxcRGF0ZVxcKStcbiAgeWxhYihcXFNhdHVyYXRlZCBEaXNzb2x2ZWQgT3h5Z2VuICglKVxcKVxuIyBTYXZlIHBsb3Rcbmdnc2F2ZShmaWxlbmFtZSA9IFxcRE9QZXJjZW50U2F0dXJhdGVkUGxvdC1Qb3N0UUMucGRmXFwsIHBsb3QgPSBET1BlcmNlbnRTYXR1cmF0ZWRQbG90X1Bvc3RRQywgXG4gICAgICAgcGF0aCA9IFxcL1VzZXJzL2dyYW1iaWhsZXIvRG9jdW1lbnRzL0RhdGEvR2l0SHViL09jZWFuV2F0ZXJRdWFsaXR5L0ZpZ3VyZXMvWVNJLWZpZ3VyZXMvUG9zdFFDUGxvdHNcXClcblxuIyBsaW5lIGdyYXBoIG9mIERPIGluIHBlcmNlbnQgbG9jYWxcbkRPUGVyY2VudExvY2FsUGxvdF9Qb3N0UUMgPC0gZGZRQ1Bpdm90ICU+JVxuICBmaWx0ZXIodmFyaWFibGUgPT0gXFxkb19sb2NhbF9wZXJjZW50XFwpICU+JVxuICBnZ3Bsb3QoYWVzKHggPSBkYXRlLCBcbiAgICAgICAgICAgICB5ID0gdmFyaWFibGVfdmFsdWUpKSArXG4gIGdlb21fbGluZSgpICtcbiAgc2NhbGVfeF9kYXRlKGJyZWFrcyA9IHdhaXZlcigpLCBkYXRlX2JyZWFrcyA9IFxcMSB5ZWFyXFwsXG4gICAgICAgICAgICAgICBkYXRlX2xhYmVscyA9IFxcJWIgJVlcXCkgK1xuICB0aGVtZV9idygpICsgXG4gIHRoZW1lKHBhbmVsLmdyaWQubWFqb3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5ncmlkLm1pbm9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuYmFja2dyb3VuZCA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIGF4aXMubGluZSA9IGVsZW1lbnRfbGluZShjb2xvdXIgPSBcXGJsYWNrXFwpKStcbiAgdGhlbWUoYXhpcy50ZXh0LnggPSBlbGVtZW50X3RleHQoYW5nbGUgPSA0NSwgaGp1c3QgPSAxKSxcbiAgICAgICAgcGxvdC5tYXJnaW4gPSBtYXJnaW4oMC4yNSwgMC40NSwgMC4yNSwgMC4yNSwgXFxpbmNoXFwpKStcbiAgdGhlbWUoc3RyaXAuYmFja2dyb3VuZCA9IGVsZW1lbnRfcmVjdChmaWxsID0gXFx3aGl0ZVxcKSkrXG4gIGxhYnModGl0bGUgPSBcXEIyTyBMb2NhbCBEaXNzb2x2ZWQgT3h5Z2VuICglKSBmcm9tIDIwMTEtMjAyM1xcLFxuICAgICAgIHN1YnRpdGxlID0gXFxQb3N0LVFDOiBEYXRhIE91dHNpZGUgMi1TaWdtYSBmcm9tIE1lYW4gaGFzIGJlZW4gUmVtb3ZlZFxcKStcbiAgeGxhYihcXERhdGVcXCkrXG4gIHlsYWIoXFxMb2NhbCBEaXNzb2x2ZWQgT3h5Z2VuICglKVxcKVxuIyBTYXZlIHBsb3Rcbmdnc2F2ZShmaWxlbmFtZSA9IFxcRE9QZXJjZW50TG9jYWxQbG90LVBvc3RRQy5wZGZcXCwgcGxvdCA9IERPUGVyY2VudExvY2FsUGxvdF9Qb3N0UUMsXG4gICAgICAgcGF0aCA9IFxcL1VzZXJzL2dyYW1iaWhsZXIvRG9jdW1lbnRzL0RhdGEvR2l0SHViL09jZWFuV2F0ZXJRdWFsaXR5L0ZpZ3VyZXMvWVNJLWZpZ3VyZXMvUG9zdFFDUGxvdHNcXClcblxuIyBsaW5lIGdyYXBoIG9mIE9SUCBpbiBtVlxuT1JQUGxvdF9Qb3N0UUMgPC0gZGZRQ1Bpdm90ICU+JVxuICBmaWx0ZXIodmFyaWFibGUgPT0gXFxvcnBfbVZcXCkgJT4lXG4gIGdncGxvdChhZXMoeCA9IGRhdGUsIFxuICAgICAgICAgICAgIHkgPSB2YXJpYWJsZV92YWx1ZSkpICtcbiAgZ2VvbV9saW5lKCkgK1xuICBzY2FsZV94X2RhdGUoYnJlYWtzID0gd2FpdmVyKCksIGRhdGVfYnJlYWtzID0gXFwxIHllYXJcXCxcbiAgICAgICAgICAgICAgIGRhdGVfbGFiZWxzID0gXFwlYiAlWVxcKSArXG4gIHRoZW1lX2J3KCkgKyBcbiAgdGhlbWUocGFuZWwuZ3JpZC5tYWpvciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmdyaWQubWlub3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5iYWNrZ3JvdW5kID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgYXhpcy5saW5lID0gZWxlbWVudF9saW5lKGNvbG91ciA9IFxcYmxhY2tcXCkpK1xuICB0aGVtZShheGlzLnRleHQueCA9IGVsZW1lbnRfdGV4dChhbmdsZSA9IDQ1LCBoanVzdCA9IDEpLFxuICAgICAgICBwbG90Lm1hcmdpbiA9IG1hcmdpbigwLjI1LCAwLjQ1LCAwLjI1LCAwLjI1LCBcXGluY2hcXCkpK1xuICB0aGVtZShzdHJpcC5iYWNrZ3JvdW5kID0gZWxlbWVudF9yZWN0KGZpbGwgPSBcXHdoaXRlXFwpKStcbiAgbGFicyh0aXRsZSA9IFxcQjJPIE9SUCAobVYpIGZyb20gMjAxMS0yMDIzXFwsXG4gICAgICAgc3VidGl0bGUgPSBcXFBvc3QtUUM6IERhdGEgT3V0c2lkZSAyLVNpZ21hIGZyb20gTWVhbiBoYXMgYmVlbiBSZW1vdmVkXFwpK1xuICB4bGFiKFxcRGF0ZVxcKStcbiAgeWxhYihcXE9SUCAobVYpXFwpXG4jIFNhdmUgcGxvdFxuZ2dzYXZlKGZpbGVuYW1lID0gXFxPUlBQbG90LVBvc3RRQy5wZGZcXCwgcGxvdCA9IE9SUFBsb3RfUG9zdFFDLCBcbiAgICAgICBwYXRoID0gXFwvVXNlcnMvZ3JhbWJpaGxlci9Eb2N1bWVudHMvRGF0YS9HaXRIdWIvT2NlYW5XYXRlclF1YWxpdHkvRmlndXJlcy9ZU0ktZmlndXJlcy9Qb3N0UUNQbG90c1xcKVxuXG4jIGxpbmUgZ3JhcGggb2YgY2hsb3JvcGh5bGwgaW4gUkZVXG5DaGxvcm9waHlsbFJGVVBsb3RfUG9zdFFDIDwtIGRmUUNQaXZvdCAlPiVcbiAgZmlsdGVyKHZhcmlhYmxlID09IFxcY2hsb3JvcGh5bGxfcmZ1XFwpICU+JVxuICBnZ3Bsb3QoYWVzKHggPSBkYXRlLCBcbiAgICAgICAgICAgICB5ID0gdmFyaWFibGVfdmFsdWUpKSArXG4gIGdlb21fbGluZSgpICtcbiAgc2NhbGVfeF9kYXRlKGJyZWFrcyA9IHdhaXZlcigpLCBkYXRlX2JyZWFrcyA9IFxcMSB5ZWFyXFwsXG4gICAgICAgICAgICAgICBkYXRlX2xhYmVscyA9IFxcJWIgJVlcXCkgK1xuICB0aGVtZV9idygpICsgXG4gIHRoZW1lKHBhbmVsLmdyaWQubWFqb3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5ncmlkLm1pbm9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuYmFja2dyb3VuZCA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIGF4aXMubGluZSA9IGVsZW1lbnRfbGluZShjb2xvdXIgPSBcXGJsYWNrXFwpKStcbiAgdGhlbWUoYXhpcy50ZXh0LnggPSBlbGVtZW50X3RleHQoYW5nbGUgPSA0NSwgaGp1c3QgPSAxKSxcbiAgICAgICAgcGxvdC5tYXJnaW4gPSBtYXJnaW4oMC4yNSwgMC40NSwgMC4yNSwgMC4yNSwgXFxpbmNoXFwpKStcbiAgdGhlbWUoc3RyaXAuYmFja2dyb3VuZCA9IGVsZW1lbnRfcmVjdChmaWxsID0gXFx3aGl0ZVxcKSkrXG4gIGxhYnModGl0bGUgPSBcXEIyTyBDaGxvcm9waHlsbCAoUkZVKSBmcm9tIDIwMTEtMjAyM1xcLFxuICAgICAgIHN1YnRpdGxlID0gXFxQb3N0LVFDOiBEYXRhIE91dHNpZGUgMi1TaWdtYSBmcm9tIE1lYW4gaGFzIGJlZW4gUmVtb3ZlZFxcKStcbiAgeGxhYihcXERhdGVcXCkrXG4gIHlsYWIoXFxDaGxvcm9waHlsbCAoUkZVKVxcKVxuIyBTYXZlIHBsb3Rcbmdnc2F2ZShmaWxlbmFtZSA9IFxcQ2hsb3JvcGh5bGxSRlVQbG90LVBvc3RRQy5wZGZcXCwgcGxvdCA9IENobG9yb3BoeWxsUkZVUGxvdF9Qb3N0UUMsXG4gICAgICAgcGF0aCA9IFxcL1VzZXJzL2dyYW1iaWhsZXIvRG9jdW1lbnRzL0RhdGEvR2l0SHViL09jZWFuV2F0ZXJRdWFsaXR5L0ZpZ3VyZXMvWVNJLWZpZ3VyZXMvUG9zdFFDUGxvdHNcXClcblxuIyBsaW5lIGdyYXBoIG9mIGNobG9yb3BoeWxsIGluIHVnL0xcbkNobG9yb3BoeWxsdWdMUGxvdF9Qb3N0UUMgPC0gZGZRQ1Bpdm90ICU+JVxuICBmaWx0ZXIodmFyaWFibGUgPT0gXFxjaGxvcm9waHlsbF91Z0xcXCkgJT4lXG4gIGdncGxvdChhZXMoeCA9IGRhdGUsIFxuICAgICAgICAgICAgIHkgPSB2YXJpYWJsZV92YWx1ZSkpICtcbiAgZ2VvbV9saW5lKCkgK1xuICBzY2FsZV94X2RhdGUoYnJlYWtzID0gd2FpdmVyKCksIGRhdGVfYnJlYWtzID0gXFwxIHllYXJcXCxcbiAgICAgICAgICAgICAgIGRhdGVfbGFiZWxzID0gXFwlYiAlWVxcKSArXG4gIHRoZW1lX2J3KCkgKyBcbiAgdGhlbWUocGFuZWwuZ3JpZC5tYWpvciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmdyaWQubWlub3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5iYWNrZ3JvdW5kID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgYXhpcy5saW5lID0gZWxlbWVudF9saW5lKGNvbG91ciA9IFxcYmxhY2tcXCkpK1xuICB0aGVtZShheGlzLnRleHQueCA9IGVsZW1lbnRfdGV4dChhbmdsZSA9IDQ1LCBoanVzdCA9IDEpLFxuICAgICAgICBwbG90Lm1hcmdpbiA9IG1hcmdpbigwLjI1LCAwLjQ1LCAwLjI1LCAwLjI1LCBcXGluY2hcXCkpK1xuICB0aGVtZShzdHJpcC5iYWNrZ3JvdW5kID0gZWxlbWVudF9yZWN0KGZpbGwgPSBcXHdoaXRlXFwpKStcbiAgbGFicyh0aXRsZSA9IFxcQjJPIENobG9yb3BoeWxsICjCtWcvTCkgZnJvbSAyMDExLTIwMjNcXCxcbiAgICAgICBzdWJ0aXRsZSA9IFxcUG9zdC1RQzogRGF0YSBPdXRzaWRlIDItU2lnbWEgZnJvbSBNZWFuIGhhcyBiZWVuIFJlbW92ZWRcXCkrXG4gIHhsYWIoXFxEYXRlXFwpK1xuICB5bGFiKFxcQ2hsb3JvcGh5bGwgKMK1Zy9MKVxcKVxuIyBTYXZlIHBsb3Rcbmdnc2F2ZShmaWxlbmFtZSA9IFxcQ2hsb3JvcGh5bGx1Z0xQbG90LVBvc3RRQy5wZGZcXCwgcGxvdCA9IENobG9yb3BoeWxsdWdMUGxvdF9Qb3N0UUMsXG4gICAgICAgcGF0aCA9IFxcL1VzZXJzL2dyYW1iaWhsZXIvRG9jdW1lbnRzL0RhdGEvR2l0SHViL09jZWFuV2F0ZXJRdWFsaXR5L0ZpZ3VyZXMvWVNJLWZpZ3VyZXMvUG9zdFFDUGxvdHNcXClcblxuIyBsaW5lIGdyYXBoIG9mIHRvdGFsIGFsZ2FlIGluIGNlbGxzL0xcblRvdGFsQWxnYWVQbG90X1Bvc3RRQyA8LSBkZlFDUGl2b3QgJT4lXG4gIGZpbHRlcih2YXJpYWJsZSA9PSBcXHRvdGFsX2FsZ2FlX2NlbGxzTFxcKSAlPiVcbiAgZ2dwbG90KGFlcyh4ID0gZGF0ZSwgXG4gICAgICAgICAgICAgeSA9IHZhcmlhYmxlX3ZhbHVlKSkgK1xuICBnZW9tX2xpbmUoKSArXG4gIHNjYWxlX3hfZGF0ZShicmVha3MgPSB3YWl2ZXIoKSwgZGF0ZV9icmVha3MgPSBcXDEgeWVhclxcLFxuICAgICAgICAgICAgICAgZGF0ZV9sYWJlbHMgPSBcXCViICVZXFwpICtcbiAgdGhlbWVfYncoKSArIFxuICB0aGVtZShwYW5lbC5ncmlkLm1ham9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuZ3JpZC5taW5vciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmJhY2tncm91bmQgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBheGlzLmxpbmUgPSBlbGVtZW50X2xpbmUoY29sb3VyID0gXFxibGFja1xcKSkrXG4gIHRoZW1lKGF4aXMudGV4dC54ID0gZWxlbWVudF90ZXh0KGFuZ2xlID0gNDUsIGhqdXN0ID0gMSksXG4gICAgICAgIHBsb3QubWFyZ2luID0gbWFyZ2luKDAuMjUsIDAuNDUsIDAuMjUsIDAuMjUsIFxcaW5jaFxcKSkrXG4gIHRoZW1lKHN0cmlwLmJhY2tncm91bmQgPSBlbGVtZW50X3JlY3QoZmlsbCA9IFxcd2hpdGVcXCkpK1xuICBsYWJzKHRpdGxlID0gXFxCMk8gVG90YWwgQWxnYWUgKGNlbGxzL0wpIGZyb20gMjAxMS0yMDIzXFwsXG4gICAgICAgc3VidGl0bGUgPSBcXFBvc3QtUUM6IERhdGEgT3V0c2lkZSAyLVNpZ21hIGZyb20gTWVhbiBoYXMgYmVlbiBSZW1vdmVkXFwpK1xuICB4bGFiKFxcRGF0ZVxcKStcbiAgeWxhYihcXFRvdGFsIEFsZ2FlIChjZWxscy9MKVxcKVxuIyBTYXZlIHBsb3Rcbmdnc2F2ZShmaWxlbmFtZSA9IFxcVG90YWxBbGdhZVBsb3QtUG9zdFFDLnBkZlxcLCBwbG90ID0gVG90YWxBbGdhZVBsb3RfUG9zdFFDLCBcbiAgICAgICBwYXRoID0gXFwvVXNlcnMvZ3JhbWJpaGxlci9Eb2N1bWVudHMvRGF0YS9HaXRIdWIvT2NlYW5XYXRlclF1YWxpdHkvRmlndXJlcy9ZU0ktZmlndXJlcy9Qb3N0UUNQbG90c1xcKVxuXG4jIGxpbmUgZ3JhcGggb2YgdG90YWwgZGlzc29sdmVkIHNvbGlkcyBpbiBtZy9MXG5Ub3RhbERpc3NvbHZlZFNvbGlkc1Bsb3RfUG9zdFFDIDwtIGRmUUNQaXZvdCAlPiVcbiAgZmlsdGVyKHZhcmlhYmxlID09IFxcdG90YWxfZGlzc29sdmVkX3NvbGlkc19tZ0xcXCkgJT4lXG4gIGdncGxvdChhZXMoeCA9IGRhdGUsIFxuICAgICAgICAgICAgIHkgPSB2YXJpYWJsZV92YWx1ZSkpICtcbiAgZ2VvbV9saW5lKCkgK1xuICBzY2FsZV94X2RhdGUoYnJlYWtzID0gd2FpdmVyKCksIGRhdGVfYnJlYWtzID0gXFwxIHllYXJcXCxcbiAgICAgICAgICAgICAgIGRhdGVfbGFiZWxzID0gXFwlYiAlWVxcKSArXG4gIHRoZW1lX2J3KCkgKyBcbiAgdGhlbWUocGFuZWwuZ3JpZC5tYWpvciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmdyaWQubWlub3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5iYWNrZ3JvdW5kID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgYXhpcy5saW5lID0gZWxlbWVudF9saW5lKGNvbG91ciA9IFxcYmxhY2tcXCkpK1xuICB0aGVtZShheGlzLnRleHQueCA9IGVsZW1lbnRfdGV4dChhbmdsZSA9IDQ1LCBoanVzdCA9IDEpLFxuICAgICAgICBwbG90Lm1hcmdpbiA9IG1hcmdpbigwLjI1LCAwLjQ1LCAwLjI1LCAwLjI1LCBcXGluY2hcXCkpK1xuICB0aGVtZShzdHJpcC5iYWNrZ3JvdW5kID0gZWxlbWVudF9yZWN0KGZpbGwgPSBcXHdoaXRlXFwpKStcbiAgbGFicyh0aXRsZSA9IFxcQjJPIFRvdGFsIERpc3NvbHZlZCBTb2xpZHMgKG1nL0wpIGZyb20gMjAxMS0yMDIzXFwsXG4gICAgICAgc3VidGl0bGUgPSBcXFBvc3QtUUM6IERhdGEgT3V0c2lkZSAyLVNpZ21hIGZyb20gTWVhbiBoYXMgYmVlbiBSZW1vdmVkXFwpK1xuICB4bGFiKFxcRGF0ZVxcKStcbiAgeWxhYihcXFRvdGFsIERpc3NvbHZlZCBTb2xpZHMgKG1nL0wpXFwpXG4jIFNhdmUgcGxvdFxuZ2dzYXZlKGZpbGVuYW1lID0gXFxUb3RhbERpc3NvbHZlZFNvbGlkc1Bsb3QtUG9zdFFDLnBkZlxcLCBwbG90ID0gVG90YWxEaXNzb2x2ZWRTb2xpZHNQbG90X1Bvc3RRQywgXG4gICAgICAgcGF0aCA9IFxcL1VzZXJzL2dyYW1iaWhsZXIvRG9jdW1lbnRzL0RhdGEvR2l0SHViL09jZWFuV2F0ZXJRdWFsaXR5L0ZpZ3VyZXMvWVNJLWZpZ3VyZXMvUG9zdFFDUGxvdHNcXClcbiAgXG5gYGBcbmBgYCJ9 -->

```r
```r
# line graph of every variable - facet wrapped 
AllVariablePlot_PostQC <- dfQCPivot %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  facet_wrap(~variable, ncol = 3, scales = \free\)+
  scale_x_date(breaks = waiver(), date_breaks = \1 year\,
               date_labels = \%b %Y\) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = \black\))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, \inch\))+
  theme(strip.background = element_rect(fill = \white\))+
  labs(title = \B2O Water Quality by Variable from 2011-2023\,
       subtitle = \Post-QC: Data Outside 2-Sigma from Mean has been Removed\)+
  xlab(\Date\)+
  ylab(\Nutrient Value\)
# Save plot
ggsave(filename = \AllVariablePlot-PostQC.pdf\, plot = AllVariablePlot_PostQC, 
       path = \/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/Figures/YSI-figures/PostQCPlots\, height = 12, width = 10)

# line graph of temperature in fahrenheit
TempFPlot_PostQC <- dfQCPivot %>%
  filter(variable == \temp_f\) %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = \1 year\,
               date_labels = \%b %Y\) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = \black\))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, \inch\))+
  theme(strip.background = element_rect(fill = \white\))+
  labs(title = \B2O Temperature (ºF) from 2011-2023\,
       subtitle = \Post-QC: Data Outside 2-Sigma from Mean has been Removed\)+
  xlab(\Date\)+
  ylab(\Temperature (ºF)\)
# Save plot
ggsave(filename = \TempFPlot-PostQC.pdf\, plot = TempFPlot_PostQC, 
       path = \/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/Figures/YSI-figures/PostQCPlots\)

# line graph of temp in celcius
TempCPlot_PostQC <- dfQCPivot %>%
  filter(variable == \temp_c\)%>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = \1 year\,
               date_labels = \%b %Y\) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = \black\))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, \inch\))+
  theme(strip.background = element_rect(fill = \white\))+
  labs(title = \B2O Temperature (ºC) from 2011-2023\,
       subtitle = \Post-QC: Data Outside 2-Sigma from Mean has been Removed\)+
  xlab(\Date\)+
  ylab(\Temperature (ºC)\)
# Save plot
ggsave(filename = \TempCPlot-PostQC.pdf\, plot = TempCPlot_PostQC, 
       path = \/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/Figures/YSI-figures/PostQCPlots\)

# line graph of pH in pH units
pHPlot_PostQC <- dfQCPivot %>%
  filter(variable == \pH\) %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = \1 year\,
               date_labels = \%b %Y\) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = \black\))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, \inch\))+
  theme(strip.background = element_rect(fill = \white\))+
  labs(title = \B2O pH from 2011-2023\,
       subtitle = \Post-QC: Data Outside 2-Sigma from Mean has been Removed\)+
  xlab(\Date\)+
  ylab(\pH\)
# Save plot
ggsave(filename = \pHPlot-PostQC.pdf\, plot = pHPlot_PostQC, 
       path = \/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/Figures/YSI-figures/PostQCPlots\)

# line graph of pH in mV
pHmVPlot_PostQC <- dfQCPivot %>%
  filter(variable == \pH_mV\) %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = \1 year\,
               date_labels = \%b %Y\) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = \black\))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, \inch\))+
  theme(strip.background = element_rect(fill = \white\))+
  labs(title = \B2O pH (mV) from 2011-2023\,
       subtitle = \Post-QC: Data Outside 2-Sigma from Mean has been Removed\)+
  xlab(\Date\)+
  ylab(\pH (mV)\)
# Save plot
ggsave(filename = \pHmVPlot-PostQC.pdf\, plot = pHmVPlot_PostQC, 
       path = \/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/Figures/YSI-figures/PostQCPlots\)

# line graph of salinity in psu
SalinityPlot_PostQC <- dfQCPivot %>%
  filter(variable == \salinity_psu\)%>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = \1 year\,
               date_labels = \%b %Y\) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = \black\))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, \inch\))+
  theme(strip.background = element_rect(fill = \white\))+
  labs(title = \B2O Salinity (PSU) from 2011-2023\,
       subtitle = \Post-QC: Data Outside 2-Sigma from Mean has been Removed\)+
  xlab(\Date\)+
  ylab(\Salinity (PSU)\)
# Save plot
ggsave(filename = \SalinityPlot-PostQC.pdf\, plot = SalinityPlot_PostQC, 
       path = \/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/Figures/YSI-figures/PostQCPlots\)

# line graph of conductivity in uS/cm
ConductivityPlot_PostQC <- dfQCPivot %>%
  filter(variable == \conductivity_uScm\)%>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = \1 year\,
               date_labels = \%b %Y\) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = \black\))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, \inch\))+
  theme(strip.background = element_rect(fill = \white\))+
  labs(title = \B2O Conductivity (µS/cm) from 2011-2023\,
       subtitle = \Post-QC: Data Outside 2-Sigma from Mean has been Removed\)+
  xlab(\Date\)+
  ylab(\Conductivity (µS/cm)\)
# Save plot
ggsave(filename = \ConductivityPlot-PostQC.pdf\, plot = ConductivityPlot_PostQC, 
       path = \/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/Figures/YSI-figures/PostQCPlots\)

# line graph of nlf conductivity in uS/cm
NLFConductivityPlot_PostQC <- dfQCPivot %>%
  filter(variable == \nlf_conductivity_uScm\) %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = \1 year\,
               date_labels = \%b %Y\) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = \black\))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, \inch\))+
  theme(strip.background = element_rect(fill = \white\))+
  labs(title = \B2O NLF Conductivity (µS/cm) from 2011-2023\,
       subtitle = \Post-QC: Data Outside 2-Sigma from Mean has been Removed\)+
  xlab(\Date\)+
  ylab(\NLF Conductivity (µS/cm)\)
# Save plot
ggsave(filename = \NLFConductivityPlot-PostQC.pdf\, plot = NLFConductivityPlot_PostQC, 
       path = \/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/Figures/YSI-figures/PostQCPlots\)

# line graph of specific conductivity in uS/cm
SpConductivityPlot_PostQC <- dfQCPivot %>%
  filter(variable == \sp_conductivity_uScm\) %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = \1 year\,
               date_labels = \%b %Y\) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = \black\))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, \inch\))+
  theme(strip.background = element_rect(fill = \white\))+
  labs(title = \B2O Specific Conductivity (µS/cm) from 2011-2023\,
       subtitle = \Post-QC: Data Outside 2-Sigma from Mean has been Removed\)+
  xlab(\Date\)+
  ylab(\Specific Conductivity (µS/cm)\)
# Save plot
ggsave(filename = \SpConductivityPlot-PostQC.pdf\, plot = SpConductivityPlot_PostQC,
       path = \/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/Figures/YSI-figures/PostQCPlots\)

# line graph of DO in mg/L
DOmgLPlot_PostQC <- dfQCPivot %>%
  filter(variable == \do_mgL\) %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = \1 year\,
               date_labels = \%b %Y\) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = \black\))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, \inch\))+
  theme(strip.background = element_rect(fill = \white\))+
  labs(title = \B2O Dissolved Oxygen (mg/L) from 2011-2023\,
       subtitle = \Post-QC: Data Outside 2-Sigma from Mean has been Removed\)+
  xlab(\Date\)+
  ylab(\Dissolved Oxygen (mg/L)\)
# Save plot
ggsave(filename = \DOmgLPlot-PostQC.pdf\, plot = DOmgLPlot_PostQC, 
       path = \/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/Figures/YSI-figures/PostQCPlots\)

# line graph of DO in percent saturated
DOPercentSaturatedPlot_PostQC <- dfQCPivot %>%
  filter(variable == \do_saturated_percent\) %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = \1 year\,
               date_labels = \%b %Y\) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = \black\))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, \inch\))+
  theme(strip.background = element_rect(fill = \white\))+
  labs(title = \B2O Saturated Dissolved Oxygen (%) from 2011-2023\,
       subtitle = \Post-QC: Data Outside 2-Sigma from Mean has been Removed\)+
  xlab(\Date\)+
  ylab(\Saturated Dissolved Oxygen (%)\)
# Save plot
ggsave(filename = \DOPercentSaturatedPlot-PostQC.pdf\, plot = DOPercentSaturatedPlot_PostQC, 
       path = \/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/Figures/YSI-figures/PostQCPlots\)

# line graph of DO in percent local
DOPercentLocalPlot_PostQC <- dfQCPivot %>%
  filter(variable == \do_local_percent\) %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = \1 year\,
               date_labels = \%b %Y\) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = \black\))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, \inch\))+
  theme(strip.background = element_rect(fill = \white\))+
  labs(title = \B2O Local Dissolved Oxygen (%) from 2011-2023\,
       subtitle = \Post-QC: Data Outside 2-Sigma from Mean has been Removed\)+
  xlab(\Date\)+
  ylab(\Local Dissolved Oxygen (%)\)
# Save plot
ggsave(filename = \DOPercentLocalPlot-PostQC.pdf\, plot = DOPercentLocalPlot_PostQC,
       path = \/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/Figures/YSI-figures/PostQCPlots\)

# line graph of ORP in mV
ORPPlot_PostQC <- dfQCPivot %>%
  filter(variable == \orp_mV\) %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = \1 year\,
               date_labels = \%b %Y\) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = \black\))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, \inch\))+
  theme(strip.background = element_rect(fill = \white\))+
  labs(title = \B2O ORP (mV) from 2011-2023\,
       subtitle = \Post-QC: Data Outside 2-Sigma from Mean has been Removed\)+
  xlab(\Date\)+
  ylab(\ORP (mV)\)
# Save plot
ggsave(filename = \ORPPlot-PostQC.pdf\, plot = ORPPlot_PostQC, 
       path = \/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/Figures/YSI-figures/PostQCPlots\)

# line graph of chlorophyll in RFU
ChlorophyllRFUPlot_PostQC <- dfQCPivot %>%
  filter(variable == \chlorophyll_rfu\) %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = \1 year\,
               date_labels = \%b %Y\) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = \black\))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, \inch\))+
  theme(strip.background = element_rect(fill = \white\))+
  labs(title = \B2O Chlorophyll (RFU) from 2011-2023\,
       subtitle = \Post-QC: Data Outside 2-Sigma from Mean has been Removed\)+
  xlab(\Date\)+
  ylab(\Chlorophyll (RFU)\)
# Save plot
ggsave(filename = \ChlorophyllRFUPlot-PostQC.pdf\, plot = ChlorophyllRFUPlot_PostQC,
       path = \/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/Figures/YSI-figures/PostQCPlots\)

# line graph of chlorophyll in ug/L
ChlorophyllugLPlot_PostQC <- dfQCPivot %>%
  filter(variable == \chlorophyll_ugL\) %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = \1 year\,
               date_labels = \%b %Y\) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = \black\))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, \inch\))+
  theme(strip.background = element_rect(fill = \white\))+
  labs(title = \B2O Chlorophyll (µg/L) from 2011-2023\,
       subtitle = \Post-QC: Data Outside 2-Sigma from Mean has been Removed\)+
  xlab(\Date\)+
  ylab(\Chlorophyll (µg/L)\)
# Save plot
ggsave(filename = \ChlorophyllugLPlot-PostQC.pdf\, plot = ChlorophyllugLPlot_PostQC,
       path = \/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/Figures/YSI-figures/PostQCPlots\)

# line graph of total algae in cells/L
TotalAlgaePlot_PostQC <- dfQCPivot %>%
  filter(variable == \total_algae_cellsL\) %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = \1 year\,
               date_labels = \%b %Y\) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = \black\))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, \inch\))+
  theme(strip.background = element_rect(fill = \white\))+
  labs(title = \B2O Total Algae (cells/L) from 2011-2023\,
       subtitle = \Post-QC: Data Outside 2-Sigma from Mean has been Removed\)+
  xlab(\Date\)+
  ylab(\Total Algae (cells/L)\)
# Save plot
ggsave(filename = \TotalAlgaePlot-PostQC.pdf\, plot = TotalAlgaePlot_PostQC, 
       path = \/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/Figures/YSI-figures/PostQCPlots\)

# line graph of total dissolved solids in mg/L
TotalDissolvedSolidsPlot_PostQC <- dfQCPivot %>%
  filter(variable == \total_dissolved_solids_mgL\) %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = \1 year\,
               date_labels = \%b %Y\) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = \black\))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, \inch\))+
  theme(strip.background = element_rect(fill = \white\))+
  labs(title = \B2O Total Dissolved Solids (mg/L) from 2011-2023\,
       subtitle = \Post-QC: Data Outside 2-Sigma from Mean has been Removed\)+
  xlab(\Date\)+
  ylab(\Total Dissolved Solids (mg/L)\)
# Save plot
ggsave(filename = \TotalDissolvedSolidsPlot-PostQC.pdf\, plot = TotalDissolvedSolidsPlot_PostQC, 
       path = \/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/Figures/YSI-figures/PostQCPlots\)
  
```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


# Preliminary Plotting After Initial Standard Deviation QC

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-plot-begin eyJoZWlnaHQiOjQzMi42MzI5LCJ3aWR0aCI6NzAwLCJzaXplX2JlaGF2aW9yIjowLCJjb25kaXRpb25zIjpbWzEsIldhcm5pbmc6IFx1MDAxYlszODs1OzIzOW1SZW1vdmVkIDY1IHJvd3MgY29udGFpbmluZyBtaXNzaW5nIHZhbHVlcyAoYGdlb21fbGluZSgpYCkuXHUwMDFiWzM5bSJdXX0= -->

<img src="data:image/png;base64,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Dccff3xkgRfO77fbbru8DE/9FAEREIFUCUjgTRW3GhMBERCB1hDAjoHwc6sgAiIgAiLQmYAE3s5MFCMCIiACqRP47LPPDHZl3Hnnnc1PfvIT8+qrr9b0ARujYOe4PfbYw0yYMMEceuih5qWXXrJ57rzzTnPFFVfYMgceeKDduhcJM2fONLjedttt7e5m8+bNq6lTFyIgAiJQFgISeMsy0xqnCIhApgkcfPDB5g9/+IMZN26cgfC7zz771PQXQu6ll15qtt56azNx4kRz++23m6222sp8+eWXBtsq9+rVyyy//PJm1KhRZplllrHpY8eOtSYREJIfeOABg61JJfTWYNWFCIhASQhop7WSTLSGKQIikF0Cs2bNMsOHDzcwSxgyZIjt6GmnnWYOO+ww8/rrr5ull17aan2xiG3w4ME2/cYbbzTbb7+9ga1vjx49rPZ3+vTp5rHHHrPpG220kVlnnXXMlVdeWR044iBQQ5OsIAIiIAJlIrBUmQarsYqACIhAFgnA9ABCK4Vd9BEL0CDwInTv3t1cfvnl1kThoosuMs8++6yZMWOGTfv444/t0f0H8wcIvmuuuaaZMmVKNWnJJZc0Dz/8cPVaJyIgAiJQFgIyaSjLTGucIiACmSXw/vvvW9OEjo6Oah+XWuprfcQnn3xiBeBvfetb1qwBpgtek4dqwcoJ3JPB1GGFFVYw3/jGN6p/22yzjdltt93crDoXAREQgVIQ+PqOWorhapAiIAIikD0CMDWYP3++1eCOGDHCdvC2226rdvTqq682uJ47d67p3bu3jUccAgRbhCWWWMIe8W+11VYzK620kunZs6c58cQTq/G33HKLNY+oRuhEBERABEpCQBrekky0hikCIpBdAiNHjjRDhw41J5xwgvW0AJve8847r9rhNdZYw3zxxRcGm1EgwDvDMcccY8+h/UXo1q2btfedPXu2+fzzz63N77Rp08w111xjy8IEAh4g3n77bZtf/0RABESgTASk4S3TbGusIiACmSSw7LLLmuuuu85MmjTJ9OvXz/YR9ruw7UXYYostzP777289NMCcAYvYTj31VPPjH//YPProo9b2F+YOsNEdOHCgue+++8xxxx1nPTTsvvvuBuYRsBE+4ogjrFszW6n+iYAIiECJCMhLQ4kmW0MVARHIPoG33nrLrLjiigZCsDfAXRk0tDBVCAqwB15llVWqyYsXL7aaYbgtUxABERCBshKQwFvWmde4RUAEREAEREAERKAkBGTDW5KJ1jBFQAREQAREQAREoKwEJPCWdeY1bhEQAREQAREQAREoCQEJvCWZaA1TBERABERABERABMpKQAJvWWde4xYBERABERABERCBkhCQwFuSidYwRUAEREAEREAERKCsBCTwlnXmNW4REAEREAEREAERKAkBCbwlmWgNUwREQAREQAREQATKSkACb1lnXuMWAREQAREQAREQgZIQ+D8UKSAPWuJYigAAAABJRU5ErkJggg==" />

<!-- rnb-plot-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


# Preliminary Plotting of Mean Daily Values After Initial Standard Deviation QC

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBsaW5lIGdyYXBoIG9mIGV2ZXJ5IHZhcmlhYmxlIC0gZmFjZXQgd3JhcHBlZCBcbk1EVkFsbFZhcmlhYmxlUGxvdCA8LSBNZWFuRGFpbHlWYWx1ZUZyYW1lICU+JVxuICBnZ3Bsb3QoYWVzKHggPSBkYXRlLCBcbiAgICAgICAgICAgICB5ID0gbWVhbl9kYWlseV92YWx1ZSkpICtcbiAgZ2VvbV9saW5lKCkgK1xuICBmYWNldF93cmFwKH52YXJpYWJsZSwgbmNvbCA9IDMsIHNjYWxlcyA9IFwiZnJlZVwiKStcbiAgc2NhbGVfeF9kYXRlKGJyZWFrcyA9IHdhaXZlcigpLCBkYXRlX2JyZWFrcyA9IFwiMTIgbW9udGhzXCIsXG4gICAgICAgICAgICAgICBkYXRlX2xhYmVscyA9IFwiJWIgJVlcIikgK1xuICB0aGVtZV9idygpICsgXG4gIHRoZW1lKHBhbmVsLmdyaWQubWFqb3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5ncmlkLm1pbm9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuYmFja2dyb3VuZCA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIGF4aXMubGluZSA9IGVsZW1lbnRfbGluZShjb2xvdXIgPSBcImJsYWNrXCIpKStcbiAgdGhlbWUoYXhpcy50ZXh0LnggPSBlbGVtZW50X3RleHQoYW5nbGUgPSA0NSwgaGp1c3QgPSAxKSxcbiAgICAgICAgcGxvdC5tYXJnaW4gPSBtYXJnaW4oMC4yNSwgMC40NSwgMC4yNSwgMC4yNSwgXCJpbmNoXCIpKStcbiAgdGhlbWUoc3RyaXAuYmFja2dyb3VuZCA9IGVsZW1lbnRfcmVjdChmaWxsID0gXCJ3aGl0ZVwiKSkrXG4gIGxhYnModGl0bGUgPSBcIkIyTyBXYXRlciBRdWFsaXR5IE1lYW4gRGFpbHkgVmFsdWUgYnkgVmFyaWFibGUgZnJvbSAyMDExLTIwMjNcIixcbiAgICAgICBzdWJ0aXRsZSA9IFwiUHJlLVFDOiBBbGwgT3V0bGllcnMgU3RpbGwgUHJlc2VudFwiKStcbiAgeGxhYihcIkRhdGVcIikrXG4gIHlsYWIoXCJOdXRyaWVudCBWYWx1ZVwiKVxuIyBTYXZlIHBsb3Rcbmdnc2F2ZShmaWxlbmFtZSA9IFwiQWxsVmFyaWFibGVQbG90LU1EVi5wZGZcIiwgcGxvdCA9IE1EVkFsbFZhcmlhYmxlUGxvdCxcbiAgICAgICBwYXRoID0gXCIvVXNlcnMvZ3JhbWJpaGxlci9Eb2N1bWVudHMvRGF0YS9HaXRIdWIvT2NlYW5XYXRlclF1YWxpdHkvWVNJRXhvU29uZGUvWVNJLWZpZ3VyZXMvTURWUG9zdFFDUGxvdHNcIiwgaGVpZ2h0ID0gMTIsIHdpZHRoID0gMTApXG5cbiMgbGluZSBncmFwaCBvZiBldmVyeSB2YXJpYWJsZSAtIGZhY2V0IHdyYXBwZWQgXG5NRFZQb3N0UUNBbGxWYXJpYWJsZVBsb3QgPC0gUUNNZWFuRGFpbHlWYWx1ZUZyYW1lICU+JVxuICBnZ3Bsb3QoYWVzKHggPSBkYXRlLCBcbiAgICAgICAgICAgICB5ID0gbWVhbl9kYWlseV92YWx1ZSkpICtcbiAgZ2VvbV9saW5lKCkgK1xuICBmYWNldF93cmFwKH52YXJpYWJsZSwgbmNvbCA9IDMsIHNjYWxlcyA9IFwiZnJlZVwiKStcbiAgc2NhbGVfeF9kYXRlKGJyZWFrcyA9IHdhaXZlcigpLCBkYXRlX2JyZWFrcyA9IFwiMTIgbW9udGhzXCIsXG4gICAgICAgICAgICAgICBkYXRlX2xhYmVscyA9IFwiJWIgJVlcIikgK1xuICB0aGVtZV9idygpICsgXG4gIHRoZW1lKHBhbmVsLmdyaWQubWFqb3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5ncmlkLm1pbm9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuYmFja2dyb3VuZCA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIGF4aXMubGluZSA9IGVsZW1lbnRfbGluZShjb2xvdXIgPSBcImJsYWNrXCIpKStcbiAgdGhlbWUoYXhpcy50ZXh0LnggPSBlbGVtZW50X3RleHQoYW5nbGUgPSA0NSwgaGp1c3QgPSAxKSxcbiAgICAgICAgcGxvdC5tYXJnaW4gPSBtYXJnaW4oMC4yNSwgMC40NSwgMC4yNSwgMC4yNSwgXCJpbmNoXCIpKStcbiAgdGhlbWUoc3RyaXAuYmFja2dyb3VuZCA9IGVsZW1lbnRfcmVjdChmaWxsID0gXCJ3aGl0ZVwiKSkrXG4gIGxhYnModGl0bGUgPSBcIkIyTyBXYXRlciBRdWFsaXR5IE1lYW4gRGFpbHkgVmFsdWUgYnkgVmFyaWFibGUgZnJvbSAyMDExLTIwMjNcIixcbiAgICAgICBzdWJ0aXRsZSA9IFwiUG9zdC1RQzogRGF0YSBPdXRzaWRlIDItU2lnbWEgZnJvbSBNZWFuIGhhcyBiZWVuIFJlbW92ZWRcIikrXG4gIHhsYWIoXCJEYXRlXCIpK1xuICB5bGFiKFwiTnV0cmllbnQgVmFsdWVcIilcbiMgU2F2ZSBwbG90XG5nZ3NhdmUoZmlsZW5hbWUgPSBcIkFsbFZhcmlhYmxlUGxvdC1NRFZQb3N0UUMucGRmXCIsIHBsb3QgPSBNRFZQb3N0UUNBbGxWYXJpYWJsZVBsb3QsXG4gICAgICAgcGF0aCA9IFwiL1VzZXJzL2dyYW1iaWhsZXIvRG9jdW1lbnRzL0RhdGEvR2l0SHViL09jZWFuV2F0ZXJRdWFsaXR5L1lTSUV4b1NvbmRlL1lTSS1maWd1cmVzL01EVlBvc3RRQ1Bsb3RzXCIsIGhlaWdodCA9IDEyLCB3aWR0aCA9IDEwKVxuXG4jIGxpbmUgZ3JhcGggb2YgdGVtcGVyYXR1cmUgaW4gZmFocmVuaGVpdFxuTURWUG9zdFFDVGVtcEZQbG90IDwtIFNETWVhbkRhaWx5VmFsdWVGcmFtZUZ1bGwgJT4lXG4gIGZpbHRlcih2YXJpYWJsZSA9PSBcInRlbXBfZlwiKSAlPiVcbiAgZ2dsaW5lKHggPSBcImRhdGVcIixcbiAgICAgICAgIHkgPSBcIm1lYW5fZGFpbHlfdmFsdWVcIixcbiAgICAgICAgIHBsb3RfdHlwZSA9IFwibFwiLFxuICAgICAgICAgeGxhYiA9IFwiRGF0ZVwiLFxuICAgICAgICAgeWxhYiA9IFwiVGVtcGVyYXR1cmUgKEYpXCIsXG4gICAgICAgICB0aXRsZSA9IFwiUG9zdC1RQyBCMk8gVGVtcGVyYXR1cmUoRikgTWVhbiBEYWlseSBWYWx1ZSBmcm9tIDIwMTEtMjAyM1wiKVxuTURWUG9zdFFDVGVtcEZQbG90XG4jIFNhdmUgcGxvdFxuZ2dzYXZlKGZpbGVuYW1lID0gXCJUZW1wRlBsb3QtTURWUG9zdFFDLnBkZlwiLCBwbG90ID0gTURWUG9zdFFDVGVtcEZQbG90LCBcbiAgICAgICBwYXRoID0gXCIvVXNlcnMvZ3JhbWJpaGxlci9Eb2N1bWVudHMvRGF0YS9HaXRIdWIvT2NlYW5XYXRlclF1YWxpdHkvWVNJRXhvU29uZGUvWVNJLWZpZ3VyZXMvTURWUG9zdFFDUGxvdHNcIilcblxuIyBsaW5lIGdyYXBoIG9mIHRlbXAgaW4gY2VsY2l1c1xuTURWUG9zdFFDVGVtcENQbG90IDwtIFNETWVhbkRhaWx5VmFsdWVGcmFtZUZ1bGwgJT4lXG4gIGZpbHRlcih2YXJpYWJsZSA9PSBcInRlbXBfY1wiKSU+JVxuICBmaWx0ZXIobWVhbl9kYWlseV92YWx1ZSA+IDE5ICYgbWVhbl9kYWlseV92YWx1ZSA8IDI4KSAlPiVcbiAgbmEub21pdCgpICU+JVxuICByZW1vdmVfc2Rfb3V0bGllcihjb2xzID0gXCJtZWFuX2RhaWx5X3ZhbHVlXCIsIFxuICAgICAgICAgICAgICAgICAgICBuX3NpZ21hcyA9IDIpICU+JVxuICBnZ2xpbmUoeCA9IFwiZGF0ZVwiLFxuICAgICAgICAgeSA9IFwibWVhbl9kYWlseV92YWx1ZVwiLFxuICAgICAgICAgcGxvdF90eXBlID0gXCJsXCIsXG4gICAgICAgICB4bGFiID0gXCJEYXRlXCIsXG4gICAgICAgICB5bGFiID0gXCJUZW1wZXJhdHVyZSAoQylcIixcbiAgICAgICAgIHRpdGxlID0gXCJQb3N0LVFDIEIyTyBUZW1wZXJhdHVyZShDKSBNZWFuIERhaWx5IFZhbHVlIGZyb20gMjAxMS0yMDIzXCIpXG5NRFZQb3N0UUNUZW1wQ1Bsb3RcbiMgU2F2ZSBwbG90XG5nZ3NhdmUoZmlsZW5hbWUgPSBcIlRlbXBDUGxvdC1NRFZQb3N0UUMucGRmXCIsIHBsb3QgPSBNRFZQb3N0UUNUZW1wQ1Bsb3QsIFxuICAgICAgIHBhdGggPSBcIi9Vc2Vycy9ncmFtYmlobGVyL0RvY3VtZW50cy9EYXRhL0dpdEh1Yi9PY2VhbldhdGVyUXVhbGl0eS9ZU0lFeG9Tb25kZS9ZU0ktZmlndXJlcy9NRFZQb3N0UUNQbG90c1wiKVxuXG4jIGxpbmUgZ3JhcGggb2YgcEggaW4gcEggdW5pdHNcbk1EVlBvc3RRQ3BIUGxvdCA8LSBTRE1lYW5EYWlseVZhbHVlRnJhbWVGdWxsICU+JVxuICBmaWx0ZXIodmFyaWFibGUgPT0gXCJwSFwiKSAlPiVcbiAgZmlsdGVyKG1lYW5fZGFpbHlfdmFsdWUgPiA3ICYgbWVhbl9kYWlseV92YWx1ZSA8IDEwKSAlPiVcbiAgbmEub21pdCgpICU+JVxuICByZW1vdmVfc2Rfb3V0bGllcihjb2xzID0gXCJtZWFuX2RhaWx5X3ZhbHVlXCIsIFxuICAgICAgICAgICAgICAgICAgICBuX3NpZ21hcyA9IDIpICU+JVxuICBnZ2xpbmUoeCA9IFwiZGF0ZVwiLFxuICAgICAgICAgeSA9IFwibWVhbl9kYWlseV92YWx1ZVwiLFxuICAgICAgICAgcGxvdF90eXBlID0gXCJsXCIsXG4gICAgICAgICB4bGFiID0gXCJEYXRlXCIsXG4gICAgICAgICB5bGFiID0gXCJwSFwiLFxuICAgICAgICAgdGl0bGUgPSBcIlBvc3QtUUMgQjJPIHBIIE1lYW4gRGFpbHkgVmFsdWUgZnJvbSAyMDExLTIwMjNcIilcbk1EVlBvc3RRQ3BIUGxvdFxuIyBTYXZlIHBsb3Rcbmdnc2F2ZShmaWxlbmFtZSA9IFwicEhQbG90LU1EVlBvc3RRQy5wZGZcIiwgcGxvdCA9IE1EVlBvc3RRQ3BIUGxvdCwgXG4gICAgICAgcGF0aCA9IFwiL1VzZXJzL2dyYW1iaWhsZXIvRG9jdW1lbnRzL0RhdGEvR2l0SHViL09jZWFuV2F0ZXJRdWFsaXR5L1lTSUV4b1NvbmRlL1lTSS1maWd1cmVzL01EVlBvc3RRQ1Bsb3RzXCIpXG5cbiMgbGluZSBncmFwaCBvZiBwSCBpbiBtVlxuTURWUG9zdFFDcEhtVlBsb3QgPC0gU0RNZWFuRGFpbHlWYWx1ZUZyYW1lRnVsbCAlPiVcbiAgZmlsdGVyKHZhcmlhYmxlID09IFwicEhfbVZcIikgJT4lXG4gIGdnbGluZSh4ID0gXCJkYXRlXCIsXG4gICAgICAgICB5ID0gXCJtZWFuX2RhaWx5X3ZhbHVlXCIsXG4gICAgICAgICBwbG90X3R5cGUgPSBcImxcIixcbiAgICAgICAgIHhsYWIgPSBcIkRhdGVcIixcbiAgICAgICAgIHlsYWIgPSBcInBIIChtVilcIixcbiAgICAgICAgIHRpdGxlID0gXCJQb3N0LVFDIEIyTyBwSChtVikgTWVhbiBEYWlseSBWYWx1ZSBmcm9tIDIwMTEtMjAyM1wiKVxuTURWUG9zdFFDcEhtVlBsb3RcbiMgU2F2ZSBwbG90XG5nZ3NhdmUoZmlsZW5hbWUgPSBcInBIbVZQbG90LU1EVlBvc3RRQy5wZGZcIiwgcGxvdCA9IE1EVlBvc3RRQ3BIbVZQbG90LCBcbiAgICAgICBwYXRoID0gXCIvVXNlcnMvZ3JhbWJpaGxlci9Eb2N1bWVudHMvRGF0YS9HaXRIdWIvT2NlYW5XYXRlclF1YWxpdHkvWVNJRXhvU29uZGUvWVNJLWZpZ3VyZXMvTURWUG9zdFFDUGxvdHNcIilcblxuIyBsaW5lIGdyYXBoIG9mIHNhbGluaXR5IGluIHBzdVxuTURWUG9zdFFDU2FsaW5pdHlQbG90IDwtIFNETWVhbkRhaWx5VmFsdWVGcmFtZUZ1bGwgJT4lXG4gIGZpbHRlcih2YXJpYWJsZSA9PSBcInNhbGluaXR5X3BzdVwiKSU+JVxuICBmaWx0ZXIobWVhbl9kYWlseV92YWx1ZSA+IDIwKSU+JVxuICBnZ2xpbmUoeCA9IFwiZGF0ZVwiLFxuICAgICAgICAgeSA9IFwibWVhbl9kYWlseV92YWx1ZVwiLFxuICAgICAgICAgcGxvdF90eXBlID0gXCJsXCIsXG4gICAgICAgICB4bGFiID0gXCJEYXRlXCIsXG4gICAgICAgICB5bGFiID0gXCJTYWxpbml0eSAoUFNVKVwiLFxuICAgICAgICAgdGl0bGUgPSBcIlBvc3RRQyBCMk8gU2FsaW5pdHkoUFNVKSBNZWFuIERhaWx5IFZhbHVlIGZyb20gMjAxMS0yMDIzXCIpXG5NRFZQb3N0UUNTYWxpbml0eVBsb3RcbiMgU2F2ZSBwbG90XG5nZ3NhdmUoZmlsZW5hbWUgPSBcIlNhbGluaXR5UGxvdC1NRFZQb3N0UUMucGRmXCIsIHBsb3QgPSBNRFZQb3N0UUNTYWxpbml0eVBsb3QsIFxuICAgICAgIHBhdGggPSBcIi9Vc2Vycy9ncmFtYmlobGVyL0RvY3VtZW50cy9EYXRhL0dpdEh1Yi9PY2VhbldhdGVyUXVhbGl0eS9ZU0lFeG9Tb25kZS9ZU0ktZmlndXJlcy9NRFZQb3N0UUNQbG90c1wiKVxuXG4jIGxpbmUgZ3JhcGggb2YgY29uZHVjdGl2aXR5IGluIHVTL2NtXG5NRFZQb3N0UUNDb25kdWN0aXZpdHlQbG90IDwtIFNETWVhbkRhaWx5VmFsdWVGcmFtZUZ1bGwgJT4lXG4gIGZpbHRlcih2YXJpYWJsZSA9PSBcImNvbmR1Y3Rpdml0eV91U2NtXCIpJT4lXG4gIGZpbHRlcihtZWFuX2RhaWx5X3ZhbHVlID4gMzAwMDApJT4lXG4gIGdnbGluZSh4ID0gXCJkYXRlXCIsXG4gICAgICAgICB5ID0gXCJtZWFuX2RhaWx5X3ZhbHVlXCIsXG4gICAgICAgICBwbG90X3R5cGUgPSBcImxcIixcbiAgICAgICAgIHhsYWIgPSBcIkRhdGVcIixcbiAgICAgICAgIHlsYWIgPSBcIkNvbmR1Y3Rpdml0eSh1Uy9jbSlcIixcbiAgICAgICAgIHRpdGxlID0gXCJQb3N0LVFDIEIyTyBDb25kdWN0aXZpdHkodVMvY20pIE1lYW4gRGFpbHkgVmFsdWUgZnJvbSAyMDExLTIwMjNcIilcbk1EVlBvc3RRQ0NvbmR1Y3Rpdml0eVBsb3RcbiMgU2F2ZSBwbG90XG5nZ3NhdmUoZmlsZW5hbWUgPSBcIkNvbmR1Y3Rpdml0eVBsb3QtTURWUG9zdFFDLnBkZlwiLCBwbG90ID0gTURWUG9zdFFDQ29uZHVjdGl2aXR5UGxvdCwgXG4gICAgICAgcGF0aCA9IFwiL1VzZXJzL2dyYW1iaWhsZXIvRG9jdW1lbnRzL0RhdGEvR2l0SHViL09jZWFuV2F0ZXJRdWFsaXR5L1lTSUV4b1NvbmRlL1lTSS1maWd1cmVzL01EVlBvc3RRQ1Bsb3RzXCIpXG5cbiMgbGluZSBncmFwaCBvZiBubGYgY29uZHVjdGl2aXR5IGluIHVTL2NtXG5NRFZQb3N0UUNOTEZDb25kdWN0aXZpdHlQbG90IDwtIFNETWVhbkRhaWx5VmFsdWVGcmFtZUZ1bGwgJT4lXG4gIGZpbHRlcih2YXJpYWJsZSA9PSBcIm5sZl9jb25kdWN0aXZpdHlfdVNjbVwiKSAlPiVcbiAgbmEub21pdCgpICU+JVxuICByZW1vdmVfc2Rfb3V0bGllcihjb2xzID0gXCJtZWFuX2RhaWx5X3ZhbHVlXCIsIFxuICAgICAgICAgICAgICAgICAgICBuX3NpZ21hcyA9IDIpICU+JVxuICBnZ2xpbmUoeCA9IFwiZGF0ZVwiLFxuICAgICAgICAgeSA9IFwibWVhbl9kYWlseV92YWx1ZVwiLFxuICAgICAgICAgcGxvdF90eXBlID0gXCJsXCIsXG4gICAgICAgICB4bGFiID0gXCJEYXRlXCIsXG4gICAgICAgICB5bGFiID0gXCJOTEYgQ29uZHVjdGl2aXR5KHVTL2NtKVwiLFxuICAgICAgICAgdGl0bGUgPSBcIlBvc3QtUUMgQjJPIE5MRiBDb25kdWN0aXZpdHkodVMvY20pIE1lYW4gRGFpbHkgVmFsdWUgZnJvbSAyMDExLTIwMjNcIilcbk1EVlBvc3RRQ05MRkNvbmR1Y3Rpdml0eVBsb3RcbiMgU2F2ZSBwbG90XG5nZ3NhdmUoZmlsZW5hbWUgPSBcIk5MRkNvbmR1Y3Rpdml0eVBsb3QtTURWUG9zdFFDLnBkZlwiLCBwbG90ID0gTURWUG9zdFFDTkxGQ29uZHVjdGl2aXR5UGxvdCwgXG4gICAgICAgcGF0aCA9IFwiL1VzZXJzL2dyYW1iaWhsZXIvRG9jdW1lbnRzL0RhdGEvR2l0SHViL09jZWFuV2F0ZXJRdWFsaXR5L1lTSUV4b1NvbmRlL1lTSS1maWd1cmVzL01EVlBvc3RRQ1Bsb3RzXCIpXG5cbiMgbGluZSBncmFwaCBvZiBzcGVjaWZpYyBjb25kdWN0aXZpdHkgaW4gdVMvY21cbk1EVlBvc3RRQ1NwQ29uZHVjdGl2aXR5UGxvdCA8LSBTRE1lYW5EYWlseVZhbHVlRnJhbWVGdWxsICU+JVxuICBmaWx0ZXIodmFyaWFibGUgPT0gXCJzcF9jb25kdWN0aXZpdHlfdVNjbVwiKSAlPiVcbiAgbmEub21pdCgpICU+JVxuICByZW1vdmVfc2Rfb3V0bGllcihjb2xzID0gXCJtZWFuX2RhaWx5X3ZhbHVlXCIsIFxuICAgICAgICAgICAgICAgICAgICBuX3NpZ21hcyA9IDIpICU+JVxuICBnZ2xpbmUoeCA9IFwiZGF0ZVwiLFxuICAgICAgICAgeSA9IFwibWVhbl9kYWlseV92YWx1ZVwiLFxuICAgICAgICAgcGxvdF90eXBlID0gXCJsXCIsXG4gICAgICAgICB4bGFiID0gXCJEYXRlXCIsXG4gICAgICAgICB5bGFiID0gXCJTcGVjaWZpYyBDb25kdWN0aXZpdHkodVMvY20pXCIsXG4gICAgICAgICB0aXRsZSA9IFwiUG9zdC1RQyBCMk8gU3BlY2lmaWMgQ29uZHVjdGl2aXR5KHVTL2NtKSBNZWFuIERhaWx5IFZhbHVlIGZyb20gMjAxMS0yMDIzXCIpXG5NRFZQb3N0UUNTcENvbmR1Y3Rpdml0eVBsb3RcbiMgU2F2ZSBwbG90XG5nZ3NhdmUoZmlsZW5hbWUgPSBcIlNwQ29uZHVjdGl2aXR5UGxvdC1NRFZQb3N0UUMucGRmXCIsIHBsb3QgPSBQb3N0UUNTcENvbmR1Y3Rpdml0eVBsb3QsXG4gICAgICAgcGF0aCA9IFwiL1VzZXJzL2dyYW1iaWhsZXIvRG9jdW1lbnRzL0RhdGEvR2l0SHViL09jZWFuV2F0ZXJRdWFsaXR5L1lTSUV4b1NvbmRlL1lTSS1maWd1cmVzL01EVlBvc3RRQ1Bsb3RzXCIpXG5cbiMgbGluZSBncmFwaCBvZiBETyBpbiBtZy9MXG5NRFZQb3N0UUNET21nTFBsb3QgPC0gU0RNZWFuRGFpbHlWYWx1ZUZyYW1lRnVsbCAlPiVcbiAgZmlsdGVyKHZhcmlhYmxlID09IFwiZG9fbWdMXCIpICU+JVxuICBuYS5vbWl0KCkgJT4lXG4gIHJlbW92ZV9zZF9vdXRsaWVyKGNvbHMgPSBcIm1lYW5fZGFpbHlfdmFsdWVcIiwgXG4gICAgICAgICAgICAgICAgICAgIG5fc2lnbWFzID0gMikgJT4lXG4gIGdnbGluZSh4ID0gXCJkYXRlXCIsXG4gICAgICAgICB5ID0gXCJtZWFuX2RhaWx5X3ZhbHVlXCIsXG4gICAgICAgICBwbG90X3R5cGUgPSBcImxcIixcbiAgICAgICAgIHhsYWIgPSBcIkRhdGVcIixcbiAgICAgICAgIHlsYWIgPSBcIkRpc3NvbHZlZCBPeHlnZW4obWcvTClcIixcbiAgICAgICAgIHRpdGxlID0gXCJQb3N0LVFDIEIyTyBEaXNzb2x2ZWQgT3h5Z2VuKG1nL0wpIE1lYW4gRGFpbHkgVmFsdWUgZnJvbSAyMDIxLTIwMjNcIilcbk1EVlBvc3RRQ0RPbWdMUGxvdFxuIyBTYXZlIHBsb3Rcbmdnc2F2ZShmaWxlbmFtZSA9IFwiRE9tZ0xQbG90LU1EVlBvc3RRQy5wZGZcIiwgcGxvdCA9IE1EVlBvc3RRQ0RPbWdMUGxvdCwgXG4gICAgICAgcGF0aCA9IFwiL1VzZXJzL2dyYW1iaWhsZXIvRG9jdW1lbnRzL0RhdGEvR2l0SHViL09jZWFuV2F0ZXJRdWFsaXR5L1lTSUV4b1NvbmRlL1lTSS1maWd1cmVzL01EVlBvc3RRQ1Bsb3RzXCIpXG5cbiMgbGluZSBncmFwaCBvZiBETyBpbiBwZXJjZW50IHNhdHVyYXRlZFxuTURWUG9zdFFDRE9QZXJjZW50U2F0dXJhdGVkUGxvdCA8LSBTRE1lYW5EYWlseVZhbHVlRnJhbWVGdWxsICU+JVxuICBmaWx0ZXIodmFyaWFibGUgPT0gXCJkb19zYXR1cmF0ZWRfcGVyY2VudFwiKSAlPiVcbiAgZmlsdGVyKG1lYW5fZGFpbHlfdmFsdWUgPCAxMDApICU+JVxuICBuYS5vbWl0KCkgJT4lXG4gIHJlbW92ZV9zZF9vdXRsaWVyKGNvbHMgPSBcIm1lYW5fZGFpbHlfdmFsdWVcIiwgXG4gICAgICAgICAgICAgICAgICAgIG5fc2lnbWFzID0gMikgJT4lXG4gIGdnbGluZSh4ID0gXCJkYXRlXCIsXG4gICAgICAgICB5ID0gXCJtZWFuX2RhaWx5X3ZhbHVlXCIsXG4gICAgICAgICBwbG90X3R5cGUgPSBcImxcIixcbiAgICAgICAgIHhsYWIgPSBcIkRhdGVcIixcbiAgICAgICAgIHlsYWIgPSBcIkRpc3NvbHZlZCBPeHlnZW4gUGVyY2VudCBTYXR1cmF0ZWRcIixcbiAgICAgICAgIHRpdGxlID0gXCJQb3N0LVFDIEIyTyBEaXNzb2x2ZWQgT3h5Z2VuIFBlcmNlbnQgU2F0dXJhdGVkIE1lYW4gRGFpbHkgVmFsdWUgZnJvbSAyMDE5LTIwMjNcIilcbk1EVlBvc3RRQ0RPUGVyY2VudFNhdHVyYXRlZFBsb3RcbiMgU2F2ZSBwbG90XG5nZ3NhdmUoZmlsZW5hbWUgPSBcIkRPUGVyY2VudFNhdHVyYXRlZFBsb3QtTURWUG9zdFFDLnBkZlwiLCBwbG90ID0gTURWUG9zdFFDRE9QZXJjZW50U2F0dXJhdGVkUGxvdCwgXG4gICAgICAgcGF0aCA9IFwiL1VzZXJzL2dyYW1iaWhsZXIvRG9jdW1lbnRzL0RhdGEvR2l0SHViL09jZWFuV2F0ZXJRdWFsaXR5L1lTSUV4b1NvbmRlL1lTSS1maWd1cmVzL01EVlBvc3RRQ1Bsb3RzXCIpXG5cbiMgbGluZSBncmFwaCBvZiBETyBpbiBwZXJjZW50IGxvY2FsXG5NRFZQb3N0UUNET1BlcmNlbnRMb2NhbFBsb3QgPC0gU0RNZWFuRGFpbHlWYWx1ZUZyYW1lRnVsbCAlPiVcbiAgZmlsdGVyKHZhcmlhYmxlID09IFwiZG9fbG9jYWxfcGVyY2VudFwiKSAlPiVcbiAgZ2dsaW5lKHggPSBcImRhdGVcIixcbiAgICAgICAgIHkgPSBcIm1lYW5fZGFpbHlfdmFsdWVcIixcbiAgICAgICAgIHBsb3RfdHlwZSA9IFwibFwiLFxuICAgICAgICAgeGxhYiA9IFwiRGF0ZVwiLFxuICAgICAgICAgeWxhYiA9IFwiRGlzc29sdmVkIE94eWdlbiBQZXJjZW50IExvY2FsXCIsXG4gICAgICAgICB0aXRsZSA9IFwiUG9zdC1RQyBCMk8gRGlzc29sdmVkIE94eWdlbiBQZXJjZW50IExvY2FsIE1lYW4gRGFpbHkgVmFsdWUgZnJvbSAyMDExLTIwMjNcIilcbk1EVlBvc3RRQ0RPUGVyY2VudExvY2FsUGxvdFxuIyBTYXZlIHBsb3Rcbmdnc2F2ZShmaWxlbmFtZSA9IFwiRE9QZXJjZW50TG9jYWxQbG90LU1EVlBvc3RRQy5wZGZcIiwgcGxvdCA9IE1EVlBvc3RRQ0RPUGVyY2VudExvY2FsUGxvdCxcbiAgICAgICBwYXRoID0gXCIvVXNlcnMvZ3JhbWJpaGxlci9Eb2N1bWVudHMvRGF0YS9HaXRIdWIvT2NlYW5XYXRlclF1YWxpdHkvWVNJRXhvU29uZGUvWVNJLWZpZ3VyZXMvTURWUG9zdFFDUGxvdHNcIilcblxuIyBsaW5lIGdyYXBoIG9mIE9SUCBpbiBtVlxuTURWUG9zdFFDT1JQUGxvdCA8LSBTRE1lYW5EYWlseVZhbHVlRnJhbWVGdWxsICU+JVxuICBmaWx0ZXIodmFyaWFibGUgPT0gXCJvcnBfbVZcIikgJT4lXG4gIGZpbHRlcihtZWFuX2RhaWx5X3ZhbHVlID4gMCklPiVcbiAgZ2dsaW5lKHggPSBcImRhdGVcIixcbiAgICAgICAgIHkgPSBcIm1lYW5fZGFpbHlfdmFsdWVcIixcbiAgICAgICAgIHBsb3RfdHlwZSA9IFwibFwiLFxuICAgICAgICAgeGxhYiA9IFwiRGF0ZVwiLFxuICAgICAgICAgeWxhYiA9IFwiT1JQKG1WKVwiLFxuICAgICAgICAgdGl0bGUgPSBcIlBvc3QtUUMgQjJPIE94aWRhdGlvbi1SZWR1Y3Rpb24gUG90ZW50aWFsKG1WKSBNZWFuIERhaWx5IFZhbHVlIGZyb20gMjAxMS0yMDIzXCIpXG5NRFZQb3N0UUNPUlBQbG90XG4jIFNhdmUgcGxvdFxuZ2dzYXZlKGZpbGVuYW1lID0gXCJPUlBQbG90LU1EVlBvc3RRQy5wZGZcIiwgcGxvdCA9IE1EVlBvc3RRQ09SUFBsb3QsIFxuICAgICAgIHBhdGggPSBcIi9Vc2Vycy9ncmFtYmlobGVyL0RvY3VtZW50cy9EYXRhL0dpdEh1Yi9PY2VhbldhdGVyUXVhbGl0eS9ZU0lFeG9Tb25kZS9ZU0ktZmlndXJlcy9NRFZQb3N0UUNQbG90c1wiKVxuXG4jIGxpbmUgZ3JhcGggb2YgY2hsb3JvcGh5bGwgaW4gUkZVXG5NRFZQb3N0UUNDaGxvcm9waHlsbFJGVVBsb3QgPC0gU0RNZWFuRGFpbHlWYWx1ZUZyYW1lRnVsbCAlPiVcbiAgZmlsdGVyKHZhcmlhYmxlID09IFwiY2hsb3JvcGh5bGxfcmZ1XCIpICU+JVxuICBuYS5vbWl0KCkgJT4lXG4gIHJlbW92ZV9zZF9vdXRsaWVyKGNvbHMgPSBcIm1lYW5fZGFpbHlfdmFsdWVcIiwgXG4gICAgICAgICAgICAgICAgICAgIG5fc2lnbWFzID0gMikgJT4lXG4gIGdnbGluZSh4ID0gXCJkYXRlXCIsXG4gICAgICAgICB5ID0gXCJtZWFuX2RhaWx5X3ZhbHVlXCIsXG4gICAgICAgICBwbG90X3R5cGUgPSBcImxcIixcbiAgICAgICAgIHhsYWIgPSBcIkRhdGVcIixcbiAgICAgICAgIHlsYWIgPSBcIkNobG9yb3BoeWxsKFJGVSlcIixcbiAgICAgICAgIHRpdGxlID0gXCJQb3N0LVFDIEIyTyBDaGxvcm9waHlsbChSRlUpIE1lYW4gRGFpbHkgVmFsdWUgZnJvbSAyMDIxLTIwMjNcIilcbk1EVlBvc3RRQ0NobG9yb3BoeWxsUkZVUGxvdFxuIyBTYXZlIHBsb3Rcbmdnc2F2ZShmaWxlbmFtZSA9IFwiQ2hsb3JvcGh5bGxSRlVQbG90LU1EVlBvc3RRQy5wZGZcIiwgcGxvdCA9IE1EVlBvc3RRQ0NobG9yb3BoeWxsUkZVUGxvdCxcbiAgICAgICBwYXRoID0gXCIvVXNlcnMvZ3JhbWJpaGxlci9Eb2N1bWVudHMvRGF0YS9HaXRIdWIvT2NlYW5XYXRlclF1YWxpdHkvWVNJRXhvU29uZGUvWVNJLWZpZ3VyZXMvTURWUG9zdFFDUGxvdHNcIilcblxuIyBsaW5lIGdyYXBoIG9mIGNobG9yb3BoeWxsIGluIHVnL0xcbk1EVlBvc3RRQ0NobG9yb3BoeWxsdWdMUGxvdCA8LSBTRE1lYW5EYWlseVZhbHVlRnJhbWVGdWxsICU+JVxuICBmaWx0ZXIodmFyaWFibGUgPT0gXCJjaGxvcm9waHlsbF91Z0xcIikgJT4lXG4gIGdnbGluZSh4ID0gXCJkYXRlXCIsXG4gICAgICAgICB5ID0gXCJtZWFuX2RhaWx5X3ZhbHVlXCIsXG4gICAgICAgICBwbG90X3R5cGUgPSBcImxcIixcbiAgICAgICAgIHhsYWIgPSBcIkRhdGVcIixcbiAgICAgICAgIHlsYWIgPSBcIkNobG9yb3BoeWxsKHVnL0wpXCIsXG4gICAgICAgICB0aXRsZSA9IFwiUG9zdC1RQyBCMk8gQ2hsb3JvcGh5bGwodWcvTCkgTWVhbiBEYWlseSBWYWx1ZSBmcm9tIDIwMTEtMjAyM1wiKVxuTURWUG9zdFFDQ2hsb3JvcGh5bGx1Z0xQbG90XG4jIFNhdmUgcGxvdFxuZ2dzYXZlKGZpbGVuYW1lID0gXCJDaGxvcm9waHlsbHVnTFBsb3QtTURWUG9zdFFDLnBkZlwiLCBwbG90ID0gTURWUG9zdFFDQ2hsb3JvcGh5bGx1Z0xQbG90LFxuICAgICAgIHBhdGggPSBcIi9Vc2Vycy9ncmFtYmlobGVyL0RvY3VtZW50cy9EYXRhL0dpdEh1Yi9PY2VhbldhdGVyUXVhbGl0eS9ZU0lFeG9Tb25kZS9ZU0ktZmlndXJlcy9NRFZQb3N0UUNQbG90c1wiKVxuXG4jIGxpbmUgZ3JhcGggb2YgdG90YWwgYWxnYWUgaW4gY2VsbHMvTFxuTURWUG9zdFFDVG90YWxBbGdhZVBsb3QgPC0gU0RNZWFuRGFpbHlWYWx1ZUZyYW1lRnVsbCAlPiVcbiAgZmlsdGVyKHZhcmlhYmxlID09IFwidG90YWxfYWxnYWVfY2VsbHNMXCIpICU+JVxuICBmaWx0ZXIobWVhbl9kYWlseV92YWx1ZSA+IDApICU+JVxuICBnZ2xpbmUoeCA9IFwiZGF0ZVwiLFxuICAgICAgICAgeSA9IFwibWVhbl9kYWlseV92YWx1ZVwiLFxuICAgICAgICAgcGxvdF90eXBlID0gXCJsXCIsXG4gICAgICAgICB4bGFiID0gXCJEYXRlXCIsXG4gICAgICAgICB5bGFiID0gXCJUb3RhbCBBbGdhZShjZWxscy9MKVwiLFxuICAgICAgICAgdGl0bGUgPSBcIlBvc3QtUUMgQjJPIFRvdGFsIEFsZ2FlKGNlbGxzL0wpIE1lYW4gRGFpbHkgVmFsdWUgZnJvbSAyMDExLTIwMjNcIikrXG4gIHNjYWxlX3hfZGF0ZShkYXRlX2xhYmVscyA9IFwiJW0tJWQtJVlcIilcbk1EVlBvc3RRQ1RvdGFsQWxnYWVQbG90XG4jIFNhdmUgcGxvdFxuZ2dzYXZlKGZpbGVuYW1lID0gXCJUb3RhbEFsZ2FlUGxvdC1NRFZQb3N0UUMucGRmXCIsIHBsb3QgPSBNRFZQb3N0UUNUb3RhbEFsZ2FlUGxvdCwgXG4gICAgICAgcGF0aCA9IFwiL1VzZXJzL2dyYW1iaWhsZXIvRG9jdW1lbnRzL0RhdGEvR2l0SHViL09jZWFuV2F0ZXJRdWFsaXR5L1lTSUV4b1NvbmRlL1lTSS1maWd1cmVzL01EVlBvc3RRQ1Bsb3RzXCIpXG5cbiMgbGluZSBncmFwaCBvZiB0b3RhbCBkaXNzb2x2ZWQgc29saWRzIGluIG1nL0xcbk1EVlBvc3RRQ1RvdGFsRGlzc29sdmVkU29saWRzUGxvdCA8LSBTRE1lYW5EYWlseVZhbHVlRnJhbWVGdWxsICU+JVxuICBmaWx0ZXIodmFyaWFibGUgPT0gXCJ0b3RhbF9kaXNzb2x2ZWRfc29saWRzX21nTFwiKSAlPiVcbiAgbmEub21pdCgpICU+JVxuICByZW1vdmVfc2Rfb3V0bGllcihjb2xzID0gXCJtZWFuX2RhaWx5X3ZhbHVlXCIsIFxuICAgICAgICAgICAgICAgICAgICBuX3NpZ21hcyA9IDIpICU+JVxuICBnZ2xpbmUoeCA9IFwiZGF0ZVwiLFxuICAgICAgICAgeSA9IFwibWVhbl9kYWlseV92YWx1ZVwiLFxuICAgICAgICAgcGxvdF90eXBlID0gXCJsXCIsXG4gICAgICAgICB4bGFiID0gXCJEYXRlXCIsXG4gICAgICAgICB5bGFiID0gXCJUb3RhbCBEaXNzb2x2ZWQgU29saWRzKG1nL0wpXCIsXG4gICAgICAgICB0aXRsZSA9IFwiUG9zdC1RQyBCMk8gVG90YWwgRGlzc29sdmVkIFNvbGlkcyhtZy9MKSBNZWFuIERhaWx5IFZhbHVlIGZyb20gMjAyMS0yMDIzXCIpXG5NRFZQb3N0UUNUb3RhbERpc3NvbHZlZFNvbGlkc1Bsb3RcbiMgU2F2ZSBwbG90XG5nZ3NhdmUoZmlsZW5hbWUgPSBcIlRvdGFsRGlzc29sdmVkU29saWRzUGxvdC1NRFZQb3N0UUMucGRmXCIsIHBsb3QgPSBNRFZQb3N0UUNUb3RhbERpc3NvbHZlZFNvbGlkc1Bsb3QsIFxuICAgICAgIHBhdGggPSBcIi9Vc2Vycy9ncmFtYmlobGVyL0RvY3VtZW50cy9EYXRhL0dpdEh1Yi9PY2VhbldhdGVyUXVhbGl0eS9ZU0lFeG9Tb25kZS9ZU0ktZmlndXJlcy9NRFZQb3N0UUNQbG90c1wiKVxuXG4jIGxpbmUgZ3JhcGggb2YgUk8gZmxvdyBpbiBnYWxsb25zL21pblxuTURWUG9zdFFDUk9GbG93UGxvdCA8LSBTRE1lYW5EYWlseVZhbHVlRnJhbWVGdWxsICU+JVxuICBmaWx0ZXIodmFyaWFibGUgPT0gXCJyb19mbG93X2dwbVwiKSAlPiVcbiAgZ2dsaW5lKHggPSBcImRhdGVcIixcbiAgICAgICAgIHkgPSBcIm1lYW5fZGFpbHlfdmFsdWVcIixcbiAgICAgICAgIHBsb3RfdHlwZSA9IFwibFwiLFxuICAgICAgICAgeGxhYiA9IFwiRGF0ZVwiLFxuICAgICAgICAgeWxhYiA9IFwiUk8gRmxvdyhnYWxsb25zL21pbnV0ZSlcIixcbiAgICAgICAgIHRpdGxlID0gXCJQb3N0LVFDIEIyTyBSTyBGbG93KGdhbGxvbnMvbWludXRlKSBNZWFuIERhaWx5IFZhbHVlIGZyb20gMjAxMS0yMDIzXCIpXG5NRFZQb3N0UUNST0Zsb3dQbG90XG4jIFNhdmUgcGxvdFxuZ2dzYXZlKGZpbGVuYW1lID0gXCJST0Zsb3dQbG90LU1EVlBvc3RRQy5wZGZcIiwgcGxvdCA9IE1EVlBvc3RRQ1JPRmxvd1Bsb3QsIFxuICAgICAgIHBhdGggPSBcIi9Vc2Vycy9ncmFtYmlobGVyL0RvY3VtZW50cy9EYXRhL0dpdEh1Yi9PY2VhbldhdGVyUXVhbGl0eS9ZU0lFeG9Tb25kZS9ZU0ktZmlndXJlcy9NRFZQb3N0UUNQbG90c1wiKVxuICBcbmBgYCJ9 -->

```r
# line graph of every variable - facet wrapped 
MDVAllVariablePlot <- MeanDailyValueFrame %>%
  ggplot(aes(x = date, 
             y = mean_daily_value)) +
  geom_line() +
  facet_wrap(~variable, ncol = 3, scales = "free")+
  scale_x_date(breaks = waiver(), date_breaks = "12 months",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O Water Quality Mean Daily Value by Variable from 2011-2023",
       subtitle = "Pre-QC: All Outliers Still Present")+
  xlab("Date")+
  ylab("Nutrient Value")
# Save plot
ggsave(filename = "AllVariablePlot-MDV.pdf", plot = MDVAllVariablePlot,
       path = "/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/YSIExoSonde/YSI-figures/MDVPostQCPlots", height = 12, width = 10)

# line graph of every variable - facet wrapped 
MDVPostQCAllVariablePlot <- QCMeanDailyValueFrame %>%
  ggplot(aes(x = date, 
             y = mean_daily_value)) +
  geom_line() +
  facet_wrap(~variable, ncol = 3, scales = "free")+
  scale_x_date(breaks = waiver(), date_breaks = "12 months",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O Water Quality Mean Daily Value by Variable from 2011-2023",
       subtitle = "Post-QC: Data Outside 2-Sigma from Mean has been Removed")+
  xlab("Date")+
  ylab("Nutrient Value")
# Save plot
ggsave(filename = "AllVariablePlot-MDVPostQC.pdf", plot = MDVPostQCAllVariablePlot,
       path = "/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/YSIExoSonde/YSI-figures/MDVPostQCPlots", height = 12, width = 10)

# line graph of temperature in fahrenheit
MDVPostQCTempFPlot <- SDMeanDailyValueFrameFull %>%
  filter(variable == "temp_f") %>%
  ggline(x = "date",
         y = "mean_daily_value",
         plot_type = "l",
         xlab = "Date",
         ylab = "Temperature (F)",
         title = "Post-QC B2O Temperature(F) Mean Daily Value from 2011-2023")
MDVPostQCTempFPlot
# Save plot
ggsave(filename = "TempFPlot-MDVPostQC.pdf", plot = MDVPostQCTempFPlot, 
       path = "/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/YSIExoSonde/YSI-figures/MDVPostQCPlots")

# line graph of temp in celcius
MDVPostQCTempCPlot <- SDMeanDailyValueFrameFull %>%
  filter(variable == "temp_c")%>%
  filter(mean_daily_value > 19 & mean_daily_value < 28) %>%
  na.omit() %>%
  remove_sd_outlier(cols = "mean_daily_value", 
                    n_sigmas = 2) %>%
  ggline(x = "date",
         y = "mean_daily_value",
         plot_type = "l",
         xlab = "Date",
         ylab = "Temperature (C)",
         title = "Post-QC B2O Temperature(C) Mean Daily Value from 2011-2023")
MDVPostQCTempCPlot
# Save plot
ggsave(filename = "TempCPlot-MDVPostQC.pdf", plot = MDVPostQCTempCPlot, 
       path = "/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/YSIExoSonde/YSI-figures/MDVPostQCPlots")

# line graph of pH in pH units
MDVPostQCpHPlot <- SDMeanDailyValueFrameFull %>%
  filter(variable == "pH") %>%
  filter(mean_daily_value > 7 & mean_daily_value < 10) %>%
  na.omit() %>%
  remove_sd_outlier(cols = "mean_daily_value", 
                    n_sigmas = 2) %>%
  ggline(x = "date",
         y = "mean_daily_value",
         plot_type = "l",
         xlab = "Date",
         ylab = "pH",
         title = "Post-QC B2O pH Mean Daily Value from 2011-2023")
MDVPostQCpHPlot
# Save plot
ggsave(filename = "pHPlot-MDVPostQC.pdf", plot = MDVPostQCpHPlot, 
       path = "/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/YSIExoSonde/YSI-figures/MDVPostQCPlots")

# line graph of pH in mV
MDVPostQCpHmVPlot <- SDMeanDailyValueFrameFull %>%
  filter(variable == "pH_mV") %>%
  ggline(x = "date",
         y = "mean_daily_value",
         plot_type = "l",
         xlab = "Date",
         ylab = "pH (mV)",
         title = "Post-QC B2O pH(mV) Mean Daily Value from 2011-2023")
MDVPostQCpHmVPlot
# Save plot
ggsave(filename = "pHmVPlot-MDVPostQC.pdf", plot = MDVPostQCpHmVPlot, 
       path = "/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/YSIExoSonde/YSI-figures/MDVPostQCPlots")

# line graph of salinity in psu
MDVPostQCSalinityPlot <- SDMeanDailyValueFrameFull %>%
  filter(variable == "salinity_psu")%>%
  filter(mean_daily_value > 20)%>%
  ggline(x = "date",
         y = "mean_daily_value",
         plot_type = "l",
         xlab = "Date",
         ylab = "Salinity (PSU)",
         title = "PostQC B2O Salinity(PSU) Mean Daily Value from 2011-2023")
MDVPostQCSalinityPlot
# Save plot
ggsave(filename = "SalinityPlot-MDVPostQC.pdf", plot = MDVPostQCSalinityPlot, 
       path = "/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/YSIExoSonde/YSI-figures/MDVPostQCPlots")

# line graph of conductivity in uS/cm
MDVPostQCConductivityPlot <- SDMeanDailyValueFrameFull %>%
  filter(variable == "conductivity_uScm")%>%
  filter(mean_daily_value > 30000)%>%
  ggline(x = "date",
         y = "mean_daily_value",
         plot_type = "l",
         xlab = "Date",
         ylab = "Conductivity(uS/cm)",
         title = "Post-QC B2O Conductivity(uS/cm) Mean Daily Value from 2011-2023")
MDVPostQCConductivityPlot
# Save plot
ggsave(filename = "ConductivityPlot-MDVPostQC.pdf", plot = MDVPostQCConductivityPlot, 
       path = "/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/YSIExoSonde/YSI-figures/MDVPostQCPlots")

# line graph of nlf conductivity in uS/cm
MDVPostQCNLFConductivityPlot <- SDMeanDailyValueFrameFull %>%
  filter(variable == "nlf_conductivity_uScm") %>%
  na.omit() %>%
  remove_sd_outlier(cols = "mean_daily_value", 
                    n_sigmas = 2) %>%
  ggline(x = "date",
         y = "mean_daily_value",
         plot_type = "l",
         xlab = "Date",
         ylab = "NLF Conductivity(uS/cm)",
         title = "Post-QC B2O NLF Conductivity(uS/cm) Mean Daily Value from 2011-2023")
MDVPostQCNLFConductivityPlot
# Save plot
ggsave(filename = "NLFConductivityPlot-MDVPostQC.pdf", plot = MDVPostQCNLFConductivityPlot, 
       path = "/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/YSIExoSonde/YSI-figures/MDVPostQCPlots")

# line graph of specific conductivity in uS/cm
MDVPostQCSpConductivityPlot <- SDMeanDailyValueFrameFull %>%
  filter(variable == "sp_conductivity_uScm") %>%
  na.omit() %>%
  remove_sd_outlier(cols = "mean_daily_value", 
                    n_sigmas = 2) %>%
  ggline(x = "date",
         y = "mean_daily_value",
         plot_type = "l",
         xlab = "Date",
         ylab = "Specific Conductivity(uS/cm)",
         title = "Post-QC B2O Specific Conductivity(uS/cm) Mean Daily Value from 2011-2023")
MDVPostQCSpConductivityPlot
# Save plot
ggsave(filename = "SpConductivityPlot-MDVPostQC.pdf", plot = PostQCSpConductivityPlot,
       path = "/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/YSIExoSonde/YSI-figures/MDVPostQCPlots")

# line graph of DO in mg/L
MDVPostQCDOmgLPlot <- SDMeanDailyValueFrameFull %>%
  filter(variable == "do_mgL") %>%
  na.omit() %>%
  remove_sd_outlier(cols = "mean_daily_value", 
                    n_sigmas = 2) %>%
  ggline(x = "date",
         y = "mean_daily_value",
         plot_type = "l",
         xlab = "Date",
         ylab = "Dissolved Oxygen(mg/L)",
         title = "Post-QC B2O Dissolved Oxygen(mg/L) Mean Daily Value from 2021-2023")
MDVPostQCDOmgLPlot
# Save plot
ggsave(filename = "DOmgLPlot-MDVPostQC.pdf", plot = MDVPostQCDOmgLPlot, 
       path = "/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/YSIExoSonde/YSI-figures/MDVPostQCPlots")

# line graph of DO in percent saturated
MDVPostQCDOPercentSaturatedPlot <- SDMeanDailyValueFrameFull %>%
  filter(variable == "do_saturated_percent") %>%
  filter(mean_daily_value < 100) %>%
  na.omit() %>%
  remove_sd_outlier(cols = "mean_daily_value", 
                    n_sigmas = 2) %>%
  ggline(x = "date",
         y = "mean_daily_value",
         plot_type = "l",
         xlab = "Date",
         ylab = "Dissolved Oxygen Percent Saturated",
         title = "Post-QC B2O Dissolved Oxygen Percent Saturated Mean Daily Value from 2019-2023")
MDVPostQCDOPercentSaturatedPlot
# Save plot
ggsave(filename = "DOPercentSaturatedPlot-MDVPostQC.pdf", plot = MDVPostQCDOPercentSaturatedPlot, 
       path = "/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/YSIExoSonde/YSI-figures/MDVPostQCPlots")

# line graph of DO in percent local
MDVPostQCDOPercentLocalPlot <- SDMeanDailyValueFrameFull %>%
  filter(variable == "do_local_percent") %>%
  ggline(x = "date",
         y = "mean_daily_value",
         plot_type = "l",
         xlab = "Date",
         ylab = "Dissolved Oxygen Percent Local",
         title = "Post-QC B2O Dissolved Oxygen Percent Local Mean Daily Value from 2011-2023")
MDVPostQCDOPercentLocalPlot
# Save plot
ggsave(filename = "DOPercentLocalPlot-MDVPostQC.pdf", plot = MDVPostQCDOPercentLocalPlot,
       path = "/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/YSIExoSonde/YSI-figures/MDVPostQCPlots")

# line graph of ORP in mV
MDVPostQCORPPlot <- SDMeanDailyValueFrameFull %>%
  filter(variable == "orp_mV") %>%
  filter(mean_daily_value > 0)%>%
  ggline(x = "date",
         y = "mean_daily_value",
         plot_type = "l",
         xlab = "Date",
         ylab = "ORP(mV)",
         title = "Post-QC B2O Oxidation-Reduction Potential(mV) Mean Daily Value from 2011-2023")
MDVPostQCORPPlot
# Save plot
ggsave(filename = "ORPPlot-MDVPostQC.pdf", plot = MDVPostQCORPPlot, 
       path = "/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/YSIExoSonde/YSI-figures/MDVPostQCPlots")

# line graph of chlorophyll in RFU
MDVPostQCChlorophyllRFUPlot <- SDMeanDailyValueFrameFull %>%
  filter(variable == "chlorophyll_rfu") %>%
  na.omit() %>%
  remove_sd_outlier(cols = "mean_daily_value", 
                    n_sigmas = 2) %>%
  ggline(x = "date",
         y = "mean_daily_value",
         plot_type = "l",
         xlab = "Date",
         ylab = "Chlorophyll(RFU)",
         title = "Post-QC B2O Chlorophyll(RFU) Mean Daily Value from 2021-2023")
MDVPostQCChlorophyllRFUPlot
# Save plot
ggsave(filename = "ChlorophyllRFUPlot-MDVPostQC.pdf", plot = MDVPostQCChlorophyllRFUPlot,
       path = "/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/YSIExoSonde/YSI-figures/MDVPostQCPlots")

# line graph of chlorophyll in ug/L
MDVPostQCChlorophyllugLPlot <- SDMeanDailyValueFrameFull %>%
  filter(variable == "chlorophyll_ugL") %>%
  ggline(x = "date",
         y = "mean_daily_value",
         plot_type = "l",
         xlab = "Date",
         ylab = "Chlorophyll(ug/L)",
         title = "Post-QC B2O Chlorophyll(ug/L) Mean Daily Value from 2011-2023")
MDVPostQCChlorophyllugLPlot
# Save plot
ggsave(filename = "ChlorophyllugLPlot-MDVPostQC.pdf", plot = MDVPostQCChlorophyllugLPlot,
       path = "/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/YSIExoSonde/YSI-figures/MDVPostQCPlots")

# line graph of total algae in cells/L
MDVPostQCTotalAlgaePlot <- SDMeanDailyValueFrameFull %>%
  filter(variable == "total_algae_cellsL") %>%
  filter(mean_daily_value > 0) %>%
  ggline(x = "date",
         y = "mean_daily_value",
         plot_type = "l",
         xlab = "Date",
         ylab = "Total Algae(cells/L)",
         title = "Post-QC B2O Total Algae(cells/L) Mean Daily Value from 2011-2023")+
  scale_x_date(date_labels = "%m-%d-%Y")
MDVPostQCTotalAlgaePlot
# Save plot
ggsave(filename = "TotalAlgaePlot-MDVPostQC.pdf", plot = MDVPostQCTotalAlgaePlot, 
       path = "/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/YSIExoSonde/YSI-figures/MDVPostQCPlots")

# line graph of total dissolved solids in mg/L
MDVPostQCTotalDissolvedSolidsPlot <- SDMeanDailyValueFrameFull %>%
  filter(variable == "total_dissolved_solids_mgL") %>%
  na.omit() %>%
  remove_sd_outlier(cols = "mean_daily_value", 
                    n_sigmas = 2) %>%
  ggline(x = "date",
         y = "mean_daily_value",
         plot_type = "l",
         xlab = "Date",
         ylab = "Total Dissolved Solids(mg/L)",
         title = "Post-QC B2O Total Dissolved Solids(mg/L) Mean Daily Value from 2021-2023")
MDVPostQCTotalDissolvedSolidsPlot
# Save plot
ggsave(filename = "TotalDissolvedSolidsPlot-MDVPostQC.pdf", plot = MDVPostQCTotalDissolvedSolidsPlot, 
       path = "/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/YSIExoSonde/YSI-figures/MDVPostQCPlots")

# line graph of RO flow in gallons/min
MDVPostQCROFlowPlot <- SDMeanDailyValueFrameFull %>%
  filter(variable == "ro_flow_gpm") %>%
  ggline(x = "date",
         y = "mean_daily_value",
         plot_type = "l",
         xlab = "Date",
         ylab = "RO Flow(gallons/minute)",
         title = "Post-QC B2O RO Flow(gallons/minute) Mean Daily Value from 2011-2023")
MDVPostQCROFlowPlot
# Save plot
ggsave(filename = "ROFlowPlot-MDVPostQC.pdf", plot = MDVPostQCROFlowPlot, 
       path = "/Users/grambihler/Documents/Data/GitHub/OceanWaterQuality/YSIExoSonde/YSI-figures/MDVPostQCPlots")
  
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->

