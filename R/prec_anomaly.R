#' Precipitation anomaly in the last 100 days for a given weather station
#'
#' @description Find exact station names with \code{rdwd::findID("Berlin", exactmatch=FALSE)}.
#'
#' @param station Station name from DWD (German Weather Service)
#' @param days How many days (backweards from today) should be considered? Delaut = 100 days.
#'
#' @return A table. tbc.
#' @export
#'
#' @references See detailed station list from DWD here:
#'     ftp://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/daily/kl/historical/KL_Tageswerte_Beschreibung_Stationen.txt
#'
#' @examples
#' prec_anomaly("Freiburg")
#' prec_anomaly("Mannheim")
#' prec_anomaly("Koeln-Bonn")
#' prec_anomaly("Waltrop-Abdinghof")
prec_anomaly <- function(station, days = 100, quiet = TRUE){
require(magrittr, quietly = TRUE)
require(dplyr, quietly = TRUE)
require(lubridate, quietly = TRUE)


station_dwd <- rdwd::selectDWD(station, res="daily", var="kl", per="hr")
data <- rdwd::dataDWD(station_dwd, dir=tempdir(), quiet = quiet)




df <- bind_rows(data[[1]], data[[2]]) %>%
		tibble::as_tibble() %>%
		distinct(MESS_DATUM, .keep_all = TRUE) %>%
		padr::pad(interval = "days") %>%
		janitor::clean_names()

selected_doy <- lubridate::yday(tail(df$mess_datum,1))-1

df2 <- df %>% select(mess_datum, rain=rsk) %>%
	#filter(mess_datum > '1951-10-04 00:00:00') %>%
	mutate(period = days) %>%
	mutate(prec_period = zoo::rollsum(rain, days, fill=NA, align="right", na.rm=T)) %>%
	mutate(doy=yday(mess_datum)) %>%
	filter(doy == selected_doy) %>%
	mutate(prec_mean = mean(prec_period, na.rm = TRUE)) %>%
	mutate(ratio = prec_period / prec_mean)






return(tail(df2))
}
