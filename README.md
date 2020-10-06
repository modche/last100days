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

# run simple example
library(last100days)
prec_anomaly("Freiburg", days = 90)
```
