
<!-- rnb-text-begin -->

---
title: "YSI Figures Post-QC"
Collaborators: Renee Grambihler
Project: OceanWaterQuality
Institution: Biosphere 2 Ocean
output: html_notebook
---

## Import Libraries

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeSh0aWR5dmVyc2UpXG5saWJyYXJ5KGx1YnJpZGF0ZSlcbmBgYCJ9 -->

```r
library(tidyverse)
library(lubridate)
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


# Import Data

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBEYXRhIGFmdGVyIFFDIC0tIHZhbHVlcyBvdXRzaWRlIG9mIDIgc2lnbWEgYXdheSBmcm9tIG1lYW4gb2YgZXZlcnkgbW9udGggZm9yIGV2ZXJ5IHZhcmlhYmxlIHdlcmUgdHVybmVkIGludG8gTkEgdmFsdWVzXG5kZlFDIDwtIHJlYWRfY3N2KFwiRGF0YS9DbGVhbkRhdGEvQ2xlYW5EYXRhX1lTSS8wMl9RdWFsaXR5Q29udHJvbC8wMi1PY2VhbldhdGVyUXVhbGl0eURhdGEtUUMuY3N2XCIpXG5gYGAifQ== -->

```r
# Data after QC -- values outside of 2 sigma away from mean of every month for every variable were turned into NA values
dfQC <- read_csv("Data/CleanData/CleanData_YSI/02_QualityControl/02-OceanWaterQualityData-QC.csv")
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

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBEYXRhIGFmdGVyIFFDIGFuZCBDdXRvZmYgdmFsdWVzIGltcGxlbWVudGVkXG5kZlFDQ3V0b2ZmIDwtIHJlYWRfY3N2KFwiRGF0YS9DbGVhbkRhdGEvQ2xlYW5EYXRhX1lTSS8wMl9RdWFsaXR5Q29udHJvbC8wMy1PY2VhbldhdGVyUXVhbGl0eURhdGEtUUNDdXRvZmYuY3N2XCIpXG5gYGAifQ== -->

```r
# Data after QC and Cutoff values implemented
dfQCCutoff <- read_csv("Data/CleanData/CleanData_YSI/02_QualityControl/03-OceanWaterQualityData-QCCutoff.csv")
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


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBwaXZvdCBkZlFDIGxvbmdlciBmb3IgZWFzaWVyIGFsbC12YXJpYWJsZSBwbG90dGluZ1xuZGZRQ1Bpdm90IDwtIGRmUUMgJT4lXG4gIHBpdm90X2xvbmdlcihjb2xzID0gdGVtcF9mOnRvdGFsX2Rpc3NvbHZlZF9zb2xpZHNfbWdMLFxuICAgICAgICAgICAgICAgbmFtZXNfdG8gPSBcInZhcmlhYmxlXCIsXG4gICAgICAgICAgICAgICB2YWx1ZXNfdG8gPSBcInZhcmlhYmxlX3ZhbHVlXCIpJT4lXG4gIG11dGF0ZShkYXRlID0gYXMuRGF0ZShkYXRlLCBmb3JtYXQgPSBcIiVZLyVtLyVkXCIpKVxuXG4jIHBpdm90IGRmUUNDdXQgbG9uZ2VyIGZvciBlYXNpZXIgYWxsLXZhcmlhYmxlIHBsb3R0aW5nXG5kZlFDQ3V0UGl2b3QgPC0gZGZRQ0N1dG9mZiAlPiVcbiAgcGl2b3RfbG9uZ2VyKGNvbHMgPSB0ZW1wX2Y6dG90YWxfZGlzc29sdmVkX3NvbGlkc19tZ0wsXG4gICAgICAgICAgICAgICBuYW1lc190byA9IFwidmFyaWFibGVcIixcbiAgICAgICAgICAgICAgIHZhbHVlc190byA9IFwidmFyaWFibGVfdmFsdWVcIiklPiVcbiAgbXV0YXRlKGRhdGUgPSBhcy5EYXRlKGRhdGUsIGZvcm1hdCA9IFwiJVkvJW0vJWRcIikpXG5gYGAifQ== -->

```r
# pivot dfQC longer for easier all-variable plotting
dfQCPivot <- dfQC %>%
  pivot_longer(cols = temp_f:total_dissolved_solids_mgL,
               names_to = "variable",
               values_to = "variable_value")%>%
  mutate(date = as.Date(date, format = "%Y/%m/%d"))

# pivot dfQCCut longer for easier all-variable plotting
dfQCCutPivot <- dfQCCutoff %>%
  pivot_longer(cols = temp_f:total_dissolved_solids_mgL,
               names_to = "variable",
               values_to = "variable_value")%>%
  mutate(date = as.Date(date, format = "%Y/%m/%d"))
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


