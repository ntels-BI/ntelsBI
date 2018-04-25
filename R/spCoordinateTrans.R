#' Coordinates Transformation
#' @description 좌표계를 변환하는 함수로써, 디폴트로는 UTM-K(GRS-80) 좌표계를 WGS84 좌표계로 변환함
#' @param long input longitude vector
#' @param lat input latitude vector
#' @from.crs from crs formula input
#' @to.crs to crs formula input
#' @export
#' @examples
#' exdata <- data.frame(long = c(1039197, 1041137, 1039216, 1037176), lat = c(1926417, 1927056, 1927526, 1924963)) # UTM-K(GRS-80)
#' spCoordinateTrans(exdata$long, exdata$lat) # WGS84

spCoordinateTrans <- function(long, lat,
                              from.crs = "+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +units=m +no_defs",
                              to.crs = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"){

  xy <- data.frame(long = long, lat = lat)
  sp::coordinates(xy) <- ~ long + lat
  f_coordinates <- sp::SpatialPoints(xy, sp::CRS(from.crs))
  res <- sp::spTransform(f_coordinates, sp::CRS(to.crs))

  return(as.data.frame(res))

}

#' Address to Coordinates (WGS84)
#' @description Google maps 를 이용하여 주소정보를 대표좌표로 변환합니다.
#' @param address a character address
#' @export
#' @examples
#' addressToCoord("강남구청역")
#'
#' library(leaflet)
#' library(dplyr)
#'
#' pd <- data.frame(add = c("강남구청역")) %>%
#'   mutate(long = addressToCoord(add)[1], lat = addressToCoord(add)[2])
#'
#' leaflet(data = pd) %>% addTiles() %>%
#'   addMarkers(~long, ~lat, popup = ~as.character(add), label = ~as.character(add))

addressToCoord <- function(address, sleep_time = .2){

  url <- URLencode(paste("http://maps.google.com/maps/api/geocode/json?address=", address, "&sensor=false", sep = ""))
  x <- jsonlite::fromJSON(url)
  if(x$status == "OK") out <- c(x$results$geometry$location$lng, x$results$geometry$location$lat) else out <- NA
  Sys.sleep(sleep_time) # API only allows 5 requests per second
  return(out)

}
