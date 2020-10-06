# R package `last100days`

> How abnormal was the weather in the last 100 days?

### Introduction

Do you know these statements: "Oh, this summer was the driest I have ever seen in my life!" or "The rainfall amount in the last two weeks is absolutely a new record".

Hmm... I always have the impression that our memory is really biased towards recent weather events, i.e. every new season seems to be extreme in case of precipitation or temperature and a comparison with the past is seldom done.

The R package `last100days` calculates the anomaly of some climate variables for a given location and a given period.

-   climate variable: precipitation, (temperature)

-   locations: German weather stations from the German Weather Service (DWD)

The package uses the `rdwd` resources and other packages from the `tidyverse`.

### Installation

```{r}
# ----- package installation  -----
#install.packages("devtools")
devtools::github_install("modche/last100days")

# ----- run a simple example-----
library(last100days)
prec_anomaly("Freiburg", days = 90)
```

### Output

The table then shows the precipitation amount in the last 90 days and the precipitation amount in all corresponding periods in past years (number of years depends on station data). `ratio` just gives the ratio between this year precipitation in the last 90 days for a give year and the average precipitation sum in the period for all years.

| mess\_datum |  rain\_daily|  period|  prec\_period|  doy|  prec\_mean|      ratio|
|:------------|------------:|-------:|-------------:|----:|-----------:|----------:|
| 1874-10-06  |          0.8|      90|         278.1|  279|    267.2767|  1.0404949|
| 1875-10-06  |          0.0|      90|         264.8|  279|    267.2767|  0.9907337|
| 1876-10-05  |          0.0|      90|         387.1|  279|    267.2767|  1.4483120|
| 1877-10-06  |          0.0|      90|         260.4|  279|    267.2767|  0.9742714|
| 1878-10-06  |          0.0|      90|         415.7|  279|    267.2767|  1.5553172|
| 1879-10-06  |          0.3|      90|         353.4|  279|    267.2767|  1.3222254|
| 1971-10-06  |          0.0|      90|         207.1|  279|    267.2767|  0.7748525|
| 2002-10-06  |          9.6|      90|         297.3|  279|    267.2767|  1.1123305|
| 1901-10-06  |         10.8|      90|         347.2|  279|    267.2767|  1.2990285|
| 1881-10-06  |          4.9|      90|         445.5|  279|    267.2767|  1.6668122|
| 1998-10-06  |          1.9|      90|         265.9|  279|    267.2767|  0.9948493|
| 2020-10-05  |          0.8|      90|         170.0|  279|    267.2767|  0.6360450|
| 2015-10-06  |          6.6|      90|         176.6|  279|    267.2767|  0.6607386|
| 2016-10-05  |          0.0|      90|         113.1|  279|    267.2767|  0.4231570|
| 2017-10-06  |          0.6|      90|         268.8|  279|    267.2767|  1.0056995|
| 2018-10-06  |          0.0|      90|         128.5|  279|    267.2767|  0.4807752|
| 2019-10-06  |          6.8|      90|         262.0|  279|    267.2767|  0.9802577|
| 2020-10-05  |          0.8|      90|         170.0|  279|    267.2767|  0.6360450|