# Plotting
# After Initial Standard Deviation QC

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBsaW5lIGdyYXBoIG9mIGV2ZXJ5IHZhcmlhYmxlIC0gZmFjZXQgd3JhcHBlZCBcbkFsbFZhcmlhYmxlUGxvdF9Qb3N0UUMgPC0gZGZRQ1Bpdm90ICU+JVxuICBnZ3Bsb3QoYWVzKHggPSBkYXRlLCBcbiAgICAgICAgICAgICB5ID0gdmFyaWFibGVfdmFsdWUpKSArXG4gIGdlb21fbGluZSgpICtcbiAgZmFjZXRfd3JhcCh+dmFyaWFibGUsIG5jb2wgPSAzLCBzY2FsZXMgPSBcImZyZWVcIikrXG4gIHNjYWxlX3hfZGF0ZShicmVha3MgPSB3YWl2ZXIoKSwgZGF0ZV9icmVha3MgPSBcIjEgeWVhclwiLFxuICAgICAgICAgICAgICAgZGF0ZV9sYWJlbHMgPSBcIiViICVZXCIpICtcbiAgdGhlbWVfYncoKSArIFxuICB0aGVtZShwYW5lbC5ncmlkLm1ham9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuZ3JpZC5taW5vciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmJhY2tncm91bmQgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBheGlzLmxpbmUgPSBlbGVtZW50X2xpbmUoY29sb3VyID0gXCJibGFja1wiKSkrXG4gIHRoZW1lKGF4aXMudGV4dC54ID0gZWxlbWVudF90ZXh0KGFuZ2xlID0gNDUsIGhqdXN0ID0gMSksXG4gICAgICAgIHBsb3QubWFyZ2luID0gbWFyZ2luKDAuMjUsIDAuNDUsIDAuMjUsIDAuMjUsIFwiaW5jaFwiKSkrXG4gIHRoZW1lKHN0cmlwLmJhY2tncm91bmQgPSBlbGVtZW50X3JlY3QoZmlsbCA9IFwid2hpdGVcIikpK1xuICBsYWJzKHRpdGxlID0gXCJCMk8gV2F0ZXIgUXVhbGl0eSBieSBWYXJpYWJsZSBmcm9tIDIwMTEtMjAyM1wiLFxuICAgICAgIHN1YnRpdGxlID0gXCJQb3N0LVFDOiBEYXRhIE91dHNpZGUgMi1TaWdtYSBmcm9tIE1lYW4gaGFzIGJlZW4gUmVtb3ZlZFwiKStcbiAgeGxhYihcIkRhdGVcIikrXG4gIHlsYWIoXCJOdXRyaWVudCBWYWx1ZVwiKVxuIyBTYXZlIHBsb3Rcbmdnc2F2ZShmaWxlbmFtZSA9IFwiQWxsVmFyaWFibGVQbG90LVBvc3RRQy5wZGZcIiwgcGxvdCA9IEFsbFZhcmlhYmxlUGxvdF9Qb3N0UUMsIFxuICAgICAgIHBhdGggPSBcIkZpZ3VyZXMvRmlndXJlc19ZU0kvMDItUG9zdFFDUGxvdHNcIiwgaGVpZ2h0ID0gMTIsIHdpZHRoID0gMTApXG5cbiMgbGluZSBncmFwaCBvZiB0ZW1wZXJhdHVyZSBpbiBmYWhyZW5oZWl0XG5UZW1wRlBsb3RfUG9zdFFDIDwtIGRmUUNQaXZvdCAlPiVcbiAgZmlsdGVyKHZhcmlhYmxlID09IFwidGVtcF9mXCIpICU+JVxuICBnZ3Bsb3QoYWVzKHggPSBkYXRlLCBcbiAgICAgICAgICAgICB5ID0gdmFyaWFibGVfdmFsdWUpKSArXG4gIGdlb21fbGluZSgpICtcbiAgc2NhbGVfeF9kYXRlKGJyZWFrcyA9IHdhaXZlcigpLCBkYXRlX2JyZWFrcyA9IFwiMSB5ZWFyXCIsXG4gICAgICAgICAgICAgICBkYXRlX2xhYmVscyA9IFwiJWIgJVlcIikgK1xuICB0aGVtZV9idygpICsgXG4gIHRoZW1lKHBhbmVsLmdyaWQubWFqb3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5ncmlkLm1pbm9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuYmFja2dyb3VuZCA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIGF4aXMubGluZSA9IGVsZW1lbnRfbGluZShjb2xvdXIgPSBcImJsYWNrXCIpKStcbiAgdGhlbWUoYXhpcy50ZXh0LnggPSBlbGVtZW50X3RleHQoYW5nbGUgPSA0NSwgaGp1c3QgPSAxKSxcbiAgICAgICAgcGxvdC5tYXJnaW4gPSBtYXJnaW4oMC4yNSwgMC40NSwgMC4yNSwgMC4yNSwgXCJpbmNoXCIpKStcbiAgdGhlbWUoc3RyaXAuYmFja2dyb3VuZCA9IGVsZW1lbnRfcmVjdChmaWxsID0gXCJ3aGl0ZVwiKSkrXG4gIGxhYnModGl0bGUgPSBcIkIyTyBUZW1wZXJhdHVyZSAowrpGKSBmcm9tIDIwMTEtMjAyM1wiLFxuICAgICAgIHN1YnRpdGxlID0gXCJQb3N0LVFDOiBEYXRhIE91dHNpZGUgMi1TaWdtYSBmcm9tIE1lYW4gaGFzIGJlZW4gUmVtb3ZlZFwiKStcbiAgeGxhYihcIkRhdGVcIikrXG4gIHlsYWIoXCJUZW1wZXJhdHVyZSAowrpGKVwiKVxuIyBTYXZlIHBsb3Rcbmdnc2F2ZShmaWxlbmFtZSA9IFwiVGVtcEZQbG90LVBvc3RRQy5wZGZcIiwgcGxvdCA9IFRlbXBGUGxvdF9Qb3N0UUMsIFxuICAgICAgIHBhdGggPSBcIkZpZ3VyZXMvRmlndXJlc19ZU0kvMDItUG9zdFFDUGxvdHNcIilcblxuIyBsaW5lIGdyYXBoIG9mIHRlbXAgaW4gY2VsY2l1c1xuVGVtcENQbG90X1Bvc3RRQyA8LSBkZlFDUGl2b3QgJT4lXG4gIGZpbHRlcih2YXJpYWJsZSA9PSBcInRlbXBfY1wiKSU+JVxuICBnZ3Bsb3QoYWVzKHggPSBkYXRlLCBcbiAgICAgICAgICAgICB5ID0gdmFyaWFibGVfdmFsdWUpKSArXG4gIGdlb21fbGluZSgpICtcbiAgc2NhbGVfeF9kYXRlKGJyZWFrcyA9IHdhaXZlcigpLCBkYXRlX2JyZWFrcyA9IFwiMSB5ZWFyXCIsXG4gICAgICAgICAgICAgICBkYXRlX2xhYmVscyA9IFwiJWIgJVlcIikgK1xuICB0aGVtZV9idygpICsgXG4gIHRoZW1lKHBhbmVsLmdyaWQubWFqb3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5ncmlkLm1pbm9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuYmFja2dyb3VuZCA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIGF4aXMubGluZSA9IGVsZW1lbnRfbGluZShjb2xvdXIgPSBcImJsYWNrXCIpKStcbiAgdGhlbWUoYXhpcy50ZXh0LnggPSBlbGVtZW50X3RleHQoYW5nbGUgPSA0NSwgaGp1c3QgPSAxKSxcbiAgICAgICAgcGxvdC5tYXJnaW4gPSBtYXJnaW4oMC4yNSwgMC40NSwgMC4yNSwgMC4yNSwgXCJpbmNoXCIpKStcbiAgdGhlbWUoc3RyaXAuYmFja2dyb3VuZCA9IGVsZW1lbnRfcmVjdChmaWxsID0gXCJ3aGl0ZVwiKSkrXG4gIGxhYnModGl0bGUgPSBcIkIyTyBUZW1wZXJhdHVyZSAowrpDKSBmcm9tIDIwMTEtMjAyM1wiLFxuICAgICAgIHN1YnRpdGxlID0gXCJQb3N0LVFDOiBEYXRhIE91dHNpZGUgMi1TaWdtYSBmcm9tIE1lYW4gaGFzIGJlZW4gUmVtb3ZlZFwiKStcbiAgeGxhYihcIkRhdGVcIikrXG4gIHlsYWIoXCJUZW1wZXJhdHVyZSAowrpDKVwiKVxuIyBTYXZlIHBsb3Rcbmdnc2F2ZShmaWxlbmFtZSA9IFwiVGVtcENQbG90LVBvc3RRQy5wZGZcIiwgcGxvdCA9IFRlbXBDUGxvdF9Qb3N0UUMsIFxuICAgICAgIHBhdGggPSBcIkZpZ3VyZXMvRmlndXJlc19ZU0kvMDItUG9zdFFDUGxvdHNcIilcblxuIyBsaW5lIGdyYXBoIG9mIHBIIGluIHBIIHVuaXRzXG5wSFBsb3RfUG9zdFFDIDwtIGRmUUNQaXZvdCAlPiVcbiAgZmlsdGVyKHZhcmlhYmxlID09IFwicEhcIikgJT4lXG4gIGdncGxvdChhZXMoeCA9IGRhdGUsIFxuICAgICAgICAgICAgIHkgPSB2YXJpYWJsZV92YWx1ZSkpICtcbiAgZ2VvbV9saW5lKCkgK1xuICBzY2FsZV94X2RhdGUoYnJlYWtzID0gd2FpdmVyKCksIGRhdGVfYnJlYWtzID0gXCIxIHllYXJcIixcbiAgICAgICAgICAgICAgIGRhdGVfbGFiZWxzID0gXCIlYiAlWVwiKSArXG4gIHRoZW1lX2J3KCkgKyBcbiAgdGhlbWUocGFuZWwuZ3JpZC5tYWpvciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmdyaWQubWlub3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5iYWNrZ3JvdW5kID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgYXhpcy5saW5lID0gZWxlbWVudF9saW5lKGNvbG91ciA9IFwiYmxhY2tcIikpK1xuICB0aGVtZShheGlzLnRleHQueCA9IGVsZW1lbnRfdGV4dChhbmdsZSA9IDQ1LCBoanVzdCA9IDEpLFxuICAgICAgICBwbG90Lm1hcmdpbiA9IG1hcmdpbigwLjI1LCAwLjQ1LCAwLjI1LCAwLjI1LCBcImluY2hcIikpK1xuICB0aGVtZShzdHJpcC5iYWNrZ3JvdW5kID0gZWxlbWVudF9yZWN0KGZpbGwgPSBcIndoaXRlXCIpKStcbiAgbGFicyh0aXRsZSA9IFwiQjJPIHBIIGZyb20gMjAxMS0yMDIzXCIsXG4gICAgICAgc3VidGl0bGUgPSBcIlBvc3QtUUM6IERhdGEgT3V0c2lkZSAyLVNpZ21hIGZyb20gTWVhbiBoYXMgYmVlbiBSZW1vdmVkXCIpK1xuICB4bGFiKFwiRGF0ZVwiKStcbiAgeWxhYihcInBIXCIpXG4jIFNhdmUgcGxvdFxuZ2dzYXZlKGZpbGVuYW1lID0gXCJwSFBsb3QtUG9zdFFDLnBkZlwiLCBwbG90ID0gcEhQbG90X1Bvc3RRQywgXG4gICAgICAgcGF0aCA9IFwiRmlndXJlcy9GaWd1cmVzX1lTSS8wMi1Qb3N0UUNQbG90c1wiKVxuXG4jIGxpbmUgZ3JhcGggb2YgcEggaW4gbVZcbnBIbVZQbG90X1Bvc3RRQyA8LSBkZlFDUGl2b3QgJT4lXG4gIGZpbHRlcih2YXJpYWJsZSA9PSBcInBIX21WXCIpICU+JVxuICBnZ3Bsb3QoYWVzKHggPSBkYXRlLCBcbiAgICAgICAgICAgICB5ID0gdmFyaWFibGVfdmFsdWUpKSArXG4gIGdlb21fbGluZSgpICtcbiAgc2NhbGVfeF9kYXRlKGJyZWFrcyA9IHdhaXZlcigpLCBkYXRlX2JyZWFrcyA9IFwiMSB5ZWFyXCIsXG4gICAgICAgICAgICAgICBkYXRlX2xhYmVscyA9IFwiJWIgJVlcIikgK1xuICB0aGVtZV9idygpICsgXG4gIHRoZW1lKHBhbmVsLmdyaWQubWFqb3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5ncmlkLm1pbm9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuYmFja2dyb3VuZCA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIGF4aXMubGluZSA9IGVsZW1lbnRfbGluZShjb2xvdXIgPSBcImJsYWNrXCIpKStcbiAgdGhlbWUoYXhpcy50ZXh0LnggPSBlbGVtZW50X3RleHQoYW5nbGUgPSA0NSwgaGp1c3QgPSAxKSxcbiAgICAgICAgcGxvdC5tYXJnaW4gPSBtYXJnaW4oMC4yNSwgMC40NSwgMC4yNSwgMC4yNSwgXCJpbmNoXCIpKStcbiAgdGhlbWUoc3RyaXAuYmFja2dyb3VuZCA9IGVsZW1lbnRfcmVjdChmaWxsID0gXCJ3aGl0ZVwiKSkrXG4gIGxhYnModGl0bGUgPSBcIkIyTyBwSCAobVYpIGZyb20gMjAxMS0yMDIzXCIsXG4gICAgICAgc3VidGl0bGUgPSBcIlBvc3QtUUM6IERhdGEgT3V0c2lkZSAyLVNpZ21hIGZyb20gTWVhbiBoYXMgYmVlbiBSZW1vdmVkXCIpK1xuICB4bGFiKFwiRGF0ZVwiKStcbiAgeWxhYihcInBIIChtVilcIilcbiMgU2F2ZSBwbG90XG5nZ3NhdmUoZmlsZW5hbWUgPSBcInBIbVZQbG90LVBvc3RRQy5wZGZcIiwgcGxvdCA9IHBIbVZQbG90X1Bvc3RRQywgXG4gICAgICAgcGF0aCA9IFwiRmlndXJlcy9GaWd1cmVzX1lTSS8wMi1Qb3N0UUNQbG90c1wiKVxuXG4jIGxpbmUgZ3JhcGggb2Ygc2FsaW5pdHkgaW4gcHN1XG5TYWxpbml0eVBsb3RfUG9zdFFDIDwtIGRmUUNQaXZvdCAlPiVcbiAgZmlsdGVyKHZhcmlhYmxlID09IFwic2FsaW5pdHlfcHN1XCIpJT4lXG4gIGdncGxvdChhZXMoeCA9IGRhdGUsIFxuICAgICAgICAgICAgIHkgPSB2YXJpYWJsZV92YWx1ZSkpICtcbiAgZ2VvbV9saW5lKCkgK1xuICBzY2FsZV94X2RhdGUoYnJlYWtzID0gd2FpdmVyKCksIGRhdGVfYnJlYWtzID0gXCIxIHllYXJcIixcbiAgICAgICAgICAgICAgIGRhdGVfbGFiZWxzID0gXCIlYiAlWVwiKSArXG4gIHRoZW1lX2J3KCkgKyBcbiAgdGhlbWUocGFuZWwuZ3JpZC5tYWpvciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmdyaWQubWlub3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5iYWNrZ3JvdW5kID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgYXhpcy5saW5lID0gZWxlbWVudF9saW5lKGNvbG91ciA9IFwiYmxhY2tcIikpK1xuICB0aGVtZShheGlzLnRleHQueCA9IGVsZW1lbnRfdGV4dChhbmdsZSA9IDQ1LCBoanVzdCA9IDEpLFxuICAgICAgICBwbG90Lm1hcmdpbiA9IG1hcmdpbigwLjI1LCAwLjQ1LCAwLjI1LCAwLjI1LCBcImluY2hcIikpK1xuICB0aGVtZShzdHJpcC5iYWNrZ3JvdW5kID0gZWxlbWVudF9yZWN0KGZpbGwgPSBcIndoaXRlXCIpKStcbiAgbGFicyh0aXRsZSA9IFwiQjJPIFNhbGluaXR5IChQU1UpIGZyb20gMjAxMS0yMDIzXCIsXG4gICAgICAgc3VidGl0bGUgPSBcIlBvc3QtUUM6IERhdGEgT3V0c2lkZSAyLVNpZ21hIGZyb20gTWVhbiBoYXMgYmVlbiBSZW1vdmVkXCIpK1xuICB4bGFiKFwiRGF0ZVwiKStcbiAgeWxhYihcIlNhbGluaXR5IChQU1UpXCIpXG4jIFNhdmUgcGxvdFxuZ2dzYXZlKGZpbGVuYW1lID0gXCJTYWxpbml0eVBsb3QtUG9zdFFDLnBkZlwiLCBwbG90ID0gU2FsaW5pdHlQbG90X1Bvc3RRQywgXG4gICAgICAgcGF0aCA9IFwiRmlndXJlcy9GaWd1cmVzX1lTSS8wMi1Qb3N0UUNQbG90c1wiKVxuXG4jIGxpbmUgZ3JhcGggb2YgY29uZHVjdGl2aXR5IGluIHVTL2NtXG5Db25kdWN0aXZpdHlQbG90X1Bvc3RRQyA8LSBkZlFDUGl2b3QgJT4lXG4gIGZpbHRlcih2YXJpYWJsZSA9PSBcImNvbmR1Y3Rpdml0eV91U2NtXCIpJT4lXG4gIGdncGxvdChhZXMoeCA9IGRhdGUsIFxuICAgICAgICAgICAgIHkgPSB2YXJpYWJsZV92YWx1ZSkpICtcbiAgZ2VvbV9saW5lKCkgK1xuICBzY2FsZV94X2RhdGUoYnJlYWtzID0gd2FpdmVyKCksIGRhdGVfYnJlYWtzID0gXCIxIHllYXJcIixcbiAgICAgICAgICAgICAgIGRhdGVfbGFiZWxzID0gXCIlYiAlWVwiKSArXG4gIHRoZW1lX2J3KCkgKyBcbiAgdGhlbWUocGFuZWwuZ3JpZC5tYWpvciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmdyaWQubWlub3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5iYWNrZ3JvdW5kID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgYXhpcy5saW5lID0gZWxlbWVudF9saW5lKGNvbG91ciA9IFwiYmxhY2tcIikpK1xuICB0aGVtZShheGlzLnRleHQueCA9IGVsZW1lbnRfdGV4dChhbmdsZSA9IDQ1LCBoanVzdCA9IDEpLFxuICAgICAgICBwbG90Lm1hcmdpbiA9IG1hcmdpbigwLjI1LCAwLjQ1LCAwLjI1LCAwLjI1LCBcImluY2hcIikpK1xuICB0aGVtZShzdHJpcC5iYWNrZ3JvdW5kID0gZWxlbWVudF9yZWN0KGZpbGwgPSBcIndoaXRlXCIpKStcbiAgbGFicyh0aXRsZSA9IFwiQjJPIENvbmR1Y3Rpdml0eSAowrVTL2NtKSBmcm9tIDIwMTEtMjAyM1wiLFxuICAgICAgIHN1YnRpdGxlID0gXCJQb3N0LVFDOiBEYXRhIE91dHNpZGUgMi1TaWdtYSBmcm9tIE1lYW4gaGFzIGJlZW4gUmVtb3ZlZFwiKStcbiAgeGxhYihcIkRhdGVcIikrXG4gIHlsYWIoXCJDb25kdWN0aXZpdHkgKMK1Uy9jbSlcIilcbiMgU2F2ZSBwbG90XG5nZ3NhdmUoZmlsZW5hbWUgPSBcIkNvbmR1Y3Rpdml0eVBsb3QtUG9zdFFDLnBkZlwiLCBwbG90ID0gQ29uZHVjdGl2aXR5UGxvdF9Qb3N0UUMsIFxuICAgICAgIHBhdGggPSBcIkZpZ3VyZXMvRmlndXJlc19ZU0kvMDItUG9zdFFDUGxvdHNcIilcblxuIyBsaW5lIGdyYXBoIG9mIG5sZiBjb25kdWN0aXZpdHkgaW4gdVMvY21cbk5MRkNvbmR1Y3Rpdml0eVBsb3RfUG9zdFFDIDwtIGRmUUNQaXZvdCAlPiVcbiAgZmlsdGVyKHZhcmlhYmxlID09IFwibmxmX2NvbmR1Y3Rpdml0eV91U2NtXCIpICU+JVxuICBnZ3Bsb3QoYWVzKHggPSBkYXRlLCBcbiAgICAgICAgICAgICB5ID0gdmFyaWFibGVfdmFsdWUpKSArXG4gIGdlb21fbGluZSgpICtcbiAgc2NhbGVfeF9kYXRlKGJyZWFrcyA9IHdhaXZlcigpLCBkYXRlX2JyZWFrcyA9IFwiMSB5ZWFyXCIsXG4gICAgICAgICAgICAgICBkYXRlX2xhYmVscyA9IFwiJWIgJVlcIikgK1xuICB0aGVtZV9idygpICsgXG4gIHRoZW1lKHBhbmVsLmdyaWQubWFqb3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5ncmlkLm1pbm9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuYmFja2dyb3VuZCA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIGF4aXMubGluZSA9IGVsZW1lbnRfbGluZShjb2xvdXIgPSBcImJsYWNrXCIpKStcbiAgdGhlbWUoYXhpcy50ZXh0LnggPSBlbGVtZW50X3RleHQoYW5nbGUgPSA0NSwgaGp1c3QgPSAxKSxcbiAgICAgICAgcGxvdC5tYXJnaW4gPSBtYXJnaW4oMC4yNSwgMC40NSwgMC4yNSwgMC4yNSwgXCJpbmNoXCIpKStcbiAgdGhlbWUoc3RyaXAuYmFja2dyb3VuZCA9IGVsZW1lbnRfcmVjdChmaWxsID0gXCJ3aGl0ZVwiKSkrXG4gIGxhYnModGl0bGUgPSBcIkIyTyBOTEYgQ29uZHVjdGl2aXR5ICjCtVMvY20pIGZyb20gMjAxMS0yMDIzXCIsXG4gICAgICAgc3VidGl0bGUgPSBcIlBvc3QtUUM6IERhdGEgT3V0c2lkZSAyLVNpZ21hIGZyb20gTWVhbiBoYXMgYmVlbiBSZW1vdmVkXCIpK1xuICB4bGFiKFwiRGF0ZVwiKStcbiAgeWxhYihcIk5MRiBDb25kdWN0aXZpdHkgKMK1Uy9jbSlcIilcbiMgU2F2ZSBwbG90XG5nZ3NhdmUoZmlsZW5hbWUgPSBcIk5MRkNvbmR1Y3Rpdml0eVBsb3QtUG9zdFFDLnBkZlwiLCBwbG90ID0gTkxGQ29uZHVjdGl2aXR5UGxvdF9Qb3N0UUMsIFxuICAgICAgIHBhdGggPSBcIkZpZ3VyZXMvRmlndXJlc19ZU0kvMDItUG9zdFFDUGxvdHNcIilcblxuIyBsaW5lIGdyYXBoIG9mIHNwZWNpZmljIGNvbmR1Y3Rpdml0eSBpbiB1Uy9jbVxuU3BDb25kdWN0aXZpdHlQbG90X1Bvc3RRQyA8LSBkZlFDUGl2b3QgJT4lXG4gIGZpbHRlcih2YXJpYWJsZSA9PSBcInNwX2NvbmR1Y3Rpdml0eV91U2NtXCIpICU+JVxuICBnZ3Bsb3QoYWVzKHggPSBkYXRlLCBcbiAgICAgICAgICAgICB5ID0gdmFyaWFibGVfdmFsdWUpKSArXG4gIGdlb21fbGluZSgpICtcbiAgc2NhbGVfeF9kYXRlKGJyZWFrcyA9IHdhaXZlcigpLCBkYXRlX2JyZWFrcyA9IFwiMSB5ZWFyXCIsXG4gICAgICAgICAgICAgICBkYXRlX2xhYmVscyA9IFwiJWIgJVlcIikgK1xuICB0aGVtZV9idygpICsgXG4gIHRoZW1lKHBhbmVsLmdyaWQubWFqb3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5ncmlkLm1pbm9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuYmFja2dyb3VuZCA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIGF4aXMubGluZSA9IGVsZW1lbnRfbGluZShjb2xvdXIgPSBcImJsYWNrXCIpKStcbiAgdGhlbWUoYXhpcy50ZXh0LnggPSBlbGVtZW50X3RleHQoYW5nbGUgPSA0NSwgaGp1c3QgPSAxKSxcbiAgICAgICAgcGxvdC5tYXJnaW4gPSBtYXJnaW4oMC4yNSwgMC40NSwgMC4yNSwgMC4yNSwgXCJpbmNoXCIpKStcbiAgdGhlbWUoc3RyaXAuYmFja2dyb3VuZCA9IGVsZW1lbnRfcmVjdChmaWxsID0gXCJ3aGl0ZVwiKSkrXG4gIGxhYnModGl0bGUgPSBcIkIyTyBTcGVjaWZpYyBDb25kdWN0aXZpdHkgKMK1Uy9jbSkgZnJvbSAyMDExLTIwMjNcIixcbiAgICAgICBzdWJ0aXRsZSA9IFwiUG9zdC1RQzogRGF0YSBPdXRzaWRlIDItU2lnbWEgZnJvbSBNZWFuIGhhcyBiZWVuIFJlbW92ZWRcIikrXG4gIHhsYWIoXCJEYXRlXCIpK1xuICB5bGFiKFwiU3BlY2lmaWMgQ29uZHVjdGl2aXR5ICjCtVMvY20pXCIpXG4jIFNhdmUgcGxvdFxuZ2dzYXZlKGZpbGVuYW1lID0gXCJTcENvbmR1Y3Rpdml0eVBsb3QtUG9zdFFDLnBkZlwiLCBwbG90ID0gU3BDb25kdWN0aXZpdHlQbG90X1Bvc3RRQyxcbiAgICAgICBwYXRoID0gXCJGaWd1cmVzL0ZpZ3VyZXNfWVNJLzAyLVBvc3RRQ1Bsb3RzXCIpXG5cbiMgbGluZSBncmFwaCBvZiBETyBpbiBtZy9MXG5ET21nTFBsb3RfUG9zdFFDIDwtIGRmUUNQaXZvdCAlPiVcbiAgZmlsdGVyKHZhcmlhYmxlID09IFwiZG9fbWdMXCIpICU+JVxuICBnZ3Bsb3QoYWVzKHggPSBkYXRlLCBcbiAgICAgICAgICAgICB5ID0gdmFyaWFibGVfdmFsdWUpKSArXG4gIGdlb21fbGluZSgpICtcbiAgc2NhbGVfeF9kYXRlKGJyZWFrcyA9IHdhaXZlcigpLCBkYXRlX2JyZWFrcyA9IFwiMSB5ZWFyXCIsXG4gICAgICAgICAgICAgICBkYXRlX2xhYmVscyA9IFwiJWIgJVlcIikgK1xuICB0aGVtZV9idygpICsgXG4gIHRoZW1lKHBhbmVsLmdyaWQubWFqb3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5ncmlkLm1pbm9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuYmFja2dyb3VuZCA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIGF4aXMubGluZSA9IGVsZW1lbnRfbGluZShjb2xvdXIgPSBcImJsYWNrXCIpKStcbiAgdGhlbWUoYXhpcy50ZXh0LnggPSBlbGVtZW50X3RleHQoYW5nbGUgPSA0NSwgaGp1c3QgPSAxKSxcbiAgICAgICAgcGxvdC5tYXJnaW4gPSBtYXJnaW4oMC4yNSwgMC40NSwgMC4yNSwgMC4yNSwgXCJpbmNoXCIpKStcbiAgdGhlbWUoc3RyaXAuYmFja2dyb3VuZCA9IGVsZW1lbnRfcmVjdChmaWxsID0gXCJ3aGl0ZVwiKSkrXG4gIGxhYnModGl0bGUgPSBcIkIyTyBEaXNzb2x2ZWQgT3h5Z2VuIChtZy9MKSBmcm9tIDIwMTEtMjAyM1wiLFxuICAgICAgIHN1YnRpdGxlID0gXCJQb3N0LVFDOiBEYXRhIE91dHNpZGUgMi1TaWdtYSBmcm9tIE1lYW4gaGFzIGJlZW4gUmVtb3ZlZFwiKStcbiAgeGxhYihcIkRhdGVcIikrXG4gIHlsYWIoXCJEaXNzb2x2ZWQgT3h5Z2VuIChtZy9MKVwiKVxuIyBTYXZlIHBsb3Rcbmdnc2F2ZShmaWxlbmFtZSA9IFwiRE9tZ0xQbG90LVBvc3RRQy5wZGZcIiwgcGxvdCA9IERPbWdMUGxvdF9Qb3N0UUMsIFxuICAgICAgIHBhdGggPSBcIkZpZ3VyZXMvRmlndXJlc19ZU0kvMDItUG9zdFFDUGxvdHNcIilcblxuIyBsaW5lIGdyYXBoIG9mIERPIGluIHBlcmNlbnQgc2F0dXJhdGVkXG5ET1BlcmNlbnRTYXR1cmF0ZWRQbG90X1Bvc3RRQyA8LSBkZlFDUGl2b3QgJT4lXG4gIGZpbHRlcih2YXJpYWJsZSA9PSBcImRvX3NhdHVyYXRlZF9wZXJjZW50XCIpICU+JVxuICBnZ3Bsb3QoYWVzKHggPSBkYXRlLCBcbiAgICAgICAgICAgICB5ID0gdmFyaWFibGVfdmFsdWUpKSArXG4gIGdlb21fbGluZSgpICtcbiAgc2NhbGVfeF9kYXRlKGJyZWFrcyA9IHdhaXZlcigpLCBkYXRlX2JyZWFrcyA9IFwiMSB5ZWFyXCIsXG4gICAgICAgICAgICAgICBkYXRlX2xhYmVscyA9IFwiJWIgJVlcIikgK1xuICB0aGVtZV9idygpICsgXG4gIHRoZW1lKHBhbmVsLmdyaWQubWFqb3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5ncmlkLm1pbm9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuYmFja2dyb3VuZCA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIGF4aXMubGluZSA9IGVsZW1lbnRfbGluZShjb2xvdXIgPSBcImJsYWNrXCIpKStcbiAgdGhlbWUoYXhpcy50ZXh0LnggPSBlbGVtZW50X3RleHQoYW5nbGUgPSA0NSwgaGp1c3QgPSAxKSxcbiAgICAgICAgcGxvdC5tYXJnaW4gPSBtYXJnaW4oMC4yNSwgMC40NSwgMC4yNSwgMC4yNSwgXCJpbmNoXCIpKStcbiAgdGhlbWUoc3RyaXAuYmFja2dyb3VuZCA9IGVsZW1lbnRfcmVjdChmaWxsID0gXCJ3aGl0ZVwiKSkrXG4gIGxhYnModGl0bGUgPSBcIkIyTyBTYXR1cmF0ZWQgRGlzc29sdmVkIE94eWdlbiAoJSkgZnJvbSAyMDExLTIwMjNcIixcbiAgICAgICBzdWJ0aXRsZSA9IFwiUG9zdC1RQzogRGF0YSBPdXRzaWRlIDItU2lnbWEgZnJvbSBNZWFuIGhhcyBiZWVuIFJlbW92ZWRcIikrXG4gIHhsYWIoXCJEYXRlXCIpK1xuICB5bGFiKFwiU2F0dXJhdGVkIERpc3NvbHZlZCBPeHlnZW4gKCUpXCIpXG4jIFNhdmUgcGxvdFxuZ2dzYXZlKGZpbGVuYW1lID0gXCJET1BlcmNlbnRTYXR1cmF0ZWRQbG90LVBvc3RRQy5wZGZcIiwgcGxvdCA9IERPUGVyY2VudFNhdHVyYXRlZFBsb3RfUG9zdFFDLCBcbiAgICAgICBwYXRoID0gXCJGaWd1cmVzL0ZpZ3VyZXNfWVNJLzAyLVBvc3RRQ1Bsb3RzXCIpXG5cbiMgbGluZSBncmFwaCBvZiBETyBpbiBwZXJjZW50IGxvY2FsXG5ET1BlcmNlbnRMb2NhbFBsb3RfUG9zdFFDIDwtIGRmUUNQaXZvdCAlPiVcbiAgZmlsdGVyKHZhcmlhYmxlID09IFwiZG9fbG9jYWxfcGVyY2VudFwiKSAlPiVcbiAgZ2dwbG90KGFlcyh4ID0gZGF0ZSwgXG4gICAgICAgICAgICAgeSA9IHZhcmlhYmxlX3ZhbHVlKSkgK1xuICBnZW9tX2xpbmUoKSArXG4gIHNjYWxlX3hfZGF0ZShicmVha3MgPSB3YWl2ZXIoKSwgZGF0ZV9icmVha3MgPSBcIjEgeWVhclwiLFxuICAgICAgICAgICAgICAgZGF0ZV9sYWJlbHMgPSBcIiViICVZXCIpICtcbiAgdGhlbWVfYncoKSArIFxuICB0aGVtZShwYW5lbC5ncmlkLm1ham9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuZ3JpZC5taW5vciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmJhY2tncm91bmQgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBheGlzLmxpbmUgPSBlbGVtZW50X2xpbmUoY29sb3VyID0gXCJibGFja1wiKSkrXG4gIHRoZW1lKGF4aXMudGV4dC54ID0gZWxlbWVudF90ZXh0KGFuZ2xlID0gNDUsIGhqdXN0ID0gMSksXG4gICAgICAgIHBsb3QubWFyZ2luID0gbWFyZ2luKDAuMjUsIDAuNDUsIDAuMjUsIDAuMjUsIFwiaW5jaFwiKSkrXG4gIHRoZW1lKHN0cmlwLmJhY2tncm91bmQgPSBlbGVtZW50X3JlY3QoZmlsbCA9IFwid2hpdGVcIikpK1xuICBsYWJzKHRpdGxlID0gXCJCMk8gTG9jYWwgRGlzc29sdmVkIE94eWdlbiAoJSkgZnJvbSAyMDExLTIwMjNcIixcbiAgICAgICBzdWJ0aXRsZSA9IFwiUG9zdC1RQzogRGF0YSBPdXRzaWRlIDItU2lnbWEgZnJvbSBNZWFuIGhhcyBiZWVuIFJlbW92ZWRcIikrXG4gIHhsYWIoXCJEYXRlXCIpK1xuICB5bGFiKFwiTG9jYWwgRGlzc29sdmVkIE94eWdlbiAoJSlcIilcbiMgU2F2ZSBwbG90XG5nZ3NhdmUoZmlsZW5hbWUgPSBcIkRPUGVyY2VudExvY2FsUGxvdC1Qb3N0UUMucGRmXCIsIHBsb3QgPSBET1BlcmNlbnRMb2NhbFBsb3RfUG9zdFFDLFxuICAgICAgIHBhdGggPSBcIkZpZ3VyZXMvRmlndXJlc19ZU0kvMDItUG9zdFFDUGxvdHNcIilcblxuIyBsaW5lIGdyYXBoIG9mIE9SUCBpbiBtVlxuT1JQUGxvdF9Qb3N0UUMgPC0gZGZRQ1Bpdm90ICU+JVxuICBmaWx0ZXIodmFyaWFibGUgPT0gXCJvcnBfbVZcIikgJT4lXG4gIGdncGxvdChhZXMoeCA9IGRhdGUsIFxuICAgICAgICAgICAgIHkgPSB2YXJpYWJsZV92YWx1ZSkpICtcbiAgZ2VvbV9saW5lKCkgK1xuICBzY2FsZV94X2RhdGUoYnJlYWtzID0gd2FpdmVyKCksIGRhdGVfYnJlYWtzID0gXCIxIHllYXJcIixcbiAgICAgICAgICAgICAgIGRhdGVfbGFiZWxzID0gXCIlYiAlWVwiKSArXG4gIHRoZW1lX2J3KCkgKyBcbiAgdGhlbWUocGFuZWwuZ3JpZC5tYWpvciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmdyaWQubWlub3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5iYWNrZ3JvdW5kID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgYXhpcy5saW5lID0gZWxlbWVudF9saW5lKGNvbG91ciA9IFwiYmxhY2tcIikpK1xuICB0aGVtZShheGlzLnRleHQueCA9IGVsZW1lbnRfdGV4dChhbmdsZSA9IDQ1LCBoanVzdCA9IDEpLFxuICAgICAgICBwbG90Lm1hcmdpbiA9IG1hcmdpbigwLjI1LCAwLjQ1LCAwLjI1LCAwLjI1LCBcImluY2hcIikpK1xuICB0aGVtZShzdHJpcC5iYWNrZ3JvdW5kID0gZWxlbWVudF9yZWN0KGZpbGwgPSBcIndoaXRlXCIpKStcbiAgbGFicyh0aXRsZSA9IFwiQjJPIE9SUCAobVYpIGZyb20gMjAxMS0yMDIzXCIsXG4gICAgICAgc3VidGl0bGUgPSBcIlBvc3QtUUM6IERhdGEgT3V0c2lkZSAyLVNpZ21hIGZyb20gTWVhbiBoYXMgYmVlbiBSZW1vdmVkXCIpK1xuICB4bGFiKFwiRGF0ZVwiKStcbiAgeWxhYihcIk9SUCAobVYpXCIpXG4jIFNhdmUgcGxvdFxuZ2dzYXZlKGZpbGVuYW1lID0gXCJPUlBQbG90LVBvc3RRQy5wZGZcIiwgcGxvdCA9IE9SUFBsb3RfUG9zdFFDLCBcbiAgICAgICBwYXRoID0gXCJGaWd1cmVzL0ZpZ3VyZXNfWVNJLzAyLVBvc3RRQ1Bsb3RzXCIpXG5cbiMgbGluZSBncmFwaCBvZiBjaGxvcm9waHlsbCBpbiBSRlVcbkNobG9yb3BoeWxsUkZVUGxvdF9Qb3N0UUMgPC0gZGZRQ1Bpdm90ICU+JVxuICBmaWx0ZXIodmFyaWFibGUgPT0gXCJjaGxvcm9waHlsbF9yZnVcIikgJT4lXG4gIGdncGxvdChhZXMoeCA9IGRhdGUsIFxuICAgICAgICAgICAgIHkgPSB2YXJpYWJsZV92YWx1ZSkpICtcbiAgZ2VvbV9saW5lKCkgK1xuICBzY2FsZV94X2RhdGUoYnJlYWtzID0gd2FpdmVyKCksIGRhdGVfYnJlYWtzID0gXCIxIHllYXJcIixcbiAgICAgICAgICAgICAgIGRhdGVfbGFiZWxzID0gXCIlYiAlWVwiKSArXG4gIHRoZW1lX2J3KCkgKyBcbiAgdGhlbWUocGFuZWwuZ3JpZC5tYWpvciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmdyaWQubWlub3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5iYWNrZ3JvdW5kID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgYXhpcy5saW5lID0gZWxlbWVudF9saW5lKGNvbG91ciA9IFwiYmxhY2tcIikpK1xuICB0aGVtZShheGlzLnRleHQueCA9IGVsZW1lbnRfdGV4dChhbmdsZSA9IDQ1LCBoanVzdCA9IDEpLFxuICAgICAgICBwbG90Lm1hcmdpbiA9IG1hcmdpbigwLjI1LCAwLjQ1LCAwLjI1LCAwLjI1LCBcImluY2hcIikpK1xuICB0aGVtZShzdHJpcC5iYWNrZ3JvdW5kID0gZWxlbWVudF9yZWN0KGZpbGwgPSBcIndoaXRlXCIpKStcbiAgbGFicyh0aXRsZSA9IFwiQjJPIENobG9yb3BoeWxsIChSRlUpIGZyb20gMjAxMS0yMDIzXCIsXG4gICAgICAgc3VidGl0bGUgPSBcIlBvc3QtUUM6IERhdGEgT3V0c2lkZSAyLVNpZ21hIGZyb20gTWVhbiBoYXMgYmVlbiBSZW1vdmVkXCIpK1xuICB4bGFiKFwiRGF0ZVwiKStcbiAgeWxhYihcIkNobG9yb3BoeWxsIChSRlUpXCIpXG4jIFNhdmUgcGxvdFxuZ2dzYXZlKGZpbGVuYW1lID0gXCJDaGxvcm9waHlsbFJGVVBsb3QtUG9zdFFDLnBkZlwiLCBwbG90ID0gQ2hsb3JvcGh5bGxSRlVQbG90X1Bvc3RRQyxcbiAgICAgICBwYXRoID0gXCJGaWd1cmVzL0ZpZ3VyZXNfWVNJLzAyLVBvc3RRQ1Bsb3RzXCIpXG5cbiMgbGluZSBncmFwaCBvZiBjaGxvcm9waHlsbCBpbiB1Zy9MXG5DaGxvcm9waHlsbHVnTFBsb3RfUG9zdFFDIDwtIGRmUUNQaXZvdCAlPiVcbiAgZmlsdGVyKHZhcmlhYmxlID09IFwiY2hsb3JvcGh5bGxfdWdMXCIpICU+JVxuICBnZ3Bsb3QoYWVzKHggPSBkYXRlLCBcbiAgICAgICAgICAgICB5ID0gdmFyaWFibGVfdmFsdWUpKSArXG4gIGdlb21fbGluZSgpICtcbiAgc2NhbGVfeF9kYXRlKGJyZWFrcyA9IHdhaXZlcigpLCBkYXRlX2JyZWFrcyA9IFwiMSB5ZWFyXCIsXG4gICAgICAgICAgICAgICBkYXRlX2xhYmVscyA9IFwiJWIgJVlcIikgK1xuICB0aGVtZV9idygpICsgXG4gIHRoZW1lKHBhbmVsLmdyaWQubWFqb3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5ncmlkLm1pbm9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuYmFja2dyb3VuZCA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIGF4aXMubGluZSA9IGVsZW1lbnRfbGluZShjb2xvdXIgPSBcImJsYWNrXCIpKStcbiAgdGhlbWUoYXhpcy50ZXh0LnggPSBlbGVtZW50X3RleHQoYW5nbGUgPSA0NSwgaGp1c3QgPSAxKSxcbiAgICAgICAgcGxvdC5tYXJnaW4gPSBtYXJnaW4oMC4yNSwgMC40NSwgMC4yNSwgMC4yNSwgXCJpbmNoXCIpKStcbiAgdGhlbWUoc3RyaXAuYmFja2dyb3VuZCA9IGVsZW1lbnRfcmVjdChmaWxsID0gXCJ3aGl0ZVwiKSkrXG4gIGxhYnModGl0bGUgPSBcIkIyTyBDaGxvcm9waHlsbCAowrVnL0wpIGZyb20gMjAxMS0yMDIzXCIsXG4gICAgICAgc3VidGl0bGUgPSBcIlBvc3QtUUM6IERhdGEgT3V0c2lkZSAyLVNpZ21hIGZyb20gTWVhbiBoYXMgYmVlbiBSZW1vdmVkXCIpK1xuICB4bGFiKFwiRGF0ZVwiKStcbiAgeWxhYihcIkNobG9yb3BoeWxsICjCtWcvTClcIilcbiMgU2F2ZSBwbG90XG5nZ3NhdmUoZmlsZW5hbWUgPSBcIkNobG9yb3BoeWxsdWdMUGxvdC1Qb3N0UUMucGRmXCIsIHBsb3QgPSBDaGxvcm9waHlsbHVnTFBsb3RfUG9zdFFDLFxuICAgICAgIHBhdGggPSBcIkZpZ3VyZXMvRmlndXJlc19ZU0kvMDItUG9zdFFDUGxvdHNcIilcblxuIyBsaW5lIGdyYXBoIG9mIHRvdGFsIGFsZ2FlIGluIGNlbGxzL0xcblRvdGFsQWxnYWVQbG90X1Bvc3RRQyA8LSBkZlFDUGl2b3QgJT4lXG4gIGZpbHRlcih2YXJpYWJsZSA9PSBcInRvdGFsX2FsZ2FlX2NlbGxzTFwiKSAlPiVcbiAgZ2dwbG90KGFlcyh4ID0gZGF0ZSwgXG4gICAgICAgICAgICAgeSA9IHZhcmlhYmxlX3ZhbHVlKSkgK1xuICBnZW9tX2xpbmUoKSArXG4gIHNjYWxlX3hfZGF0ZShicmVha3MgPSB3YWl2ZXIoKSwgZGF0ZV9icmVha3MgPSBcIjEgeWVhclwiLFxuICAgICAgICAgICAgICAgZGF0ZV9sYWJlbHMgPSBcIiViICVZXCIpICtcbiAgdGhlbWVfYncoKSArIFxuICB0aGVtZShwYW5lbC5ncmlkLm1ham9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuZ3JpZC5taW5vciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmJhY2tncm91bmQgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBheGlzLmxpbmUgPSBlbGVtZW50X2xpbmUoY29sb3VyID0gXCJibGFja1wiKSkrXG4gIHRoZW1lKGF4aXMudGV4dC54ID0gZWxlbWVudF90ZXh0KGFuZ2xlID0gNDUsIGhqdXN0ID0gMSksXG4gICAgICAgIHBsb3QubWFyZ2luID0gbWFyZ2luKDAuMjUsIDAuNDUsIDAuMjUsIDAuMjUsIFwiaW5jaFwiKSkrXG4gIHRoZW1lKHN0cmlwLmJhY2tncm91bmQgPSBlbGVtZW50X3JlY3QoZmlsbCA9IFwid2hpdGVcIikpK1xuICBsYWJzKHRpdGxlID0gXCJCMk8gVG90YWwgQWxnYWUgKGNlbGxzL0wpIGZyb20gMjAxMS0yMDIzXCIsXG4gICAgICAgc3VidGl0bGUgPSBcIlBvc3QtUUM6IERhdGEgT3V0c2lkZSAyLVNpZ21hIGZyb20gTWVhbiBoYXMgYmVlbiBSZW1vdmVkXCIpK1xuICB4bGFiKFwiRGF0ZVwiKStcbiAgeWxhYihcIlRvdGFsIEFsZ2FlIChjZWxscy9MKVwiKVxuIyBTYXZlIHBsb3Rcbmdnc2F2ZShmaWxlbmFtZSA9IFwiVG90YWxBbGdhZVBsb3QtUG9zdFFDLnBkZlwiLCBwbG90ID0gVG90YWxBbGdhZVBsb3RfUG9zdFFDLCBcbiAgICAgICBwYXRoID0gXCJGaWd1cmVzL0ZpZ3VyZXNfWVNJLzAyLVBvc3RRQ1Bsb3RzXCIpXG5cbiMgbGluZSBncmFwaCBvZiB0b3RhbCBkaXNzb2x2ZWQgc29saWRzIGluIG1nL0xcblRvdGFsRGlzc29sdmVkU29saWRzUGxvdF9Qb3N0UUMgPC0gZGZRQ1Bpdm90ICU+JVxuICBmaWx0ZXIodmFyaWFibGUgPT0gXCJ0b3RhbF9kaXNzb2x2ZWRfc29saWRzX21nTFwiKSAlPiVcbiAgZ2dwbG90KGFlcyh4ID0gZGF0ZSwgXG4gICAgICAgICAgICAgeSA9IHZhcmlhYmxlX3ZhbHVlKSkgK1xuICBnZW9tX2xpbmUoKSArXG4gIHNjYWxlX3hfZGF0ZShicmVha3MgPSB3YWl2ZXIoKSwgZGF0ZV9icmVha3MgPSBcIjEgeWVhclwiLFxuICAgICAgICAgICAgICAgZGF0ZV9sYWJlbHMgPSBcIiViICVZXCIpICtcbiAgdGhlbWVfYncoKSArIFxuICB0aGVtZShwYW5lbC5ncmlkLm1ham9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuZ3JpZC5taW5vciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmJhY2tncm91bmQgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBheGlzLmxpbmUgPSBlbGVtZW50X2xpbmUoY29sb3VyID0gXCJibGFja1wiKSkrXG4gIHRoZW1lKGF4aXMudGV4dC54ID0gZWxlbWVudF90ZXh0KGFuZ2xlID0gNDUsIGhqdXN0ID0gMSksXG4gICAgICAgIHBsb3QubWFyZ2luID0gbWFyZ2luKDAuMjUsIDAuNDUsIDAuMjUsIDAuMjUsIFwiaW5jaFwiKSkrXG4gIHRoZW1lKHN0cmlwLmJhY2tncm91bmQgPSBlbGVtZW50X3JlY3QoZmlsbCA9IFwid2hpdGVcIikpK1xuICBsYWJzKHRpdGxlID0gXCJCMk8gVG90YWwgRGlzc29sdmVkIFNvbGlkcyAobWcvTCkgZnJvbSAyMDExLTIwMjNcIixcbiAgICAgICBzdWJ0aXRsZSA9IFwiUG9zdC1RQzogRGF0YSBPdXRzaWRlIDItU2lnbWEgZnJvbSBNZWFuIGhhcyBiZWVuIFJlbW92ZWRcIikrXG4gIHhsYWIoXCJEYXRlXCIpK1xuICB5bGFiKFwiVG90YWwgRGlzc29sdmVkIFNvbGlkcyAobWcvTClcIilcbiMgU2F2ZSBwbG90XG5nZ3NhdmUoZmlsZW5hbWUgPSBcIlRvdGFsRGlzc29sdmVkU29saWRzUGxvdC1Qb3N0UUMucGRmXCIsIHBsb3QgPSBUb3RhbERpc3NvbHZlZFNvbGlkc1Bsb3RfUG9zdFFDLCBcbiAgICAgICBwYXRoID0gXCJGaWd1cmVzL0ZpZ3VyZXNfWVNJLzAyLVBvc3RRQ1Bsb3RzXCIpXG4gIFxuYGBgIn0= -->

