#' Precipitation anomaly in the last 100 days for a given weather station
#'
#' @param station Station name from DWD (German Weather Service)
#' @param days How many days (backweards from today) should be considered? Delaut = 100 days.
#'
#' @return A table. tbc.
#' @export
#'
#' @examples
prec_anomaly <- function(station, days = 100){


station_dwd <- selectDWD(station, res="daily", var="kl", per="hr")
data <- dataDWD(station_dwd, dir=tempdir())




df <- bind_rows(data[[1]], data[[2]]) %>%
	as_tibble() %>%
	distinct(MESS_DATUM, .keep_all = TRUE) %>%
	padr::pad() %>%
	janitor::clean_names()

return(tail(df))
}
