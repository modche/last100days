#' Precipitation anomaly in the last 100 days for a given weather station
#'
#' @description Find exact station names with \code{rdwd::findID("Berlin", exactmatch=FALSE)}.
#'
#' @param station Station name from DWD (German Weather Service)
#' @param days How many days (backwards from today) should be considered? Default = 100 days.
#'      Values smaller than 14 days not recommended.
#' @param quiet If \code{TRUE} (default) messages from \code{rdwd} are suppressed.
#'
#' @return A table. tbc.
#' @export
#'
#' @references See detailed station list from DWD [here](ftp://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/daily/kl/historical/KL_Tageswerte_Beschreibung_Stationen.txt)
#'
#' @examples
#' prec_anomaly("Freiburg", days = 365)
#' prec_anomaly("Mannheim")
#' prec_anomaly("Koeln-Bonn")
#' prec_anomaly("Waltrop-Abdinghof", days = 2000)
prec_anomaly <- function(station, days = 100, quiet = TRUE){
require(magrittr, quietly = TRUE)
require(dplyr, quietly = TRUE)
require(lubridate, quietly = TRUE)


station_dwd <- rdwd::selectDWD(station, res="daily", var="kl", per="hr")
data <- rdwd::dataDWD(station_dwd, dir=tempdir(), quiet = quiet)

if (days < 14) {
	warning("Period is set to 14 days.")
	days <- 14
}

df <- bind_rows(data[[1]], data[[2]]) %>%
		tibble::as_tibble() %>%
		distinct(MESS_DATUM, .keep_all = TRUE) %>%
		padr::pad(interval = "days") %>%
		janitor::clean_names()

selected_doy <- lubridate::yday(tail(df$mess_datum,1))

df2 <- df %>% select(mess_datum, rain_daily=rsk) %>%
	#filter(mess_datum > '1951-10-04 00:00:00') %>%
	mutate(period = days) %>%
	mutate(prec_period = zoo::rollsum(rain_daily, days, fill=NA, align="right", na.rm=T)) %>%
	mutate(doy=yday(mess_datum)) %>%
	filter(doy == selected_doy, prec_period > 0) %>%
	mutate(prec_mean = mean(prec_period, na.rm = TRUE)) %>%
	mutate(ratio = prec_period / prec_mean)






return(rbind(head(df2),sample_n(df2,size = 6),tail(df2)))
}