```r
# line graph of every variable - facet wrapped 
AllVariablePlot_PostQC <- dfQCPivot %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  facet_wrap(~variable, ncol = 3, scales = "free")+
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O Water Quality by Variable from 2011-2023",
       subtitle = "Post-QC: Data Outside 2-Sigma from Mean has been Removed")+
  xlab("Date")+
  ylab("Nutrient Value")
# Save plot
ggsave(filename = "AllVariablePlot-PostQC.pdf", plot = AllVariablePlot_PostQC, 
       path = "Figures/Figures_YSI/02-PostQCPlots", height = 12, width = 10)

# line graph of temperature in fahrenheit
TempFPlot_PostQC <- dfQCPivot %>%
  filter(variable == "temp_f") %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O Temperature (ºF) from 2011-2023",
       subtitle = "Post-QC: Data Outside 2-Sigma from Mean has been Removed")+
  xlab("Date")+
  ylab("Temperature (ºF)")
# Save plot
ggsave(filename = "TempFPlot-PostQC.pdf", plot = TempFPlot_PostQC, 
       path = "Figures/Figures_YSI/02-PostQCPlots")

# line graph of temp in celcius
TempCPlot_PostQC <- dfQCPivot %>%
  filter(variable == "temp_c")%>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O Temperature (ºC) from 2011-2023",
       subtitle = "Post-QC: Data Outside 2-Sigma from Mean has been Removed")+
  xlab("Date")+
  ylab("Temperature (ºC)")
# Save plot
ggsave(filename = "TempCPlot-PostQC.pdf", plot = TempCPlot_PostQC, 
       path = "Figures/Figures_YSI/02-PostQCPlots")

# line graph of pH in pH units
pHPlot_PostQC <- dfQCPivot %>%
  filter(variable == "pH") %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O pH from 2011-2023",
       subtitle = "Post-QC: Data Outside 2-Sigma from Mean has been Removed")+
  xlab("Date")+
  ylab("pH")
# Save plot
ggsave(filename = "pHPlot-PostQC.pdf", plot = pHPlot_PostQC, 
       path = "Figures/Figures_YSI/02-PostQCPlots")

# line graph of pH in mV
pHmVPlot_PostQC <- dfQCPivot %>%
  filter(variable == "pH_mV") %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O pH (mV) from 2011-2023",
       subtitle = "Post-QC: Data Outside 2-Sigma from Mean has been Removed")+
  xlab("Date")+
  ylab("pH (mV)")
# Save plot
ggsave(filename = "pHmVPlot-PostQC.pdf", plot = pHmVPlot_PostQC, 
       path = "Figures/Figures_YSI/02-PostQCPlots")

# line graph of salinity in psu
SalinityPlot_PostQC <- dfQCPivot %>%
  filter(variable == "salinity_psu")%>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O Salinity (PSU) from 2011-2023",
       subtitle = "Post-QC: Data Outside 2-Sigma from Mean has been Removed")+
  xlab("Date")+
  ylab("Salinity (PSU)")
# Save plot
ggsave(filename = "SalinityPlot-PostQC.pdf", plot = SalinityPlot_PostQC, 
       path = "Figures/Figures_YSI/02-PostQCPlots")

# line graph of conductivity in uS/cm
ConductivityPlot_PostQC <- dfQCPivot %>%
  filter(variable == "conductivity_uScm")%>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O Conductivity (µS/cm) from 2011-2023",
       subtitle = "Post-QC: Data Outside 2-Sigma from Mean has been Removed")+
  xlab("Date")+
  ylab("Conductivity (µS/cm)")
# Save plot
ggsave(filename = "ConductivityPlot-PostQC.pdf", plot = ConductivityPlot_PostQC, 
       path = "Figures/Figures_YSI/02-PostQCPlots")

# line graph of nlf conductivity in uS/cm
NLFConductivityPlot_PostQC <- dfQCPivot %>%
  filter(variable == "nlf_conductivity_uScm") %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O NLF Conductivity (µS/cm) from 2011-2023",
       subtitle = "Post-QC: Data Outside 2-Sigma from Mean has been Removed")+
  xlab("Date")+
  ylab("NLF Conductivity (µS/cm)")
# Save plot
ggsave(filename = "NLFConductivityPlot-PostQC.pdf", plot = NLFConductivityPlot_PostQC, 
       path = "Figures/Figures_YSI/02-PostQCPlots")

# line graph of specific conductivity in uS/cm
SpConductivityPlot_PostQC <- dfQCPivot %>%
  filter(variable == "sp_conductivity_uScm") %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O Specific Conductivity (µS/cm) from 2011-2023",
       subtitle = "Post-QC: Data Outside 2-Sigma from Mean has been Removed")+
  xlab("Date")+
  ylab("Specific Conductivity (µS/cm)")
# Save plot
ggsave(filename = "SpConductivityPlot-PostQC.pdf", plot = SpConductivityPlot_PostQC,
       path = "Figures/Figures_YSI/02-PostQCPlots")

# line graph of DO in mg/L
DOmgLPlot_PostQC <- dfQCPivot %>%
  filter(variable == "do_mgL") %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O Dissolved Oxygen (mg/L) from 2011-2023",
       subtitle = "Post-QC: Data Outside 2-Sigma from Mean has been Removed")+
  xlab("Date")+
  ylab("Dissolved Oxygen (mg/L)")
# Save plot
ggsave(filename = "DOmgLPlot-PostQC.pdf", plot = DOmgLPlot_PostQC, 
       path = "Figures/Figures_YSI/02-PostQCPlots")

# line graph of DO in percent saturated
DOPercentSaturatedPlot_PostQC <- dfQCPivot %>%
  filter(variable == "do_saturated_percent") %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O Saturated Dissolved Oxygen (%) from 2011-2023",
       subtitle = "Post-QC: Data Outside 2-Sigma from Mean has been Removed")+
  xlab("Date")+
  ylab("Saturated Dissolved Oxygen (%)")
# Save plot
ggsave(filename = "DOPercentSaturatedPlot-PostQC.pdf", plot = DOPercentSaturatedPlot_PostQC, 
       path = "Figures/Figures_YSI/02-PostQCPlots")

# line graph of DO in percent local
DOPercentLocalPlot_PostQC <- dfQCPivot %>%
  filter(variable == "do_local_percent") %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O Local Dissolved Oxygen (%) from 2011-2023",
       subtitle = "Post-QC: Data Outside 2-Sigma from Mean has been Removed")+
  xlab("Date")+
  ylab("Local Dissolved Oxygen (%)")
# Save plot
ggsave(filename = "DOPercentLocalPlot-PostQC.pdf", plot = DOPercentLocalPlot_PostQC,
       path = "Figures/Figures_YSI/02-PostQCPlots")

# line graph of ORP in mV
ORPPlot_PostQC <- dfQCPivot %>%
  filter(variable == "orp_mV") %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O ORP (mV) from 2011-2023",
       subtitle = "Post-QC: Data Outside 2-Sigma from Mean has been Removed")+
  xlab("Date")+
  ylab("ORP (mV)")
# Save plot
ggsave(filename = "ORPPlot-PostQC.pdf", plot = ORPPlot_PostQC, 
       path = "Figures/Figures_YSI/02-PostQCPlots")

# line graph of chlorophyll in RFU
ChlorophyllRFUPlot_PostQC <- dfQCPivot %>%
  filter(variable == "chlorophyll_rfu") %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O Chlorophyll (RFU) from 2011-2023",
       subtitle = "Post-QC: Data Outside 2-Sigma from Mean has been Removed")+
  xlab("Date")+
  ylab("Chlorophyll (RFU)")
# Save plot
ggsave(filename = "ChlorophyllRFUPlot-PostQC.pdf", plot = ChlorophyllRFUPlot_PostQC,
       path = "Figures/Figures_YSI/02-PostQCPlots")

# line graph of chlorophyll in ug/L
ChlorophyllugLPlot_PostQC <- dfQCPivot %>%
  filter(variable == "chlorophyll_ugL") %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O Chlorophyll (µg/L) from 2011-2023",
       subtitle = "Post-QC: Data Outside 2-Sigma from Mean has been Removed")+
  xlab("Date")+
  ylab("Chlorophyll (µg/L)")
# Save plot
ggsave(filename = "ChlorophyllugLPlot-PostQC.pdf", plot = ChlorophyllugLPlot_PostQC,
       path = "Figures/Figures_YSI/02-PostQCPlots")

# line graph of total algae in cells/L
TotalAlgaePlot_PostQC <- dfQCPivot %>%
  filter(variable == "total_algae_cellsL") %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O Total Algae (cells/L) from 2011-2023",
       subtitle = "Post-QC: Data Outside 2-Sigma from Mean has been Removed")+
  xlab("Date")+
  ylab("Total Algae (cells/L)")
# Save plot
ggsave(filename = "TotalAlgaePlot-PostQC.pdf", plot = TotalAlgaePlot_PostQC, 
       path = "Figures/Figures_YSI/02-PostQCPlots")

# line graph of total dissolved solids in mg/L
TotalDissolvedSolidsPlot_PostQC <- dfQCPivot %>%
  filter(variable == "total_dissolved_solids_mgL") %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O Total Dissolved Solids (mg/L) from 2011-2023",
       subtitle = "Post-QC: Data Outside 2-Sigma from Mean has been Removed")+
  xlab("Date")+
  ylab("Total Dissolved Solids (mg/L)")
# Save plot
ggsave(filename = "TotalDissolvedSolidsPlot-PostQC.pdf", plot = TotalDissolvedSolidsPlot_PostQC, 
       path = "Figures/Figures_YSI/02-PostQCPlots")
  
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


## After Cutoff Values were Implemented

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBqdXN0IHBsb3R0aW5nIEFsbCBWYXJpYWJsZXMsIHBILCBTYWxpbml0eSBQU1UsIGFuZCBUZW1wIEMgc2luY2UgdGhvc2Ugd2VyZSB0aGUgb25seSB2YXJpYWJsZXMgdGhhdCB3ZXJlIGNoYW5nZWQgd2l0aCB0aGUgY3V0b2ZmIHZhbHVlc1xuIyBsaW5lIGdyYXBoIG9mIGV2ZXJ5IHZhcmlhYmxlIC0gZmFjZXQgd3JhcHBlZCBcbkFsbFZhcmlhYmxlUGxvdF9Qb3N0UUNDdXRvZmYgPC0gZGZRQ0N1dFBpdm90ICU+JVxuICBnZ3Bsb3QoYWVzKHggPSBkYXRlLCBcbiAgICAgICAgICAgICB5ID0gdmFyaWFibGVfdmFsdWUpKSArXG4gIGdlb21fbGluZSgpICtcbiAgZmFjZXRfd3JhcCh+dmFyaWFibGUsIG5jb2wgPSAzLCBzY2FsZXMgPSBcImZyZWVcIikrXG4gIHNjYWxlX3hfZGF0ZShicmVha3MgPSB3YWl2ZXIoKSwgZGF0ZV9icmVha3MgPSBcIjEgeWVhclwiLFxuICAgICAgICAgICAgICAgZGF0ZV9sYWJlbHMgPSBcIiViICVZXCIpICtcbiAgdGhlbWVfYncoKSArIFxuICB0aGVtZShwYW5lbC5ncmlkLm1ham9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuZ3JpZC5taW5vciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmJhY2tncm91bmQgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBheGlzLmxpbmUgPSBlbGVtZW50X2xpbmUoY29sb3VyID0gXCJibGFja1wiKSkrXG4gIHRoZW1lKGF4aXMudGV4dC54ID0gZWxlbWVudF90ZXh0KGFuZ2xlID0gNDUsIGhqdXN0ID0gMSksXG4gICAgICAgIHBsb3QubWFyZ2luID0gbWFyZ2luKDAuMjUsIDAuNDUsIDAuMjUsIDAuMjUsIFwiaW5jaFwiKSkrXG4gIHRoZW1lKHN0cmlwLmJhY2tncm91bmQgPSBlbGVtZW50X3JlY3QoZmlsbCA9IFwid2hpdGVcIikpK1xuICBsYWJzKHRpdGxlID0gXCJCMk8gV2F0ZXIgUXVhbGl0eSBieSBWYXJpYWJsZSBmcm9tIDIwMTEtMjAyM1wiLFxuICAgICAgIHN1YnRpdGxlID0gXCJQb3N0LVFDIGFuZCBDdXRvZmZzOiBEYXRhIE91dHNpZGUgMi1TaWdtYSBmcm9tIE1lYW4gYW5kIEN1dG9mZiBWYWx1ZXMgaGF2ZSBiZWVuIFJlbW92ZWRcXG5wSCA8IDcuNTsgU2FsaW5pdHkgKFBTVSkgPCAyMTsgVGVtcCAowrpDKSA8IDIwIGFuZCA+IDI4XCIpK1xuICB4bGFiKFwiRGF0ZVwiKStcbiAgeWxhYihcIk51dHJpZW50IFZhbHVlXCIpXG4jIFNhdmUgcGxvdFxuZ2dzYXZlKGZpbGVuYW1lID0gXCJBbGxWYXJpYWJsZVBsb3QtUG9zdFFDQ3V0b2ZmLnBkZlwiLCBcbiAgICAgICBwbG90ID0gQWxsVmFyaWFibGVQbG90X1Bvc3RRQ0N1dG9mZiwgXG4gICAgICAgcGF0aCA9IFwiRmlndXJlcy9GaWd1cmVzX1lTSS8wMi1Qb3N0UUNQbG90c1wiLCBoZWlnaHQgPSAxMiwgd2lkdGggPSAxMClcblxuIyBsaW5lIGdyYXBoIG9mIHRlbXAgaW4gY2VsY2l1c1xuVGVtcENQbG90X1Bvc3RRQ0N1dG9mZiA8LSBkZlFDQ3V0UGl2b3QgJT4lXG4gIGZpbHRlcih2YXJpYWJsZSA9PSBcInRlbXBfY1wiKSU+JVxuICBnZ3Bsb3QoYWVzKHggPSBkYXRlLCBcbiAgICAgICAgICAgICB5ID0gdmFyaWFibGVfdmFsdWUpKSArXG4gIGdlb21fbGluZSgpICtcbiAgc2NhbGVfeF9kYXRlKGJyZWFrcyA9IHdhaXZlcigpLCBkYXRlX2JyZWFrcyA9IFwiMSB5ZWFyXCIsXG4gICAgICAgICAgICAgICBkYXRlX2xhYmVscyA9IFwiJWIgJVlcIikgK1xuICB0aGVtZV9idygpICsgXG4gIHRoZW1lKHBhbmVsLmdyaWQubWFqb3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5ncmlkLm1pbm9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuYmFja2dyb3VuZCA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIGF4aXMubGluZSA9IGVsZW1lbnRfbGluZShjb2xvdXIgPSBcImJsYWNrXCIpKStcbiAgdGhlbWUoYXhpcy50ZXh0LnggPSBlbGVtZW50X3RleHQoYW5nbGUgPSA0NSwgaGp1c3QgPSAxKSxcbiAgICAgICAgcGxvdC5tYXJnaW4gPSBtYXJnaW4oMC4yNSwgMC40NSwgMC4yNSwgMC4yNSwgXCJpbmNoXCIpKStcbiAgdGhlbWUoc3RyaXAuYmFja2dyb3VuZCA9IGVsZW1lbnRfcmVjdChmaWxsID0gXCJ3aGl0ZVwiKSkrXG4gIGxhYnModGl0bGUgPSBcIkIyTyBUZW1wZXJhdHVyZSAowrpDKSBmcm9tIDIwMTEtMjAyM1wiLFxuICAgICAgIHN1YnRpdGxlID0gXCJQb3N0LVFDIGFuZCBDdXRvZmZzOiBEYXRhIE91dHNpZGUgMi1TaWdtYSBmcm9tIE1lYW4gYW5kIEN1dG9mZiBWYWx1ZXMgaGF2ZSBiZWVuIFJlbW92ZWRcXG5WYWx1ZXMgTGVzcyBUaGFuIDIwIGFuZCBHcmVhdGVyIFRoYW4gMjggUmVtb3ZlZFwiKStcbiAgeGxhYihcIkRhdGVcIikrXG4gIHlsYWIoXCJUZW1wZXJhdHVyZSAowrpDKVwiKVxuIyBTYXZlIHBsb3Rcbmdnc2F2ZShmaWxlbmFtZSA9IFwiVGVtcENQbG90LVBvc3RRQ0N1dG9mZi5wZGZcIiwgcGxvdCA9IFRlbXBDUGxvdF9Qb3N0UUNDdXRvZmYsIFxuICAgICAgIHBhdGggPSBcIkZpZ3VyZXMvRmlndXJlc19ZU0kvMDItUG9zdFFDUGxvdHNcIilcblxuIyBsaW5lIGdyYXBoIG9mIHBIIGluIHBIIHVuaXRzXG5wSFBsb3RfUG9zdFFDQ3V0b2ZmIDwtIGRmUUNDdXRQaXZvdCAlPiVcbiAgZmlsdGVyKHZhcmlhYmxlID09IFwicEhcIikgJT4lXG4gIGdncGxvdChhZXMoeCA9IGRhdGUsIFxuICAgICAgICAgICAgIHkgPSB2YXJpYWJsZV92YWx1ZSkpICtcbiAgZ2VvbV9saW5lKCkgK1xuICBzY2FsZV94X2RhdGUoYnJlYWtzID0gd2FpdmVyKCksIGRhdGVfYnJlYWtzID0gXCIxIHllYXJcIixcbiAgICAgICAgICAgICAgIGRhdGVfbGFiZWxzID0gXCIlYiAlWVwiKSArXG4gIHRoZW1lX2J3KCkgKyBcbiAgdGhlbWUocGFuZWwuZ3JpZC5tYWpvciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmdyaWQubWlub3IgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBwYW5lbC5iYWNrZ3JvdW5kID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgYXhpcy5saW5lID0gZWxlbWVudF9saW5lKGNvbG91ciA9IFwiYmxhY2tcIikpK1xuICB0aGVtZShheGlzLnRleHQueCA9IGVsZW1lbnRfdGV4dChhbmdsZSA9IDQ1LCBoanVzdCA9IDEpLFxuICAgICAgICBwbG90Lm1hcmdpbiA9IG1hcmdpbigwLjI1LCAwLjQ1LCAwLjI1LCAwLjI1LCBcImluY2hcIikpK1xuICB0aGVtZShzdHJpcC5iYWNrZ3JvdW5kID0gZWxlbWVudF9yZWN0KGZpbGwgPSBcIndoaXRlXCIpKStcbiAgbGFicyh0aXRsZSA9IFwiQjJPIHBIIGZyb20gMjAxMS0yMDIzXCIsXG4gICAgICAgc3VidGl0bGUgPSBcIlBvc3QtUUMgYW5kIEN1dG9mZnM6IERhdGEgT3V0c2lkZSAyLVNpZ21hIGZyb20gTWVhbiBhbmQgQ3V0b2ZmIFZhbHVlcyBoYXZlIGJlZW4gUmVtb3ZlZFxcblZhbHVlcyBMZXNzIFRoYW4gNy41IFJlbW92ZWRcIikrXG4gIHhsYWIoXCJEYXRlXCIpK1xuICB5bGFiKFwicEhcIilcbiMgU2F2ZSBwbG90XG5nZ3NhdmUoZmlsZW5hbWUgPSBcInBIUGxvdC1Qb3N0UUNDdXRvZmYucGRmXCIsIHBsb3QgPSBwSFBsb3RfUG9zdFFDQ3V0b2ZmLCBcbiAgICAgICBwYXRoID0gXCJGaWd1cmVzL0ZpZ3VyZXNfWVNJLzAyLVBvc3RRQ1Bsb3RzXCIpXG5cbiMgbGluZSBncmFwaCBvZiBzYWxpbml0eSBpbiBwc3VcblNhbGluaXR5UGxvdF9Qb3N0UUNDdXRvZmYgPC0gZGZRQ0N1dFBpdm90ICU+JVxuICBmaWx0ZXIodmFyaWFibGUgPT0gXCJzYWxpbml0eV9wc3VcIiklPiVcbiAgZ2dwbG90KGFlcyh4ID0gZGF0ZSwgXG4gICAgICAgICAgICAgeSA9IHZhcmlhYmxlX3ZhbHVlKSkgK1xuICBnZW9tX2xpbmUoKSArXG4gIHNjYWxlX3hfZGF0ZShicmVha3MgPSB3YWl2ZXIoKSwgZGF0ZV9icmVha3MgPSBcIjEgeWVhclwiLFxuICAgICAgICAgICAgICAgZGF0ZV9sYWJlbHMgPSBcIiViICVZXCIpICtcbiAgdGhlbWVfYncoKSArIFxuICB0aGVtZShwYW5lbC5ncmlkLm1ham9yID0gZWxlbWVudF9ibGFuaygpLCBcbiAgICAgICAgcGFuZWwuZ3JpZC5taW5vciA9IGVsZW1lbnRfYmxhbmsoKSwgXG4gICAgICAgIHBhbmVsLmJhY2tncm91bmQgPSBlbGVtZW50X2JsYW5rKCksIFxuICAgICAgICBheGlzLmxpbmUgPSBlbGVtZW50X2xpbmUoY29sb3VyID0gXCJibGFja1wiKSkrXG4gIHRoZW1lKGF4aXMudGV4dC54ID0gZWxlbWVudF90ZXh0KGFuZ2xlID0gNDUsIGhqdXN0ID0gMSksXG4gICAgICAgIHBsb3QubWFyZ2luID0gbWFyZ2luKDAuMjUsIDAuNDUsIDAuMjUsIDAuMjUsIFwiaW5jaFwiKSkrXG4gIHRoZW1lKHN0cmlwLmJhY2tncm91bmQgPSBlbGVtZW50X3JlY3QoZmlsbCA9IFwid2hpdGVcIikpK1xuICBsYWJzKHRpdGxlID0gXCJCMk8gU2FsaW5pdHkgKFBTVSkgZnJvbSAyMDExLTIwMjNcIixcbiAgICAgICBzdWJ0aXRsZSA9IFwiUG9zdC1RQyBhbmQgQ3V0b2ZmczogRGF0YSBPdXRzaWRlIDItU2lnbWEgZnJvbSBNZWFuIGFuZCBDdXRvZmYgVmFsdWVzIGhhdmUgYmVlbiBSZW1vdmVkXFxuVmFsdWVzIExlc3MgVGhhbiAyMSBSZW1vdmVkXCIpK1xuICB4bGFiKFwiRGF0ZVwiKStcbiAgeWxhYihcIlNhbGluaXR5IChQU1UpXCIpXG4jIFNhdmUgcGxvdFxuZ2dzYXZlKGZpbGVuYW1lID0gXCJTYWxpbml0eVBsb3QtUG9zdFFDQ3V0b2ZmLnBkZlwiLCBwbG90ID0gU2FsaW5pdHlQbG90X1Bvc3RRQ0N1dG9mZiwgXG4gICAgICAgcGF0aCA9IFwiRmlndXJlcy9GaWd1cmVzX1lTSS8wMi1Qb3N0UUNQbG90c1wiKVxuXG5gYGAifQ== -->

```r
# just plotting All Variables, pH, Salinity PSU, and Temp C since those were the only variables that were changed with the cutoff values
# line graph of every variable - facet wrapped 
AllVariablePlot_PostQCCutoff <- dfQCCutPivot %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  facet_wrap(~variable, ncol = 3, scales = "free")+
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O Water Quality by Variable from 2011-2023",
       subtitle = "Post-QC and Cutoffs: Data Outside 2-Sigma from Mean and Cutoff Values have been Removed\npH < 7.5; Salinity (PSU) < 21; Temp (ºC) < 20 and > 28")+
  xlab("Date")+
  ylab("Nutrient Value")
