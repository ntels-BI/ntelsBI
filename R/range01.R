#' Range scaling 0 to 1
#'
#' Range scaling 0 to 1
#' @param x numeric vector
#' @export
#' @examples
#' x <- c(0, 4, 7, 9, 10)
#' range01(x)
#' range01(x) * 100 # Standardization 0 to 100

range01 <- function(x, ...){(x - min(x, ...)) / (max(x, ...) - min(x, ...))}
