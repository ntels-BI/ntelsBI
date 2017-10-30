#' Coordinates Transformation about sp object function
#' @description 좌표계를 변환하는 함수로써, 디폴트로는 UTM-K(GRS-80) 좌표계를 WGS84 좌표계로 변환함
#' @param long input longitude vector
#' @param lat input latitude vector
#' @export
#' @example
#' exdata <- data.frame(long = c(1039197, 1041137, 1039216, 1037176), lat = c(1926417, 1927056, 1927526, 1924963)) # UTM-K(GRS-80)
#' spCoordinateTrans(exdata$long, exdata$lat) # WGS84

spCoordinateTrans <- function(long, lat,
                              from.crs = "+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +units=m +no_defs",
                              to.crs = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"){

  ## Pre
  stopifnot(require(sp)); stopifnot(require(tidyverse))

  ## Content
  xy <- data.frame(long = long, lat = lat)
  coordinates(xy) <- ~ long + lat

  from.crs <- CRS(from.crs)
  from.coordinates <- SpatialPoints(xy, proj4string = from.crs)

  to.crs <- CRS(to.crs)
  changed <- from.coordinates %>%
    spTransform(to.crs) %>%
    SpatialPoints %>%
    tbl_df

  ## Output
  return(changed)
}