# Save plot
ggsave(filename = "AllVariablePlot-PostQCCutoff.pdf", 
       plot = AllVariablePlot_PostQCCutoff, 
       path = "Figures/Figures_YSI/02-PostQCPlots", height = 12, width = 10)

# line graph of temp in celcius
TempCPlot_PostQCCutoff <- dfQCCutPivot %>%
  filter(variable == "temp_c")%>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O Temperature (ºC) from 2011-2023",
       subtitle = "Post-QC and Cutoffs: Data Outside 2-Sigma from Mean and Cutoff Values have been Removed\nValues Less Than 20 and Greater Than 28 Removed")+
  xlab("Date")+
  ylab("Temperature (ºC)")
# Save plot
ggsave(filename = "TempCPlot-PostQCCutoff.pdf", plot = TempCPlot_PostQCCutoff, 
       path = "Figures/Figures_YSI/02-PostQCPlots")

# line graph of pH in pH units
pHPlot_PostQCCutoff <- dfQCCutPivot %>%
  filter(variable == "pH") %>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O pH from 2011-2023",
       subtitle = "Post-QC and Cutoffs: Data Outside 2-Sigma from Mean and Cutoff Values have been Removed\nValues Less Than 7.5 Removed")+
  xlab("Date")+
  ylab("pH")
# Save plot
ggsave(filename = "pHPlot-PostQCCutoff.pdf", plot = pHPlot_PostQCCutoff, 
       path = "Figures/Figures_YSI/02-PostQCPlots")

# line graph of salinity in psu
SalinityPlot_PostQCCutoff <- dfQCCutPivot %>%
  filter(variable == "salinity_psu")%>%
  ggplot(aes(x = date, 
             y = variable_value)) +
  geom_line() +
  scale_x_date(breaks = waiver(), date_breaks = "1 year",
               date_labels = "%b %Y") +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black"))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.margin = margin(0.25, 0.45, 0.25, 0.25, "inch"))+
  theme(strip.background = element_rect(fill = "white"))+
  labs(title = "B2O Salinity (PSU) from 2011-2023",
       subtitle = "Post-QC and Cutoffs: Data Outside 2-Sigma from Mean and Cutoff Values have been Removed\nValues Less Than 21 Removed")+
  xlab("Date")+
  ylab("Salinity (PSU)")
# Save plot
ggsave(filename = "SalinityPlot-PostQCCutoff.pdf", plot = SalinityPlot_PostQCCutoff, 
       path = "Figures/Figures_YSI/02-PostQCPlots")

```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->

