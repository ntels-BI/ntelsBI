#' Coordinates Transformation about sp object function
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
  res <- sp::SpatialPoints(sp::spTransform(f_coordinates, sp::CRS(to.crs)))

  return(as.data.frame(res))

}
